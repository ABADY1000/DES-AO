module UARTTransmitterTestBench;
parameter messageLength = 14;
reg clk, reset, transmit;
reg [0:messageLength*8-1] message;
wire tx, packetTransmittedSignal;

UARTTransmitter UT(
.clk(clk),
.reset(reset),
.transmit(transmit),
.data(message[0:7]),
.tx(tx),
.packetTransmittedSignal(packetTransmittedSignal)
);
always #5 clk = ~clk;

initial begin
clk = 0;
reset = 1;
message = "We are m3lmeen";
transmit = 1;
@(negedge clk);
reset = 0;
repeat(messageLength) begin
    @(posedge packetTransmittedSignal);
    message = {message[8:messageLength*8-1],8'd0};
end
$finish;
end
endmodule
