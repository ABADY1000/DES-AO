`timescale 1ns / 1ps

module SBoxes(
    input [0:47] dataIn,
    output [0:31] dataOut
    );
    
    S1 s1(.dataIn(dataIn[0:5]), .dataOut(dataOut[0:3]));
    S2 s2(.dataIn(dataIn[6:11]), .dataOut(dataOut[4:7]));
    S3 s3(.dataIn(dataIn[12:17]), .dataOut(dataOut[8:11]));
    S4 s4(.dataIn(dataIn[18:23]), .dataOut(dataOut[12:15]));
    S5 s5(.dataIn(dataIn[24:29]), .dataOut(dataOut[16:19]));
    S6 s6(.dataIn(dataIn[30:35]), .dataOut(dataOut[20:23]));
    S7 s7(.dataIn(dataIn[36:41]), .dataOut(dataOut[24:27]));
    S8 s8(.dataIn(dataIn[42:47]), .dataOut(dataOut[28:31]));
    
endmodule
