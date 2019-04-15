module Control #(
    clockFrequency=100_000_000, // Changing this may require changing the size of reg clockCounter in this module and UART modules
    baudRate=9600 // Changing this may require changing the size of reg clockCounter in this module and UART modules
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
    wire [0:keySize*8-1] key1, key2, key3;
    wire encrypt;
    // [1_dataLength,2_key1,3_key2,4_key3] Index represents sending order
    assign dataLength = head[0                           :(dataLengthSize          )*8-1];
    assign key1       = head[(dataLengthSize          )*8:(dataLengthSize+keySize  )*8-1];
    assign key2       = head[(dataLengthSize+keySize  )*8:(dataLengthSize+keySize*2)*8-1];
    assign key3       = head[(dataLengthSize+keySize*2)*8:(dataLengthSize+keySize*3)*8-1];
    assign encrypt = command == "E";

    reg [0:63] dataBlockIn;
    wire [0:63] dataBlockOut;
 
    TripleDES TDES(
        .clk(clk),
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
    
    UARTReceiver UR(
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data(receivedPacket),
        .packetRecievedSignal(packetRecievedSignal)
    );
    
    reg [0:7] transmitPacket;
    wire packetTransmittedSignal, startTransmition;
    
    UARTTransmiter UT(
        .clk(clk),
        .reset(reset),
        .transmit(startTransmition),
        .data(transmitPacket),
        .tx(tx),
        .packetTransmittedSignal(packetTransmittedSignal)
    );
    // Needed counters
    reg [0:dataLengthSize*8-1] dataPacketsCounter;
    reg [0:9] headPacketsCounter;
    reg [0:3] blockCounter;
    reg [0:7] pipelineCounter;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= waitingCommand;
            head <= 0;
            dataBlockIn <= 0;
            transmitPacket <= 0;
        end
    end
    always @(posedge packetRecievedSignal) begin
        case(state)
        waitingCommand: begin
            //Shift in command in head collection
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
                dataPacketsCounter <= dataLength;
                state <= receivingData;
            end
        end
        receivingData: begin
            dataPacketsCounter <= dataPacketsCounter - 1;
            // If we will finish after exiting this always block
            if(dataPacketsCounter == 1) begin
                state <= receivingData;
            end
        end
        pushingData: begin
            
        end
        receivingTransmittingData: begin
            
        end
        transmittingData: begin
            
        end
        endcase
    end
endmodule
