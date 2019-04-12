`timescale 1ns / 1ps

module RoundTestBench;

    reg [0:31] dataLeft = 32'h14A7D678;
    reg [0:31] dataRight = 32'h18CA18AD;
    reg [0:47] key0 = 48'h194CD072DE8C;
    
    wire [0:31] data1l;
    wire [0:31] data1r;
    reg [0:47] key1 = 48'h4568581ABCCE;
    
    wire [0:31] data2l;
    wire [0:31] data2r;
    reg [0:47] key2 = 48'h06EDA4ACF5B5;
    
    wire [0:31] data3l;
    wire [0:31] data3r;
    reg [0:47] key3 = 48'hDA2D032B6EE3;
    
    Round r1(dataLeft, dataRight, key0, data1l, data1r);
    Round r2(data1r, data1l, key1, data2l, data2r);
    Round r3(data2r, data2l, key2, data3l, data3r);
    
    reg [0:3] a = 10'b0011;
    reg [3:0] b = 10'b0011;
    wire [9:0] xx ;
    
    initial begin
        #100;
        
    end
    
endmodule
