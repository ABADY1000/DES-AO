`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 04:18:06 PM
// Design Name: 
// Module Name: TestSBoxes
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestSBoxes;

    reg [0:5] data;
    wire [0:3] result;
    
    S1 soso(data, result);
    
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
