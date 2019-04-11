`timescale 1ns / 1ps
module PipelinedRounds (
    input clk,
    input reset,
    input [0:63] dataIn,
    input [0:63] key,
    input encrypt,
    output [0:63] dataOut
    );
    wire [0:47] k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16;
    reg [0:47] ck1,ck2,ck3,ck4,ck5,ck6,ck7,ck8,ck9,ck10,ck11,ck12,ck13,ck14,ck15,ck16;
    wire [0:63] initPermOut, finalPermOut;
    wire [0:31] leftIn1, rightIn1,leftOut1, rightOut1;
    wire [0:31] leftIn2, rightIn2,leftOut2, rightOut2;
    wire [0:31] leftIn3, rightIn3,leftOut3, rightOut3;
    wire [0:31] leftIn4, rightIn4,leftOut4, rightOut4;
    wire [0:31] leftIn5, rightIn5,leftOut5, rightOut5;
    wire [0:31] leftIn6, rightIn6,leftOut6, rightOut6;
    wire [0:31] leftIn7, rightIn7,leftOut7, rightOut7;
    wire [0:31] leftIn8, rightIn8,leftOut8, rightOut8;
    wire [0:31] leftIn9, rightIn9,leftOut9, rightOut9;
    wire [0:31] leftIn10, rightIn10,leftOut10, rightOut10;
    wire [0:31] leftIn11, rightIn11,leftOut11, rightOut11;
    wire [0:31] leftIn12, rightIn12,leftOut12, rightOut12;
    wire [0:31] leftIn13, rightIn13,leftOut13, rightOut13;
    wire [0:31] leftIn14, rightIn14,leftOut14, rightOut14;
    wire [0:31] leftIn15, rightIn15,leftOut15, rightOut15;
    wire [0:31] leftIn16, rightIn16,leftOut16, rightOut16;
    wire [0:63] roundsOut, roundsIn;
    Round RND1(
        .leftIn(roundsIn[0:31]),
        .rightIn(roundsIn[32:63]),
        .key(ck1),
        .leftOut(leftOut1),
        .rightOut(rightOut1)
    );
    Register REG1(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut1,leftOut1}),
        .dataOut({leftIn2,rightIn2})
    );
    Round RND2(
        .leftIn(leftIn2),
        .rightIn(rightIn2),
        .key(ck2),
        .leftOut(leftOut2),
        .rightOut(rightOut2)
    );
    Register REG2(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut2,leftOut2}),
        .dataOut({leftIn3,rightIn3})
    );
    Round RND3(
        .leftIn(leftIn3),
        .rightIn(rightIn3),
        .key(ck3),
        .leftOut(leftOut3),
        .rightOut(rightOut3)
    );
    Register REG3(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut3,leftOut3}),
        .dataOut({leftIn4,rightIn4})
    );
    Round RND4(
        .leftIn(leftIn4),
        .rightIn(rightIn4),
        .key(ck4),
        .leftOut(leftOut4),
        .rightOut(rightOut4)
    );
    Register REG4(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut4,leftOut4}),
        .dataOut({leftIn5,rightIn5})
    );
    Round RND5(
        .leftIn(leftIn5),
        .rightIn(rightIn5),
        .key(ck5),
        .leftOut(leftOut5),
        .rightOut(rightOut5)
    );
    Register REG5(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut5,leftOut5}),
        .dataOut({leftIn6,rightIn6})
    );
    Round RND6(
        .leftIn(leftIn6),
        .rightIn(rightIn6),
        .key(ck6),
        .leftOut(leftOut6),
        .rightOut(rightOut6)
    );
    Register REG6(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut6,leftOut6}),
        .dataOut({leftIn7,rightIn7})
    );
    Round RND7(
        .leftIn(leftIn7),
        .rightIn(rightIn7),
        .key(ck7),
        .leftOut(leftOut7),
        .rightOut(rightOut7)
    );
    Register REG7(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut7,leftOut7}),
        .dataOut({leftIn8,rightIn8})
    );
    Round RND8(
        .leftIn(leftIn8),
        .rightIn(rightIn8),
        .key(ck8),
        .leftOut(leftOut8),
        .rightOut(rightOut8)
    );
    Register REG8(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut8,leftOut8}),
        .dataOut({leftIn9,rightIn9})
    );
    Round RND9(
        .leftIn(leftIn9),
        .rightIn(rightIn9),
        .key(ck9),
        .leftOut(leftOut9),
        .rightOut(rightOut9)
    );
    Register REG9(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut9,leftOut9}),
        .dataOut({leftIn10,rightIn10})
    );
    Round RND10(
        .leftIn(leftIn10),
        .rightIn(rightIn10),
        .key(ck10),
        .leftOut(leftOut10),
        .rightOut(rightOut10)
    );
    Register REG10(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut10,leftOut10}),
        .dataOut({leftIn11,rightIn11})
    );
    Round RND11(
        .leftIn(leftIn11),
        .rightIn(rightIn11),
        .key(ck11),
        .leftOut(leftOut11),
        .rightOut(rightOut11)
    );
    Register REG11(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut11,leftOut11}),
        .dataOut({leftIn12,rightIn12})
    );
    Round RND12(
        .leftIn(leftIn12),
        .rightIn(rightIn12),
        .key(ck12),
        .leftOut(leftOut12),
        .rightOut(rightOut12)
    );
    Register REG12(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut12,leftOut12}),
        .dataOut({leftIn13,rightIn13})
    );
    Round RND13(
        .leftIn(leftIn13),
        .rightIn(rightIn13),
        .key(ck13),
        .leftOut(leftOut13),
        .rightOut(rightOut13)
    );
    Register REG13(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut13,leftOut13}),
        .dataOut({leftIn14,rightIn14})
    );
    Round RND14(
        .leftIn(leftIn14),
        .rightIn(rightIn14),
        .key(ck14),
        .leftOut(leftOut14),
        .rightOut(rightOut14)
    );
    Register REG14(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut14,leftOut14}),
        .dataOut({leftIn15,rightIn15})
    );
    Round RND15(
        .leftIn(leftIn15),
        .rightIn(rightIn15),
        .key(ck15),
        .leftOut(leftOut15),
        .rightOut(rightOut15)
    );
    Register REG15(
        .clk(clk),
        .reset(reset),
        .dataIn({rightOut15,leftOut15}),
        .dataOut({leftIn16,rightIn16})
    );
    Round RND16(
        .leftIn(leftIn16),
        .rightIn(rightIn16),
        .key(ck16),
        .leftOut(leftOut16),
        .rightOut(rightOut16)
    );
    Register REG16(
        .clk(clk),
        .reset(reset),
        .dataIn({leftOut16,rightOut16}),
        .dataOut(roundsOut)
    );
    //-----------------Key generation-----------------------
    KeyGeneration KG(key,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16);
    always @(*) begin
        if (encrypt) begin
            ck1  = k1 ;ck2  = k2 ;ck3  = k3 ;ck4  = k4;
            ck5  = k5 ;ck6  = k6 ;ck7  = k7 ;ck8  = k8;
            ck9  = k9 ;ck10 = k10;ck11 = k11;ck12 = k12;
            ck13 = k13;ck14 = k14;ck15 = k15;ck16 = k16;
        end
        else begin
            ck1  = k16;ck2  = k15;ck3  = k14;ck4  = k13;
            ck5  = k12;ck6  = k11;ck7  = k10;ck8  = k9;
            ck9  = k8 ;ck10 = k7 ;ck11 = k6 ;ck12 = k5;
            ck13 = k4 ;ck14 = k3 ;ck15 = k2 ;ck16 = k1;
        end
    end
    //-----------------Initial and final permutations-------
    Register InitReg(
        .clk(clk),
        .reset(reset),
        .dataIn(initPermOut),
        .dataOut(roundsIn)
    );
    Register FinalReg(
        .clk(clk),
        .reset(reset),
        .dataIn(finalPermOut),
        .dataOut(dataOut)
    );
    InitialPermutation IP(dataIn,initPermOut);
    FinalPermutation FP(roundsOut,finalPermOut);
endmodule