module TripleDES(
        input clk,
        input reset,
        input [0:63] dataIn,
        input [0:63] key1,
        input [0:63] key2,
        input [0:63] key3,
        input encrypt,
        output [0:63] dataOut
    );
    reg [0:63] ck1,ck2,ck3;
    wire [0:63] DES1Out, DES2Out;
    wire decrypt = ~encrypt;
    DES DES1(
        .clk(clk),
        .reset(reset),
        .dataIn(dataIn),
        .encrypt(encrypt),
        .key(ck1),
        .dataOut(DES1Out)
    );
    DES DES2(
        .clk(clk),
        .reset(reset),
        .dataIn(DES1Out),
        .encrypt(decrypt),
        .key(ck2),
        .dataOut(DES2Out)
    );
    DES DES3(
        .clk(clk),
        .reset(reset),
        .dataIn(DES2Out),
        .encrypt(encrypt),
        .key(ck3),
        .dataOut(dataOut)
    );
    always @(*) begin
        if(encrypt) begin
            ck1 = key1;
            ck2 = key2;
            ck3 = key3;
        end
        else begin
            ck1 = key3;
            ck2 = key2;
            ck3 = key1;
        end
    end
endmodule
