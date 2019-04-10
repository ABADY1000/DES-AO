`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 05:24:22 PM
// Design Name: 
// Module Name: TestSBoxes_Full
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


module TestSBoxes_Full;
    
    reg [0:47] dataIn;
    wire [0:31] dataOut;
    
    SBoxes sb(dataIn, dataOut);
    
    initial begin
        # 100;
        dataIn = 47'D163169927772496;
        #100;
        dataIn = 47'D158169297111021;
        #100;
    end

endmodule
