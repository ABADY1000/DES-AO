`timescale 1ps/1ps
module FullTDESSystemTestBench;
// Plan:
// UserDevice sends keys and text to FPGA
// FPGA receives text from UserDevice
// FPGA encrypts text
// FPGA sends cipher text to UserDevice
// UserDevice receives cipher text from FPGA
parameter clockFrequencyUserDevice = 1_000_000_000; // 1 GHz. Change this in clock def as well
parameter clockFrequencyFPGA = 100_000_000; // 100 MHz. Change this in clock def as well
parameter textSize = 8*3; // 24 Bytes
parameter baudRateUserDevice = 9600;
parameter baudRateFPGA = 9600;

reg clkUserDevice, resetUserDevice, clkFPGA, resetFPGA;
wire rxUserDevice, txUserDevice, rxFPGA, txFPGA;
wire userDeviceState;
reg start;

reg [0:7] command;
reg [0:23] dataLength;
reg [0:63] key1, key2, key3;
reg [0:textSize*8-1] text;
wire [0:textSize*8-1 + 28*8] fullMessage = {command,dataLength,key1,key2,key3,text};
wire [0:textSize*8-1] cipherText;

FullTDESSystem #(
    .clockFrequency(clockFrequencyFPGA),
    .baudRate(baudRateFPGA)
    )FPGA(
    .clk(clkFPGA),
    .reset(resetFPGA),
    .rx(rxFPGA),
    .tx(txFPGA)
);

UserDeviceSim #(
    .clockFrequency(clockFrequencyFPGA),
    .baudRate(baudRateFPGA),
    .sendMessageSize(28+textSize),
    .receiveMessageSize(textSize)
    )USER(
    .clk(clkUserDevice),
    .reset(resetUserDevice),
    .rx(rxUserDevice),
    .tx(txUserDevice),
    .messageToSend(fullMessage),
    .receivedMessage(cipherText),
    .state(userDeviceState),
    .start(start)
);

// Connect FPGA and UserDevice
assign rxUserDevice = txFPGA;
assign rxFPGA = txUserDevice;

// Clocks
always #(500) clkUserDevice = ~clkUserDevice; // 1 GHz
always #(5000) clkFPGA = ~clkFPGA; // 1 MHz

initial begin
    clkFPGA = 0;
    clkUserDevice = 0;
    resetFPGA = 1;
    resetUserDevice = 1;
    @(posedge clkFPGA); // Slower clock
    resetFPGA = 0;
    resetUserDevice = 0;
    command = "D";
    key1 = 64'h0123456789ABCDEF;
    key2 = 64'h23456789ABCDEF01;
    key3 = 64'h456789ABCDEF0123;
    dataLength = textSize*8;
    text = "The quick brown fox jumped over the lazy dog's back";
    // text is
    // {64'h5468652071756663,64'h6B2062726F776E20,64'h666F78206A756D70};
    // Cipher text should be
    // {64'hA826FD8CE53B855F,64'hCCE21C8112256FE6,64'h68D5C05DD9B6B900}
    start = 1;
    @(posedge userDeviceState == 2'b00);
    $finish;
end
endmodule
