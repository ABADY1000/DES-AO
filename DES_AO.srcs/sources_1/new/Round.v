`timescale 1ns / 1ps

module Round(
    input [0:31] leftIn,
    input [0:31] rightIn,
    input [0:47] key,
    output [0:31] leftOut,
    output [0:31] rightOut
    );
    
    assign rightOut = rightIn;
    
    wire [0:31] to_XOR;
    FFunction ff(rightIn, key, to_XOR);
    
    assign leftOut = to_XOR ^ leftIn;
    
    
endmodule

