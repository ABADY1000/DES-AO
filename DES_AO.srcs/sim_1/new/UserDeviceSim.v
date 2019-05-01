module UserDeviceSim
#(
    sendMessageSize = 28 + 8, // In bytes
    receiveMessageSize = 8, // In bytes
    clockFrequency = 100_000_000, // Changing this may require changing the size of reg clockCounter UART modules
    baudRate=9600, // Changing this may require changing the size of reg clockCounter in UART modules
    samplingRate=8 // Changing this may require changing the size of reg samplingCounter in UARTReceiver module
    )(
    input clk,
    input reset,
    input rx,
    output tx,
    input [0:8*sendMessageSize-1] messageToSend,
    output [0:8*receiveMessageSize-1]receivedMessage,
    output reg [0:1] state,
    input start
    );
    
    localparam waiting = 2'b00;
    localparam sending = 2'b01;
    localparam sendingReceiving = 2'b10;
    localparam receiving = 2'b11;
    reg [0:8*sendMessageSize-1] transmitBuffer;
    reg [0:8*receiveMessageSize-1] receiveBuffer;
    assign receivedMessage = receiveBuffer;
    wire [0:7] receivedPacket;
    wire [0:7] transmitPacket = transmitBuffer[0:7];
    wire packetReceivedSignal, packetTransmittedSignal;
    wire transmit = state == sending || state == sendingReceiving;
    
    reg [0:23] transmittedCounter, receivedCounter;
    
    UARTReceiver #(
        .clockFrequency(clockFrequency),
        .baudRate(baudRate),
        .samplingRate(samplingRate)
        ) UR (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data(receivedPacket),
        .packetRecievedSignal(packetReceivedSignal)
    );
    
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
    always @(*) begin
        if(transmittedCounter == 0 && receivedCounter == 0) state = waiting;
        else if(transmittedCounter > 0 && receivedCounter > 0) state = sendingReceiving;
        else if(transmittedCounter > 0) state = sending;
        else /*receivedCounter > 0*/state = receiving;
    end
    always @(posedge clk) begin
        if(reset) begin
            transmittedCounter <= 0;
            receivedCounter <= 0;
            transmitBuffer <= 0;
            receiveBuffer <= 0;
        end else begin
            case(state)
                waiting: begin
                    if(start) begin
                        transmitBuffer <= messageToSend;
                        transmittedCounter <= sendMessageSize;
                        receivedCounter <= receiveMessageSize;
                    end
                end
                sending: begin
                    if(packetTransmittedSignal) begin
                        transmittedCounter <= transmittedCounter - 1;
                        // Shift left
                        transmitBuffer <= {transmitBuffer[8:8*sendMessageSize-1],8'd0};
                    end
                end
                sendingReceiving: begin
                    if(packetReceivedSignal) begin
                        transmittedCounter <= transmittedCounter - 1;
                        // Shift left
                        transmitBuffer <= {transmitBuffer[8:8*sendMessageSize-1],8'd0};
                    end
                    if(packetReceivedSignal) begin
                        receivedCounter <= receivedCounter-1;
                        // Shift left
                        receiveBuffer <= {receiveBuffer[8:8*receiveMessageSize-1],receivedPacket};
                    end
                end
                receiving: begin 
                    if(packetReceivedSignal) begin
                        receivedCounter <= receivedCounter-1;
                        // Shift left
                        receiveBuffer <= {receiveBuffer[8:8*receiveMessageSize-1],receivedPacket};
                    end
                end
            endcase
        end
    end
endmodule
