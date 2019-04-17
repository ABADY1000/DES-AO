`timescale 1ns / 1ps
module SegDisplayTestBench;
    reg clk, reset;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    SegDisplayFPGATest SD(clk,reset,seg,an,dp);
    always #5 clk = ~clk;
    initial begin
        reset = 1;
        clk = 0;
        @(negedge clk);
        reset = 0;
        repeat (100_000_0000) @(negedge clk);
    end
endmodule
module SegDisplayFPGATest(
    input clk,
    input reset,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    input [3:0] sw
    );
    reg [0:30] clockCounter;
    
    wire [15:0] bcd;
    reg [12:0] count;
    
    BinaryToBCD2 BTBCD(
        .number(count),
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
    always @(posedge clk) begin
        if(reset) begin
            clockCounter <= 0;
            count <= 0;
        end else begin
            clockCounter <= clockCounter + 1;
            if (clockCounter[sw]) begin
                clockCounter <= 0;
                count <= count + 1;
            end
        end
    end
endmodule
