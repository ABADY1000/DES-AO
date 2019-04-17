`timescale 1ns / 1ps
module FPGAInterface(
    input clk,
    input reset,
    input rx,
    output tx,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    reg clkDivider;
    wire [0:2] state;
    wire [0:23] dataPacketCounterDebug;
    wire [0:9] headPacketsCounterDebug;
    
    FullTDESSystem #(.clockFrequency(50_000_000), .baudRate(9600)) FTDESS(
        .clk(clkDivider),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .headPacketsCounterDebug(headPacketsCounterDebug),
        .dataPacketCounterDebug(dataPacketCounterDebug),
        .stateDebug(state)
    );
    wire [15:0] bcd;
    reg [0:13] binaryInput;
    
    assign bcd[15:12] = 0;
    
    BinaryToBCD2 BTBCD(
        .number(binaryInput),
        .ones(bcd[3:0]),
        .tens(bcd[7:4]),
        .hundreds(bcd[11:8])
    );
    
    DisplayBCD DBCD(
        .DataIn(bcd), 
        .clk(clk),
        .clr(reset),
        .seg(seg),
        .an(an),
        .dp(dp)
    );
    assign led = {13'd0,state};
    
    always @(posedge clk) begin
        clkDivider <= ~clkDivider;
    end
    
    always @(*) begin
        if(state == 3'b001) binaryInput = {4'd0 ,headPacketsCounterDebug};
        else binaryInput = dataPacketCounterDebug[10:23];
    end

endmodule
