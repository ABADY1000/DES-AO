`timescale 1ns / 1ps

module KeyRound #(shiftn=1)(
    input [0:27] leftIn,
    input [0:27] rightIn,
    output [0:27] leftOut,
    output [0:27] rightOut,
    output [0:47] key
    );
    wire [0:27] leftShifted, rightShifted;
    assign leftShifted  = {leftIn [shiftn:27],leftIn [0:shiftn-1]};
    assign rightShifted = {rightIn[shiftn:27],rightIn[0:shiftn-1]};
    KeyCompressionTable KCT(
    .dataIn({leftShifted,rightShifted}),
    .dataOut(key)
    );
    assign leftOut  = leftShifted;
    assign rightOut = rightShifted;
endmodule
