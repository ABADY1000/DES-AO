module UARTReciever #(
    clockFrequency=100_000_000, // Changing this may require changing the size of reg clockCounter
    baudRate=9600, // Changing this may require changing the size of reg clockCounter
    samplingRate=8 // Changing this may require changing the size of reg samplingCounter
    )(
    input clk,
    input reset,
    input rx,
    // To store full packet
    output reg [0:7] data,
    // Positive edge indicates that a new packet has been fully copied to data
    // Negative edge indicates that a new packet has just started being read
    // Read packet at positive edge or while the signal is high
    output reg packetRecievedSignal 
    );
    localparam waitingStartBit = 2'b00;
    localparam readingStartBit = 2'b01;
    localparam readingPacket = 2'b10;
    localparam waitingStopBit = 2'b11;
    
    localparam baudClockCount = clockFrequency / baudRate;
    localparam samplingClockCount = baudClockCount / samplingRate;
    localparam halfSamplingRate = samplingRate / 2;
    
    reg [0:14] clockCounter;
    reg [0:3] samplingCounter;
    reg [0:2] bitCounter;
    reg [0:1] state;
    always @(posedge clk) begin
        if(reset) begin
            //Reset all internal registers;
            clockCounter <= 0;
            samplingCounter <= 0;
            bitCounter <= 0;
            state <= 0;
        end
        else begin
            if(clockCounter == samplingClockCount)clockCounter <= 0;
            else clockCounter <= clockCounter + 1;
            
            case (state)
                waitingStartBit: begin
                    // Wait for rx to be low then start reading
                    if(~rx) begin
                        packetRecievedSignal <= 1'b0;
                        state <= readingStartBit;
                        clockCounter <= 0;
                    end
                end
                readingStartBit: begin
                    // Count half of sampling rate to be in the middle of the start bit
                    if(clockCounter == samplingClockCount) begin
                        samplingCounter <= samplingCounter + 1;
                        if(samplingCounter == halfSamplingRate-1) begin
                            samplingCounter <= 0;
                            state <= readingPacket;
                        end
                    end
                end
                readingPacket: begin
                    if(clockCounter == samplingClockCount) begin
                        samplingCounter <= samplingCounter + 1;
                        if(samplingCounter == samplingRate-1) begin
                            samplingCounter <= 0;
                            // Shift in the new rx
                            data <= {rx,data[0:6]};
                            bitCounter <= bitCounter + 1;
                            // If by the time the always finishes
                            // we would have read 8 bits
                            if(bitCounter == 3'b111) begin
                                // Cannot transition to initial state directly
                                // Because we might be in the middle of a low bit
                                state <= waitingStopBit;
                            end
                        end
                    end
                end
                waitingStopBit: begin
                    // If rx is high that means we are either at the last high bit
                    // Or we are at the stopping bit, either way we can transition
                    // Directly to the initial state
                    packetRecievedSignal <= 1'b1;
                    if(rx) begin
                        state <= waitingStartBit;
                    end
                end
            endcase
        end
    end 
endmodule
