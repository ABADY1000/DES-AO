module UARTTransmitter #(
    clockFrequency=100_000_000, // Changing this may require changing the size of reg clockCounter
    baudRate=9600 // Changing this may require changing the size of reg clockCounter
    )(
    input clk,
    input reset,
    input transmit,
    input [0:7] data,
    output reg tx,
    // Goes high for one clock cycle (negative edge to negative edge
    // so it is guaranteed to be sampled exactly once at positive edge)
    // to indicate that a packet has been transmitted 
    // Does not wait for stop bit to be sent
    output reg packetTransmittedSignal
    );
    localparam waitingTransmitSignal = 0;
    localparam sendingPacket = 1;
    
    localparam baudClockCount = clockFrequency / baudRate;
    
    reg [0:9] rightshiftreg;
    reg [0:19] clockCounter;
    reg [0:3] bitCounter;
    reg state;
    reg didNotSendTransmittedSignal;
    
    always @(*) begin
        if(state == waitingTransmitSignal) tx = 1'b1;
        else tx = rightshiftreg[9];
    end
    
    always @(posedge clk) begin
        if(reset) begin
            rightshiftreg <= 0;
            clockCounter <= 0;
            bitCounter <= 0;
            state <= waitingTransmitSignal;
        end
        else begin
            if(clockCounter == baudClockCount)clockCounter <= 0;
            else clockCounter <= clockCounter + 1;
            case(state)
                waitingTransmitSignal: begin
                    rightshiftreg <= 10'b0_0000_0000_1;
                    if(transmit) begin
                        state <= sendingPacket;
                        clockCounter <= 0;
                        rightshiftreg <= {1'b1,data,1'b0};
                    end
                end
                sendingPacket: begin
                    if(clockCounter == baudClockCount) begin
                        didNotSendTransmittedSignal = 1'b1;
                        // Shift right
                        rightshiftreg <= {1'b0,rightshiftreg[0:8]};
                        bitCounter <= bitCounter + 1;
                        // If we are going to finish at the end of this always block
                        if(bitCounter == 4'd9) begin
                            bitCounter <= 0;
                            state <= waitingTransmitSignal;
                            // If we still want to transmit then start right away
                            // No need to go back to waitingTransmitSignal and waste a clock cycle
                            if(transmit) rightshiftreg <= {1'b1,data,1'b0};
                            else state <= waitingTransmitSignal;
                        end
                    end
                end
            endcase
        end
    end
    always @(negedge clk) begin
        packetTransmittedSignal = 1'b0;
        if(state == sendingPacket && clockCounter == baudClockCount
        && bitCounter == 4'd8 && didNotSendTransmittedSignal) begin
            didNotSendTransmittedSignal = 1'b0;
            packetTransmittedSignal = 1'b1;
        end
    end
endmodule
