`timescale 1ns / 1ps

module Interface(
    input clk,
    input reset,
    input Rx,
    output Tx
);
parameter readingCommand = 3'b000; 
parameter readingKey1 = 3'b001;
parameter readingKey2 = 3'b010;
parameter readingKey3 = 3'b011;
parameter readingDataLength = 3'b100;
parameter readingData = 3'b101;

reg [0:2] readingState;

reg encrypt; // 1 Packet
reg [0:63] key1, key2, key3; // 8 Packets x 3
reg [0:23] dataLength; // 3 Packets
reg [0:63] dataIn; // 8 Packets at a time
reg pipelinePulse, sendPipelinePulse;
reg [0:2] readingCounter;
reg [0:5] transmittingDelay;
wire [0:63] dataOut;

reg transmit;
reg [0:7] UARTTransmitPacket;
wire [0:7] UARTRecievedPacket;
wire packetRecievedSignal, packetSentSignal;

TripleDES TDES(
    .clk(pipelinePulse),
    .reset(reset),
    .dataIn(dataIn),
    .key1(key1),
    .key2(key2),
    .key3(key3),
    .encrypt(encrypt),
    .dataOut(dataOut)
);

UARTReceiver UR(
    .clk(clk),
    .reset(reset),
    .RxD(Rx),
    .RxData(UARTRecievedPacket),
    .packetRecievedSignal(packetRecievedSignal)    
);
UARTTransmitter UT(
    .clk(clk),
    .reset(reset),
    .transmit(transmit),
    .data(UARTTransmitPacket),
    .TxD(Tx),
    .packetSentSignal(packetSentSignal)    
);

always @(posedge clk) begin
    if (reset) begin
        readingState <= 0;
        readingCounter <= 0;
        transmittingDelay <= 0;
    end
    else begin
        if (sendPipelinePulse && ~pipelinePulse) begin 
            pipelinePulse <= 1'b1;
            if (transmittingDelay < 54) begin
                transmittingDelay <= transmittingDelay + 1;
            end
        end
        else if (sendPipelinePulse && pipelinePulse) begin 
            pipelinePulse <= 1'b0;
            sendPipelinePulse <= 1'b0;
        end
        if(packetRecievedSignal) begin
            case(readingState)
                readingCommand: begin
                    transmittingDelay <= 0;
                    case(UARTRecievedPacket)
                        8'd68: begin // Command == 'D'
                            encrypt <= 1'b0;
                            readingState <= readingKey1;
                            readingCounter <= 5'd7;
                        end
                        8'd69: begin // Command == 'E'
                            encrypt <= 1'b1;
                            readingState <= readingKey1;
                            readingCounter <= 3'd7;
                        end
                        default: readingState <= readingCommand;
                    endcase
                end
                readingKey1: begin
                    readingState <= readingKey1;
                    readingCounter <= readingCounter - 1;
                    case (readingCounter)
                        7: key1[0:7]   <= UARTRecievedPacket;
                        6: key1[8:15]  <= UARTRecievedPacket;
                        5: key1[16:23] <= UARTRecievedPacket;
                        4: key1[24:31] <= UARTRecievedPacket;
                        3: key1[32:39] <= UARTRecievedPacket;
                        2: key1[40:47] <= UARTRecievedPacket;
                        1: key1[48:55] <= UARTRecievedPacket;
                        0: begin
                            key1[56:63] <= UARTRecievedPacket;
                            readingCounter <= 3'd7;
                            readingState <= readingKey2;
                        end
                    endcase
                end
                readingKey2: begin
                    readingState <= readingKey2;
                    readingCounter <= readingCounter - 1;
                    case (readingCounter)
                        7: key2[0:7]   <= UARTRecievedPacket;
                        6: key2[8:15]  <= UARTRecievedPacket;
                        5: key2[16:23] <= UARTRecievedPacket;
                        4: key2[24:31] <= UARTRecievedPacket;
                        3: key2[32:39] <= UARTRecievedPacket;
                        2: key2[40:47] <= UARTRecievedPacket;
                        1: key2[48:55] <= UARTRecievedPacket;
                        0: begin
                            key2[56:63] <= UARTRecievedPacket;
                            readingCounter <= 3'd7;
                            readingState <= readingKey3;
                        end
                    endcase
                end
                readingKey3: begin
                    readingState <= readingKey3;
                    readingCounter <= readingCounter - 1;
                    case (readingCounter)
                        7: key3[0:7]   <= UARTRecievedPacket;
                        6: key3[8:15]  <= UARTRecievedPacket;
                        5: key3[16:23] <= UARTRecievedPacket;
                        4: key3[24:31] <= UARTRecievedPacket;
                        3: key3[32:39] <= UARTRecievedPacket;
                        2: key3[40:47] <= UARTRecievedPacket;
                        1: key3[48:55] <= UARTRecievedPacket;
                        0: begin
                            key3[56:63] <= UARTRecievedPacket;
                            readingCounter <= 3'd2;
                            readingState <= readingDataLength;
                        end
                    endcase
                end
                readingDataLength: begin
                    readingCounter <= readingCounter - 1;
                    readingState <= readingDataLength;
                    case (readingCounter)
                        2: dataLength[0:7] <= UARTRecievedPacket;
                        1: dataLength[8:15] <= UARTRecievedPacket;
                        0: begin
                            readingCounter <= 3'd7;
                            dataLength[16:23] <= UARTRecievedPacket;
                            readingState <= readingData;
                        end
                    endcase
                end
                readingData: begin
                    readingCounter <= readingCounter - 1;
                    readingState <= readingData;
                    case (readingCounter)
                        7: dataIn[0:7]   <= UARTRecievedPacket;
                        6: dataIn[8:15]  <= UARTRecievedPacket;
                        5: dataIn[16:23] <= UARTRecievedPacket;
                        4: dataIn[24:31] <= UARTRecievedPacket;
                        3: dataIn[32:39] <= UARTRecievedPacket;
                        2: dataIn[40:47] <= UARTRecievedPacket;
                        1: dataIn[48:55] <= UARTRecievedPacket;
                        0: begin
                            // Should agree on how dataLength % 8 is handled
                            // The below implementation simply ignores the remainder.
                            sendPipelinePulse = 1'b1;
                            dataLength <= dataLength - 8;
                            dataIn[56:63] <= UARTRecievedPacket;
                            readingCounter <= 3'd7;
                            if(dataLength < 16) begin
                                dataLength <= 0;
                                readingState <= readingCommand;
                            end
                            else readingState <= readingData;
                        end
                    endcase
                end
            endcase
        end
    end
end
endmodule
