`timescale 1ps/1ps
module FullTDESSystemTestBench_FullPipeline;
// Plan:
// UserDevice sends keys and text to FPGA
// FPGA receives text from UserDevice
// FPGA encrypts text
// FPGA sends cipher text to UserDevice
// UserDevice receives cipher text from FPGA
parameter clockFrequencyUserDevice = 1_000_000_000; // 1 GHz. Change this in clock def as well
parameter clockFrequencyFPGA = 100_000_000; // 100 MHz. Change this in clock def as well
parameter textSize = 1148; // 1148 Bytes
parameter baudRateUserDevice = 1_000_000;
parameter baudRateFPGA = 1_000_000;

reg clkUserDevice, resetUserDevice, clkFPGA, resetFPGA;
wire rxUserDevice, txUserDevice, rxFPGA, txFPGA;
wire [0:1] userDeviceState;
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
    .clockFrequency(clockFrequencyUserDevice),
    .baudRate(baudRateUserDevice),
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
    @(negedge clkFPGA); // Slower clock
    resetFPGA = 0;
    resetUserDevice = 0;
    command = "E";
    dataLength = textSize;
    key1 = 64'h0123456789ABCDEF;
    key2 = 64'h23456789ABCDEF01;
    key3 = 64'h456789ABCDEF0123;
    text = "I am trying to test if the module will work if the pipeline was full and it had to send and receive at the same time. Therefore, I am writing this long message. Its length should be greater than 432 bytes or characters so that it can fill the pipeline now I am tired so I will just copy. I am trying to test if the module will work if the pipeline was full and it had to send and receive at the same time. Therefore, I am writing this long message. Its length should be greater than 432 bytes or characters so that it can fill the pipeline now I am tired so I will just copyI am trying to test if the module will work if the pipeline was full and it had to send and receive at the same time. Therefore, I am writing this long message. Its length should be greater than 432 bytes or characters so that it can fill the pipeline now I am tired so I will just copy. I am trying to test if the module will work if the pipeline was full and it had to send and receive at the same time. Therefore, I am writing this long message. Its length should be greater than 432 bytes or characters so that it can fill the pipeline now I am tired so I will just copy";
    start = 1;
    @(posedge userDeviceState == 2'b00);
    start = 0;
    repeat(3000) @(posedge clkFPGA);
    $display(cipherText);
    $finish;
end
endmodule
