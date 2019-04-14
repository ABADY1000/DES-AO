`timescale 1ns / 1ps
module InterfaceTestBench;
reg clk, reset, rx;
wire tx;
Interface INT(
.clk(clk),
.reset(reset),
.Rx(rx),
.Tx(tx)
); 
parameter frequency = 100_000_000;
parameter baudRate = 9_600;
parameter baudFrequency = frequency/(baudRate*4)*4;

reg [0:14] baudRateCounter;
wire baudClk = baudRateCounter >= baudFrequency;

always #5 clk = ! clk;

always @(posedge clk) begin
    baudRateCounter <= baudRateCounter + 1;
    if (baudClk) begin
        baudRateCounter <= 0;
    end
end
parameter letter = 8'd65; // A
initial begin
reset = 1'b1;
clk = 0;
rx = 1'b1;
@(posedge clk); 
baudRateCounter = 0;
@(negedge clk); 
reset = 1'b0;
    repeat (64) begin
        // Start bit
        rx = 1'b0;
        @(posedge baudClk); 
        // Send 01001111 = 'O'
        rx = letter[0]; 
        @(posedge baudClk);
        rx = letter[1];
        @(posedge baudClk);
        rx = letter[2];
        @(posedge baudClk);
        rx = letter[3];
        @(posedge baudClk);
        rx = letter[4];
        @(posedge baudClk);
        rx = letter[5];
        @(posedge baudClk);
        rx = letter[6];
        @(posedge baudClk);
        rx = letter[7];
        @(posedge baudClk); 
        // Stop bit
        rx = 1'b1; 
        @(posedge baudClk); 
    end
    $finish;
end
endmodule
