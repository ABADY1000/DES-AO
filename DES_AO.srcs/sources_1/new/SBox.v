module S1(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 14;
                    4'b0001: dataOut = 4;
                    4'b0010: dataOut = 13;
                    4'b0011: dataOut = 1;
                    4'b0100: dataOut = 2;
                    4'b0101: dataOut = 15;
                    4'b0110: dataOut = 11;
                    4'b0111: dataOut = 8;
                    4'b1000: dataOut = 3;
                    4'b1001: dataOut = 10;
                    4'b1010: dataOut = 6;
                    4'b1011: dataOut = 12;
                    4'b1100: dataOut = 5;
                    4'b1101: dataOut = 9;
                    4'b1110: dataOut = 0;
                    4'b1111: dataOut = 7;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 0;
                    4'b0001: dataOut = 15;
                    4'b0010: dataOut = 7;
                    4'b0011: dataOut = 4;
                    4'b0100: dataOut = 14;
                    4'b0101: dataOut = 2;
                    4'b0110: dataOut = 13;
                    4'b0111: dataOut = 1;
                    4'b1000: dataOut = 10;
                    4'b1001: dataOut = 6;
                    4'b1010: dataOut = 12;
                    4'b1011: dataOut = 11;
                    4'b1100: dataOut = 9;
                    4'b1101: dataOut = 5;
                    4'b1110: dataOut = 3;
                    4'b1111: dataOut = 8;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 4;
                    4'b0001: dataOut = 1;
                    4'b0010: dataOut = 14;
                    4'b0011: dataOut = 8;
                    4'b0100: dataOut = 13;
                    4'b0101: dataOut = 6;
                    4'b0110: dataOut = 2;
                    4'b0111: dataOut = 11;
                    4'b1000: dataOut = 15;
                    4'b1001: dataOut = 12;
                    4'b1010: dataOut = 9;
                    4'b1011: dataOut = 7;
                    4'b1100: dataOut = 3;
                    4'b1101: dataOut = 10;
                    4'b1110: dataOut = 5;
                    4'b1111: dataOut = 0;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 15;
                    4'b0001: dataOut = 12;
                    4'b0010: dataOut = 8;
                    4'b0011: dataOut = 2;
                    4'b0100: dataOut = 4;
                    4'b0101: dataOut = 9;
                    4'b0110: dataOut = 1;
                    4'b0111: dataOut = 7;
                    4'b1000: dataOut = 5;
                    4'b1001: dataOut = 11;
                    4'b1010: dataOut = 3;
                    4'b1011: dataOut = 14;
                    4'b1100: dataOut = 10;
                    4'b1101: dataOut = 0;
                    4'b1110: dataOut = 6;
                    4'b1111: dataOut = 13;
                endcase
        endcase
    end
endmodule
module S2(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 15;
                    4'b0001: dataOut = 1;
                    4'b0010: dataOut = 8;
                    4'b0011: dataOut = 14;
                    4'b0100: dataOut = 6;
                    4'b0101: dataOut = 11;
                    4'b0110: dataOut = 3;
                    4'b0111: dataOut = 4;
                    4'b1000: dataOut = 9;
                    4'b1001: dataOut = 7;
                    4'b1010: dataOut = 2;
                    4'b1011: dataOut = 13;
                    4'b1100: dataOut = 12;
                    4'b1101: dataOut = 0;
                    4'b1110: dataOut = 5;
                    4'b1111: dataOut = 10;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 3;
                    4'b0001: dataOut = 13;
                    4'b0010: dataOut = 4;
                    4'b0011: dataOut = 7;
                    4'b0100: dataOut = 15;
                    4'b0101: dataOut = 2;
                    4'b0110: dataOut = 8;
                    4'b0111: dataOut = 14;
                    4'b1000: dataOut = 12;
                    4'b1001: dataOut = 0;
                    4'b1010: dataOut = 1;
                    4'b1011: dataOut = 10;
                    4'b1100: dataOut = 6;
                    4'b1101: dataOut = 9;
                    4'b1110: dataOut = 11;
                    4'b1111: dataOut = 5;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 0;
                    4'b0001: dataOut = 14;
                    4'b0010: dataOut = 7;
                    4'b0011: dataOut = 11;
                    4'b0100: dataOut = 10;
                    4'b0101: dataOut = 4;
                    4'b0110: dataOut = 13;
                    4'b0111: dataOut = 1;
                    4'b1000: dataOut = 5;
                    4'b1001: dataOut = 8;
                    4'b1010: dataOut = 12;
                    4'b1011: dataOut = 6;
                    4'b1100: dataOut = 9;
                    4'b1101: dataOut = 3;
                    4'b1110: dataOut = 2;
                    4'b1111: dataOut = 15;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 8;
                    4'b0010: dataOut = 10;
                    4'b0011: dataOut = 1;
                    4'b0100: dataOut = 3;
                    4'b0101: dataOut = 15;
                    4'b0110: dataOut = 4;
                    4'b0111: dataOut = 2;
                    4'b1000: dataOut = 11;
                    4'b1001: dataOut = 6;
                    4'b1010: dataOut = 7;
                    4'b1011: dataOut = 12;
                    4'b1100: dataOut = 0;
                    4'b1101: dataOut = 5;
                    4'b1110: dataOut = 14;
                    4'b1111: dataOut = 9;
                endcase
        endcase
    end
endmodule
module S3(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 10;
                    4'b0001: dataOut = 0;
                    4'b0010: dataOut = 9;
                    4'b0011: dataOut = 14;
                    4'b0100: dataOut = 6;
                    4'b0101: dataOut = 3;
                    4'b0110: dataOut = 15;
                    4'b0111: dataOut = 5;
                    4'b1000: dataOut = 1;
                    4'b1001: dataOut = 13;
                    4'b1010: dataOut = 12;
                    4'b1011: dataOut = 7;
                    4'b1100: dataOut = 11;
                    4'b1101: dataOut = 4;
                    4'b1110: dataOut = 2;
                    4'b1111: dataOut = 8;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 7;
                    4'b0010: dataOut = 0;
                    4'b0011: dataOut = 9;
                    4'b0100: dataOut = 3;
                    4'b0101: dataOut = 4;
                    4'b0110: dataOut = 6;
                    4'b0111: dataOut = 10;
                    4'b1000: dataOut = 2;
                    4'b1001: dataOut = 8;
                    4'b1010: dataOut = 5;
                    4'b1011: dataOut = 14;
                    4'b1100: dataOut = 12;
                    4'b1101: dataOut = 11;
                    4'b1110: dataOut = 15;
                    4'b1111: dataOut = 1;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 6;
                    4'b0010: dataOut = 4;
                    4'b0011: dataOut = 9;
                    4'b0100: dataOut = 8;
                    4'b0101: dataOut = 15;
                    4'b0110: dataOut = 3;
                    4'b0111: dataOut = 0;
                    4'b1000: dataOut = 11;
                    4'b1001: dataOut = 1;
                    4'b1010: dataOut = 2;
                    4'b1011: dataOut = 12;
                    4'b1100: dataOut = 5;
                    4'b1101: dataOut = 10;
                    4'b1110: dataOut = 14;
                    4'b1111: dataOut = 7;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 1;
                    4'b0001: dataOut = 10;
                    4'b0010: dataOut = 13;
                    4'b0011: dataOut = 0;
                    4'b0100: dataOut = 6;
                    4'b0101: dataOut = 9;
                    4'b0110: dataOut = 8;
                    4'b0111: dataOut = 7;
                    4'b1000: dataOut = 4;
                    4'b1001: dataOut = 15;
                    4'b1010: dataOut = 14;
                    4'b1011: dataOut = 3;
                    4'b1100: dataOut = 11;
                    4'b1101: dataOut = 5;
                    4'b1110: dataOut = 2;
                    4'b1111: dataOut = 12;
                endcase
        endcase
    end
endmodule
module S4(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 7;
                    4'b0001: dataOut = 13;
                    4'b0010: dataOut = 14;
                    4'b0011: dataOut = 3;
                    4'b0100: dataOut = 0;
                    4'b0101: dataOut = 6;
                    4'b0110: dataOut = 9;
                    4'b0111: dataOut = 10;
                    4'b1000: dataOut = 1;
                    4'b1001: dataOut = 2;
                    4'b1010: dataOut = 8;
                    4'b1011: dataOut = 5;
                    4'b1100: dataOut = 11;
                    4'b1101: dataOut = 12;
                    4'b1110: dataOut = 4;
                    4'b1111: dataOut = 15;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 8;
                    4'b0010: dataOut = 11;
                    4'b0011: dataOut = 5;
                    4'b0100: dataOut = 6;
                    4'b0101: dataOut = 15;
                    4'b0110: dataOut = 0;
                    4'b0111: dataOut = 3;
                    4'b1000: dataOut = 4;
                    4'b1001: dataOut = 7;
                    4'b1010: dataOut = 2;
                    4'b1011: dataOut = 12;
                    4'b1100: dataOut = 1;
                    4'b1101: dataOut = 10;
                    4'b1110: dataOut = 14;
                    4'b1111: dataOut = 9;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 10;
                    4'b0001: dataOut = 6;
                    4'b0010: dataOut = 9;
                    4'b0011: dataOut = 0;
                    4'b0100: dataOut = 12;
                    4'b0101: dataOut = 11;
                    4'b0110: dataOut = 7;
                    4'b0111: dataOut = 13;
                    4'b1000: dataOut = 15;
                    4'b1001: dataOut = 1;
                    4'b1010: dataOut = 3;
                    4'b1011: dataOut = 14;
                    4'b1100: dataOut = 5;
                    4'b1101: dataOut = 2;
                    4'b1110: dataOut = 8;
                    4'b1111: dataOut = 4;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 3;
                    4'b0001: dataOut = 15;
                    4'b0010: dataOut = 0;
                    4'b0011: dataOut = 6;
                    4'b0100: dataOut = 10;
                    4'b0101: dataOut = 1;
                    4'b0110: dataOut = 13;
                    4'b0111: dataOut = 8;
                    4'b1000: dataOut = 9;
                    4'b1001: dataOut = 4;
                    4'b1010: dataOut = 5;
                    4'b1011: dataOut = 11;
                    4'b1100: dataOut = 12;
                    4'b1101: dataOut = 7;
                    4'b1110: dataOut = 2;
                    4'b1111: dataOut = 14;
                endcase
        endcase
    end
endmodule
module S5(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 2;
                    4'b0001: dataOut = 12;
                    4'b0010: dataOut = 4;
                    4'b0011: dataOut = 1;
                    4'b0100: dataOut = 7;
                    4'b0101: dataOut = 10;
                    4'b0110: dataOut = 11;
                    4'b0111: dataOut = 6;
                    4'b1000: dataOut = 8;
                    4'b1001: dataOut = 5;
                    4'b1010: dataOut = 3;
                    4'b1011: dataOut = 15;
                    4'b1100: dataOut = 13;
                    4'b1101: dataOut = 0;
                    4'b1110: dataOut = 14;
                    4'b1111: dataOut = 9;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 14;
                    4'b0001: dataOut = 11;
                    4'b0010: dataOut = 2;
                    4'b0011: dataOut = 12;
                    4'b0100: dataOut = 4;
                    4'b0101: dataOut = 7;
                    4'b0110: dataOut = 13;
                    4'b0111: dataOut = 1;
                    4'b1000: dataOut = 5;
                    4'b1001: dataOut = 0;
                    4'b1010: dataOut = 15;
                    4'b1011: dataOut = 10;
                    4'b1100: dataOut = 3;
                    4'b1101: dataOut = 9;
                    4'b1110: dataOut = 8;
                    4'b1111: dataOut = 6;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 4;
                    4'b0001: dataOut = 2;
                    4'b0010: dataOut = 1;
                    4'b0011: dataOut = 11;
                    4'b0100: dataOut = 10;
                    4'b0101: dataOut = 13;
                    4'b0110: dataOut = 7;
                    4'b0111: dataOut = 8;
                    4'b1000: dataOut = 15;
                    4'b1001: dataOut = 9;
                    4'b1010: dataOut = 12;
                    4'b1011: dataOut = 5;
                    4'b1100: dataOut = 6;
                    4'b1101: dataOut = 3;
                    4'b1110: dataOut = 0;
                    4'b1111: dataOut = 14;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 11;
                    4'b0001: dataOut = 8;
                    4'b0010: dataOut = 12;
                    4'b0011: dataOut = 7;
                    4'b0100: dataOut = 1;
                    4'b0101: dataOut = 14;
                    4'b0110: dataOut = 2;
                    4'b0111: dataOut = 13;
                    4'b1000: dataOut = 6;
                    4'b1001: dataOut = 15;
                    4'b1010: dataOut = 0;
                    4'b1011: dataOut = 9;
                    4'b1100: dataOut = 10;
                    4'b1101: dataOut = 4;
                    4'b1110: dataOut = 5;
                    4'b1111: dataOut = 3;
                endcase
        endcase
    end
endmodule
module S6(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 12;
                    4'b0001: dataOut = 1;
                    4'b0010: dataOut = 10;
                    4'b0011: dataOut = 15;
                    4'b0100: dataOut = 9;
                    4'b0101: dataOut = 2;
                    4'b0110: dataOut = 6;
                    4'b0111: dataOut = 8;
                    4'b1000: dataOut = 0;
                    4'b1001: dataOut = 13;
                    4'b1010: dataOut = 3;
                    4'b1011: dataOut = 4;
                    4'b1100: dataOut = 14;
                    4'b1101: dataOut = 7;
                    4'b1110: dataOut = 5;
                    4'b1111: dataOut = 11;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 10;
                    4'b0001: dataOut = 15;
                    4'b0010: dataOut = 4;
                    4'b0011: dataOut = 2;
                    4'b0100: dataOut = 7;
                    4'b0101: dataOut = 12;
                    4'b0110: dataOut = 9;
                    4'b0111: dataOut = 5;
                    4'b1000: dataOut = 6;
                    4'b1001: dataOut = 1;
                    4'b1010: dataOut = 13;
                    4'b1011: dataOut = 14;
                    4'b1100: dataOut = 0;
                    4'b1101: dataOut = 11;
                    4'b1110: dataOut = 3;
                    4'b1111: dataOut = 8;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 9;
                    4'b0001: dataOut = 14;
                    4'b0010: dataOut = 15;
                    4'b0011: dataOut = 5;
                    4'b0100: dataOut = 2;
                    4'b0101: dataOut = 8;
                    4'b0110: dataOut = 12;
                    4'b0111: dataOut = 3;
                    4'b1000: dataOut = 7;
                    4'b1001: dataOut = 0;
                    4'b1010: dataOut = 4;
                    4'b1011: dataOut = 10;
                    4'b1100: dataOut = 1;
                    4'b1101: dataOut = 13;
                    4'b1110: dataOut = 11;
                    4'b1111: dataOut = 6;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 4;
                    4'b0001: dataOut = 3;
                    4'b0010: dataOut = 2;
                    4'b0011: dataOut = 12;
                    4'b0100: dataOut = 9;
                    4'b0101: dataOut = 5;
                    4'b0110: dataOut = 15;
                    4'b0111: dataOut = 10;
                    4'b1000: dataOut = 11;
                    4'b1001: dataOut = 14;
                    4'b1010: dataOut = 1;
                    4'b1011: dataOut = 7;
                    4'b1100: dataOut = 6;
                    4'b1101: dataOut = 0;
                    4'b1110: dataOut = 8;
                    4'b1111: dataOut = 13;
                endcase
        endcase
    end
endmodule
module S7(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 4;
                    4'b0001: dataOut = 11;
                    4'b0010: dataOut = 2;
                    4'b0011: dataOut = 14;
                    4'b0100: dataOut = 15;
                    4'b0101: dataOut = 0;
                    4'b0110: dataOut = 8;
                    4'b0111: dataOut = 13;
                    4'b1000: dataOut = 3;
                    4'b1001: dataOut = 12;
                    4'b1010: dataOut = 9;
                    4'b1011: dataOut = 7;
                    4'b1100: dataOut = 5;
                    4'b1101: dataOut = 10;
                    4'b1110: dataOut = 6;
                    4'b1111: dataOut = 1;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 0;
                    4'b0010: dataOut = 11;
                    4'b0011: dataOut = 7;
                    4'b0100: dataOut = 4;
                    4'b0101: dataOut = 9;
                    4'b0110: dataOut = 1;
                    4'b0111: dataOut = 10;
                    4'b1000: dataOut = 14;
                    4'b1001: dataOut = 3;
                    4'b1010: dataOut = 5;
                    4'b1011: dataOut = 12;
                    4'b1100: dataOut = 2;
                    4'b1101: dataOut = 15;
                    4'b1110: dataOut = 8;
                    4'b1111: dataOut = 6;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 1;
                    4'b0001: dataOut = 4;
                    4'b0010: dataOut = 11;
                    4'b0011: dataOut = 13;
                    4'b0100: dataOut = 12;
                    4'b0101: dataOut = 3;
                    4'b0110: dataOut = 7;
                    4'b0111: dataOut = 14;
                    4'b1000: dataOut = 10;
                    4'b1001: dataOut = 15;
                    4'b1010: dataOut = 6;
                    4'b1011: dataOut = 8;
                    4'b1100: dataOut = 0;
                    4'b1101: dataOut = 5;
                    4'b1110: dataOut = 9;
                    4'b1111: dataOut = 2;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 6;
                    4'b0001: dataOut = 11;
                    4'b0010: dataOut = 13;
                    4'b0011: dataOut = 8;
                    4'b0100: dataOut = 1;
                    4'b0101: dataOut = 4;
                    4'b0110: dataOut = 10;
                    4'b0111: dataOut = 7;
                    4'b1000: dataOut = 9;
                    4'b1001: dataOut = 5;
                    4'b1010: dataOut = 0;
                    4'b1011: dataOut = 15;
                    4'b1100: dataOut = 14;
                    4'b1101: dataOut = 2;
                    4'b1110: dataOut = 3;
                    4'b1111: dataOut = 12;
                endcase
        endcase
    end
endmodule
module S8(input [0:5] dataIn,output reg [0:3] dataOut);
    always @(*) begin
        case({dataIn[0], dataIn[5]})
            2'b00:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 13;
                    4'b0001: dataOut = 2;
                    4'b0010: dataOut = 8;
                    4'b0011: dataOut = 4;
                    4'b0100: dataOut = 6;
                    4'b0101: dataOut = 15;
                    4'b0110: dataOut = 11;
                    4'b0111: dataOut = 1;
                    4'b1000: dataOut = 10;
                    4'b1001: dataOut = 9;
                    4'b1010: dataOut = 3;
                    4'b1011: dataOut = 14;
                    4'b1100: dataOut = 5;
                    4'b1101: dataOut = 0;
                    4'b1110: dataOut = 12;
                    4'b1111: dataOut = 7;
                endcase
            2'b01:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 1;
                    4'b0001: dataOut = 15;
                    4'b0010: dataOut = 13;
                    4'b0011: dataOut = 8;
                    4'b0100: dataOut = 10;
                    4'b0101: dataOut = 3;
                    4'b0110: dataOut = 7;
                    4'b0111: dataOut = 4;
                    4'b1000: dataOut = 12;
                    4'b1001: dataOut = 5;
                    4'b1010: dataOut = 6;
                    4'b1011: dataOut = 11;
                    4'b1100: dataOut = 0;
                    4'b1101: dataOut = 14;
                    4'b1110: dataOut = 9;
                    4'b1111: dataOut = 2;
                endcase
            2'b10:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 7;
                    4'b0001: dataOut = 11;
                    4'b0010: dataOut = 4;
                    4'b0011: dataOut = 1;
                    4'b0100: dataOut = 9;
                    4'b0101: dataOut = 12;
                    4'b0110: dataOut = 14;
                    4'b0111: dataOut = 2;
                    4'b1000: dataOut = 0;
                    4'b1001: dataOut = 6;
                    4'b1010: dataOut = 10;
                    4'b1011: dataOut = 13;
                    4'b1100: dataOut = 15;
                    4'b1101: dataOut = 3;
                    4'b1110: dataOut = 5;
                    4'b1111: dataOut = 8;
                endcase
            2'b11:
                case({dataIn[1],dataIn[2],dataIn[3],dataIn[4]}) 
                    4'b0000: dataOut = 2;
                    4'b0001: dataOut = 1;
                    4'b0010: dataOut = 14;
                    4'b0011: dataOut = 7;
                    4'b0100: dataOut = 4;
                    4'b0101: dataOut = 10;
                    4'b0110: dataOut = 8;
                    4'b0111: dataOut = 13;
                    4'b1000: dataOut = 15;
                    4'b1001: dataOut = 12;
                    4'b1010: dataOut = 9;
                    4'b1011: dataOut = 0;
                    4'b1100: dataOut = 3;
                    4'b1101: dataOut = 5;
                    4'b1110: dataOut = 6;
                    4'b1111: dataOut = 11;
                endcase
        endcase
    end
endmodule