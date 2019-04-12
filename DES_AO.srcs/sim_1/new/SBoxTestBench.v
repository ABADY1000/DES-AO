`timescale 1ns / 1ps
module SBoxTestBench;

    reg [0:5] data;
    wire [0:3] result;
    
    S1 S(data, result);
    
    initial begin
    
    data = 6'b01_0011;
    
    #10;
    
    data = 6'b00_0110;
    
    #10;
    
    data = 6'b10_1100;
    
    #10;
    
    data = 6'b11_1111;
    
    end
endmodule
