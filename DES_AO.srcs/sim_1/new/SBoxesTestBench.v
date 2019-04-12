`timescale 1ns / 1ps

module SBoxesTestBench;
    
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
