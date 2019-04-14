module UARTRecieverTestBench;

parameter frequency = 100_000_000;
parameter reciverBaudRate = 20_000;
parameter senderBaudRate = 20_500;
parameter baudClockCount = frequency/(senderBaudRate);

reg clk, reset, rx;
reg stop;
wire packetRecievedSignal;
wire [0:7] data;

UARTReciever #(.clockFrequency(frequency),.baudRate(reciverBaudRate),.samplingRate(10))UT (
.clk(clk),
.reset(reset),
.rx(rx),
.data(data),
.packetRecievedSignal(packetRecievedSignal)
); 

reg count;
reg [0:14] baudRateCounter;
wire baudClk = baudRateCounter == baudClockCount;

always #5 clk = !clk;

always @(posedge clk) begin
    baudRateCounter <= baudRateCounter + 1;
    if (baudClk || ~count) begin
        baudRateCounter <= 0;
    end
    
end
parameter letter1 = 8'd65; // A
parameter letter2 = 8'd66; // B
initial begin
count = 1'b1;
reset = 1'b1;
clk = 0;
rx = 1'b1;
@(posedge clk); 
baudRateCounter = 0;
@(negedge clk); 
reset = 1'b0;
    repeat (10) begin
        // Start bit
        rx = 1'b0;
        @(posedge baudClk); 
        rx = letter1[0]; 
        @(posedge baudClk);
        rx = letter1[1];
        @(posedge baudClk);
        rx = letter1[2];
        @(posedge baudClk);
        rx = letter1[3];
        @(posedge baudClk);
        rx = letter1[4];
        @(posedge baudClk);
        rx = letter1[5];
        @(posedge baudClk);
        rx = letter1[6];
        @(posedge baudClk);
        rx = letter1[7];
        @(posedge baudClk); 
        // Stop bits
        rx = 1'b1; 
        stop = 1'b1;
        @(posedge baudClk); 
        stop = 1'b0;
    end
    count = 1'b0;
    repeat(84123) @(posedge clk);
    count = 1'b1;
    repeat (3) begin
        // Start bit
        rx = 1'b0;
        @(posedge baudClk); 
        rx = letter2[0]; 
        @(posedge baudClk);
        rx = letter2[1];
        @(posedge baudClk);
        rx = letter2[2];
        @(posedge baudClk);
        rx = letter2[3];
        @(posedge baudClk);
        rx = letter2[4];
        @(posedge baudClk);
        rx = letter2[5];
        @(posedge baudClk);
        rx = letter2[6];
        @(posedge baudClk);
        rx = letter2[7];
        @(posedge baudClk); 
        // Stop bits
        rx = 1'b1; 
        stop = 1'b1;
        @(posedge baudClk); 
        stop = 1'b0;
    end
    $finish;
end
endmodule
