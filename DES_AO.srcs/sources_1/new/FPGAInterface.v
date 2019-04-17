`timescale 1ns / 1ps
module FPGAInterface(
    input clk,
    input reset,
    input rx,
    output tx,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    reg clkDivider;
    wire [0:2] state;
    wire [0:23] dataPacketCounterDebug;
    wire [0:9] headPacketsCounterDebug;
    reg [0:25] clockCounter;
    reg [0:13] counter;
    
    FullTDESSystem #(.clockFrequency(50_000_000)) FTDESS(
        .clk(clkDivider),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .headPacketsCounterDebug(headPacketsCounterDebug),
        .dataPacketCounterDebug(dataPacketCounterDebug),
        .stateDebug(state)
    );
    wire [15:0] bcd;
    reg [0:13] binaryInput;
    assign bcd[15:12] = 0;
    BinaryToBCD2 BTBCD(
        .number(binaryInput),
        .ones(bcd[3:0]),
        .tens(bcd[7:4]),
        .hundreds(bcd[11:8])
    );
    
    DisplayBCD DBCD(
        .DataIn(bcd), 
        .clk(clk),
        .clr(reset),
        .seg(seg),
        .an(an),
        .dp(dp)
    );

    assign led = {13'd0,state};
    always @(posedge clk) begin
        clkDivider <= ~clkDivider;
        if(reset) begin
            clockCounter <= 0;
            counter <= 0;
        end
        else begin 
            clockCounter <= clockCounter + 1;
            if (clockCounter[4]) begin
                clockCounter <= 0;
                counter <= counter + 1;
            end
        end
    end
    
//    always @(*) begin
//        if(state == 3'b001) binaryInput = {4'd0 ,headPacketsCounterDebug};
//        else binaryInput = dataPacketCounterDebug[10:23];
//    end

endmodule
