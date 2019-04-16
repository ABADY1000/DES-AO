// This module needs to be better organized maybe even split into smaller modules
module FullTDESSystem #(
    clockFrequency=100_000_000, // Changing this may require changing the size of reg clockCounter UART modules
    baudRate=9600, // Changing this may require changing the size of reg clockCounter in UART modules
    samplingRate=8 // Changing this may require changing the size of reg samplingCounter in UARTReceiver module
    )(
    input clk,
    input reset,
    input rx,
    output tx
    );
    localparam baudClockCount = clockFrequency / baudRate;
    
    //----------------- State -------------------
    localparam waitingCommand = 3'b000;
    localparam receivingHead = 3'b001;
    localparam receivingData = 3'b010;
    localparam receivingTransmittingData = 3'b011;
    localparam transmittingData = 3'b100;
    localparam pushingData = 3'b101;
    reg [0:2] state;
    
    //----------------- 3DES -------------------
    localparam DESStages = 18; // 16 stages for rounds, initial, and final stage
    localparam dataLengthSize = 3; // 3 packets
    localparam keySize = 8; // 8 packets
    localparam headSize = dataLengthSize+keySize*3; // 27 Packet
    
    reg [0:headSize*8-1] head;
    reg [0:7] command;
    wire [0:dataLengthSize*8-1] dataLength;
    wire [0:dataLengthSize*8-1] forwardedDataLength;
    wire [0:keySize*8-1] key1, key2, key3;
    wire encrypt;
    // [1_dataLength,2_key1,3_key2,4_key3] Index represents sending order
    assign forwardedDataLength = head[8                  :(dataLengthSize+1        )*8-1];
    assign dataLength = head[0                           :(dataLengthSize          )*8-1];
    assign key1       = head[(dataLengthSize          )*8:(dataLengthSize+keySize  )*8-1];
    assign key2       = head[(dataLengthSize+keySize  )*8:(dataLengthSize+keySize*2)*8-1];
    assign key3       = head[(dataLengthSize+keySize*2)*8:(dataLengthSize+keySize*3)*8-1];
    assign encrypt = command == "E";

    reg [0:63] dataBlockIn;
    wire [0:63] dataBlockOut;
    reg buffered;
    reg pipelineClk;
    
    TripleDES TDES(
        .clk(pipelineClk),
        .reset(reset),
        .dataIn(dataBlockIn),
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .encrypt(encrypt),
        .dataOut(dataBlockOut)
    );
    
    //----------------- UART -------------------
    wire [0:7] receivedPacket;
    wire packetRecievedSignal;
    
    UARTReceiver #(
        .clockFrequency(clockFrequency),
        .baudRate(baudRate),
        .samplingRate(samplingRate)
        ) UR (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data(receivedPacket),
        .packetRecievedSignal(packetRecievedSignal)
    );
    
    reg [0:7] transmitPacket;
    wire packetTransmittedSignal;
    wire transmit = state == receivingTransmittingData || state == transmittingData;
    
    UARTTransmitter #(
        .clockFrequency(clockFrequency),
        .baudRate(baudRate)
        )UT(
        .clk(clk),
        .reset(reset),
        .transmit(transmit),
        .data(transmitPacket),
        .tx(tx),
        .packetTransmittedSignal(packetTransmittedSignal)
    );
    // Needed counters
    reg [0:dataLengthSize*8-1] dataPacketsCounter; // Counts down from the number of data packets that we should receive
    reg [0:9] headPacketsCounter; // Counts down from the number of packets  to be received to form the head (27 packets)
    reg [0:3] blockCounter; // Counts the number of packets received to form a block (8 packets)
    reg [0:6] pipelineCounter; // Counts the amount of data in the pipeline
    reg [0:6] pipelinePushCounter; // Counts the amount of pushes we need to get data to output

    always @(*) begin
        if (state == pushingData) pipelineClk = clk;
        else pipelineClk = blockCounter == 8;
        // Should replace with shift register as buffer
        case (blockCounter)
            0: transmitPacket = dataBlockOut[0:7];
            1: transmitPacket = dataBlockOut[8:15];
            2: transmitPacket = dataBlockOut[16:23];
            3: transmitPacket = dataBlockOut[24:7];
            4: transmitPacket = dataBlockOut[0:7];
            5: transmitPacket = dataBlockOut[0:7];
            6: transmitPacket = dataBlockOut[0:7];
            7: transmitPacket = dataBlockOut[0:7];
        endcase
    end
    always @(posedge clk) begin
        if(reset) begin
            state <= waitingCommand;
            head <= 0;
            dataBlockIn <= 0;
            dataPacketsCounter <= 0;
            headPacketsCounter <= 0;
            blockCounter <= 0;
            pipelineCounter <= 0;
            pipelinePushCounter <= 0;
        end else begin
            // If we have received or sent 8 packets (Pipeline Block)
            if(pipelineClk) begin
                blockCounter <= 0;
                //dataBlockOutBuffer <= dataBlockOut;
            end
            // Below is the state where receiving has stopped and we have to transmit what is left in the pipeline
            // This means we have to operate on packetTransmittedSignal
            if(state == transmittingData) begin
                if(packetTransmittedSignal) begin
                    blockCounter <= blockCounter + 1;
                    //dataBlockOutBuffer <= {dataBlockOutBuffer[8:63],8'd0};
                    if(blockCounter == 7) begin
                        pipelineCounter <= pipelineCounter - 1;
                        if(pipelineCounter == 0) begin
                            state <= waitingCommand;
                        end
                    end
                end
            end
            // Below is the state where receiving has stopped and our data is not ready yet to be transmitted
            // This means we should push it as fast as we can to be ready (No IO bottle neck)
            // Therefore we can operate on FPGA clk
            else if (state == pushingData) begin
                pipelinePushCounter <= pipelinePushCounter -1;
                if(pipelinePushCounter == 1) begin
                    state <= transmittingData;
                end
            end
            // Below are states that receive data
            // This means we have to operate on packetRecievedSignal for synchronization
            else begin
                if(packetRecievedSignal) begin
                    case(state)
                        waitingCommand: begin
                            // Shift in command in head collection
                            command <= receivedPacket;
                            state <= receivingHead;
                            headPacketsCounter <= headSize;
                        end
                        receivingHead: begin
                            // [1_dataLength,2_key1,3_key2,4_key3] Index represents sending order
                            // To achieve the above requirement we should shift left!
                            head <= {head[8:headSize*8-1],receivedPacket};
                            headPacketsCounter <= headPacketsCounter - 1;
                            // If we will finish after exiting this always block
                            if(headPacketsCounter == 1) begin
                                dataPacketsCounter <= forwardedDataLength;
                                state <= receivingData;
                            end
                        end
                        receivingData: begin
                            blockCounter <= blockCounter + 1;
                            dataPacketsCounter <= dataPacketsCounter - 1;
                            // [dataBlock1, dataBlock2, dataBlock3]
                            // To achieve the above requirement we should shift left!
                            dataBlockIn <= {dataBlockIn[8:63],receivedPacket};
                            // If we will finish receiving after exiting this always block
                            if(dataPacketsCounter == 1) begin
                                // Will the data reach the end of the pipeline after existing this always block?
                                if(pipelineCounter == DESStages*3-1) begin
                                    state <= transmittingData;
                                end
                                else begin
                                    // subtract one because by the time this finishes we would have sent one more block
                                    pipelinePushCounter <= DESStages*3-pipelineCounter-1; 
                                    state <= pushingData;
                                end
                            end
                            else if(pipelineCounter == DESStages*3-1) begin
                                state <= receivingTransmittingData;
                            end
                        end
                        receivingTransmittingData: begin
                            blockCounter <= blockCounter + 1;
                            // Shift left
                            dataBlockIn <= {dataBlockIn[8:63],receivedPacket};
                            // Shift left
                            //dataBlockOutBuffer <= {dataBlockOutBuffer[8:63],8'd0};
                            dataPacketsCounter <= dataPacketsCounter - 1;
                            if(dataPacketsCounter == 1) begin
                                state <= transmittingData;
                            end
                        end
                    endcase
                end
            end
            if(state == receivingData && pipelineClk) pipelineCounter <= pipelineCounter + 1;
        end
    end
endmodule
