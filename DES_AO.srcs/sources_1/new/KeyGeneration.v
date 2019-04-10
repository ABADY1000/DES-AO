module KeyGeneration(
    input [0:63] key,
    output [0:47] k1,
    output [0:47] k2,
    output [0:47] k3,
    output [0:47] k4,
    output [0:47] k5,
    output [0:47] k6,
    output [0:47] k7,
    output [0:47] k8,
    output [0:47] k9,
    output [0:47] k10,
    output [0:47] k11,
    output [0:47] k12,
    output [0:47] k13,
    output [0:47] k14,
    output [0:47] k15,
    output [0:47] k16
    );
    wire [0:27] left1, right1;
    wire [0:27] left2, right2;
    wire [0:27] left3, right3;
    wire [0:27] left4, right4;
    wire [0:27] left5, right5;
    wire [0:27] left6, right6;
    wire [0:27] left7, right7;
    wire [0:27] left8, right8;
    wire [0:27] left9, right9;
    wire [0:27] left10, right10;
    wire [0:27] left11, right11;
    wire [0:27] left12, right12;
    wire [0:27] left13, right13;
    wire [0:27] left14, right14;
    wire [0:27] left15, right15;
    wire [0:27] left16, right16;
    ParityBitDropTable PBDT(key,{left1,right1});
    KeyRound #(1) KR1(
        .leftIn(left1),
        .rightIn(right1),
        .leftOut(left2),
        .rightOut(right2),
        .key(k1)
    );
    KeyRound #(1) KR2(
        .leftIn(left2),
        .rightIn(right2),
        .leftOut(left3),
        .rightOut(right3),
        .key(k2)
    );
    KeyRound #(2) KR3(
        .leftIn(left3),
        .rightIn(right3),
        .leftOut(left4),
        .rightOut(right4),
        .key(k3)
    );
    KeyRound #(2) KR4(
        .leftIn(left4),
        .rightIn(right4),
        .leftOut(left5),
        .rightOut(right5),
        .key(k4)
    );
    KeyRound #(2) KR5(
        .leftIn(left5),
        .rightIn(right5),
        .leftOut(left6),
        .rightOut(right6),
        .key(k5)
    );
    KeyRound #(2) KR6(
        .leftIn(left6),
        .rightIn(right6),
        .leftOut(left7),
        .rightOut(right7),
        .key(k6)
    );
    KeyRound #(2) KR7(
        .leftIn(left7),
        .rightIn(right7),
        .leftOut(left8),
        .rightOut(right8),
        .key(k7)
    );
    KeyRound #(2) KR8(
        .leftIn(left8),
        .rightIn(right8),
        .leftOut(left9),
        .rightOut(right9),
        .key(k8)
    );
    KeyRound #(1) KR9(
        .leftIn(left9),
        .rightIn(right9),
        .leftOut(left10),
        .rightOut(right10),
        .key(k9)
    );
    KeyRound #(2) KR10(
        .leftIn(left10),
        .rightIn(right10),
        .leftOut(left11),
        .rightOut(right11),
        .key(k10)
    );
    KeyRound #(2) KR11(
        .leftIn(left11),
        .rightIn(right11),
        .leftOut(left12),
        .rightOut(right12),
        .key(k11)
    );
    KeyRound #(2) KR12(
        .leftIn(left12),
        .rightIn(right12),
        .leftOut(left13),
        .rightOut(right13),
        .key(k12)
    );
    KeyRound #(2) KR13(
        .leftIn(left13),
        .rightIn(right13),
        .leftOut(left14),
        .rightOut(right14),
        .key(k13)
    );
    KeyRound #(2) KR14(
        .leftIn(left14),
        .rightIn(right14),
        .leftOut(left15),
        .rightOut(right15),
        .key(k14)
    );
    KeyRound #(2) KR15(
        .leftIn(left15),
        .rightIn(right15),
        .leftOut(left16),
        .rightOut(right16),
        .key(k15)
    );
    KeyRound #(1) KR16(
        .leftIn(left16),
        .rightIn(right16),
        .key(k16)
    );
endmodule
