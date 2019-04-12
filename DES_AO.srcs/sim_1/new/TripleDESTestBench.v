`timescale 1ns / 1ps

module TripleDESTestBench;
reg clk, reset, encrypt;
reg [0:63] dataIn, key1, key2, key3;
wire [0:63] dataOut;
TripleDES TDES(
    .clk(clk),
    .reset(reset),
    .dataIn(dataIn),
    .key1(key1),
    .key2(key2),
    .key3(key3),
    .encrypt(encrypt),
    .dataOut(dataOut)
);
always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    key1 = 64'h0123456789ABCDEF;
    key2 = 64'h23456789ABCDEF01;
    key3 = 64'h456789ABCDEF0123;
    @(negedge clk);
    reset = 0;
    //------------------Encryption--------------------
    encrypt = 1;
    dataIn = 64'h5468652071756663;
    // dataOut: A826FD8CE53B855F
    @(negedge clk);
    dataIn = 64'h6B2062726F776E20;
    // dataOut: CCE21C8112256FE6
    @(negedge clk);
    dataIn = 64'h666F78206A756D70;
    // dataOut: 68D5C05DD9B6B900
    repeat(54) @(negedge clk);
    //------------------Decryption--------------------
    encrypt = 0;
    dataIn = 64'hA826FD8CE53B855F;
    // dataOut: 5468652071756663
    @(negedge clk);
    dataIn = 64'hCCE21C8112256FE6;
    // dataOut: 6B2062726F776E20
    @(negedge clk);
    dataIn = 64'h68D5C05DD9B6B900;
    // dataOut: 666F78206A756D70
    repeat(54) @(negedge clk);
    $finish;
end
endmodule
