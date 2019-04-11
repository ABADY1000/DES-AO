`timescale 1ns / 1ps

module Register #(width=64)(
    input clk,
    input reset,
    input [0:width-1] dataIn,
    output reg [0:width-1] dataOut
    );
    always @(posedge clk) begin
        if(reset) dataOut <= 0;
        else dataOut <= dataIn;
    end
endmodule
