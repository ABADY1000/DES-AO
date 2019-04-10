`timescale 1ns / 1ps

module KeyRound #(shiftn=1)(
    input [27:0] leftIn,
    input [27:0] rightIn,
    output [27:0] leftOut,
    output [27:0] rightOut,
    output [47:0] key
    );
    wire [27:0] leftShifted, rightShifted;
    assign leftShifted  = {leftIn [27-shiftn:0],leftIn [27:27-shiftn+1]};
    assign rightShifted = {rightIn[27-shiftn:0],rightIn[27:27-shiftn+1]};
    KeyCompressionTable KCT(
    .dataIn({leftShifted,rightShifted}),
    .dataOut(key)
    );
    assign leftOut  = leftShifted;
    assign rightOut = rightShifted;
endmodule
