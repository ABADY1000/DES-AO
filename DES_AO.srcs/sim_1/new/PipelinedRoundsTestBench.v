`timescale 1ns / 1ps

module PipelinedRoundsTestBench;
    reg clk, reset, encrypt;
    reg [0:63] key, dataIn;
    wire [0:63] dataOut;
    PipelinedRounds PR(
    .clk(clk),
    .reset(reset),
    .key(key),
    .dataIn(dataIn),
    .dataOut(dataOut),
    .encrypt(encrypt)
    );
    always #5 clk = ~clk;
    initial begin
    reset = 1;
    clk = 0;
    encrypt = 1;
    dataIn = 64'h123456ABCD132536;
    key = 64'hAABB09182736CCDD;
    @(negedge clk);
    reset = 0;
    repeat(20) @(negedge clk);
    dataIn = 64'hC0B7A8D05F3A829C;
    encrypt = 0;
    repeat(20) @(negedge clk);
    $finish;
    end
endmodule
