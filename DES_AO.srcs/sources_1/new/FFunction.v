`timescale 1ns / 1ps

module FFunction(
    input [0:31] dataIn,
    input [0:47] key,
    output [0:31] dataOut
    );
    
    wire [0:47] fromEDBtoXOR; // ExpansionDBoxTable Output
    ExpansionDBoxTable edb(dataIn, fromEDBtoXOR);
    
    wire [0:47] XORedDATA_KEY = fromEDBtoXOR ^ key;
    
    wire [0:31] SBoxedData; // SBoxes Output
    SBoxes sbs(XORedDATA_KEY, SBoxedData);
    
    StraightDBoxTable sdb(SBoxedData, dataOut);
    
endmodule
