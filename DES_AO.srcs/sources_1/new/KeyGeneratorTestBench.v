`timescale 1ns / 1ps

module KeyGeneratorTestBench;
    reg [0:63] key;
    wire [0:47] k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16;
    KeyGeneration KG(key,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16);
    initial begin
        key = 64'hAABB09182736CCDD;
        #10;
    end
endmodule
