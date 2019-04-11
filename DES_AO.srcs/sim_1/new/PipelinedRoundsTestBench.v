`timescale 1ns / 1ps

module PipelinedRoundsTestBench;
    reg clk, reset;
    reg [0:63] key, dataIn;
    wire [0:63] dataOut;
    PipelinedRounds PR(
    .clk(clk),
    .reset(reset),
    .key(key),
    .dataIn(dataIn),
    .dataOut(dataOut)
    );
    always #5 clk = ~clk;
    initial begin
    reset = 1;
    clk = 0;
    dataIn = 64'h123456ABCD132536;
    key = 64'hAABB09182736CCDD;
    @(negedge clk);
    reset = 0;
    repeat(20) @(negedge clk);
    $finish;
    end
endmodule
