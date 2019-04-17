`timescale 1ns / 1ps
// From Dr. Mohammed Awedh
module DisplayBCD(
    input [15:0] DataIn, 
    input clk,
    input clr,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );

    reg [6:0] to7SegReg;
    reg [3:0] anReg;
	 
	 wire [1:0] select;
	 
	 reg [3:0] digit;
	 reg [19:0] clkdiv;
	 
	 assign dp = 1'b1;  //Turn off the decimal point
	 assign seg = to7SegReg;
	 assign an = anReg;
	 assign select = clkdiv[19:18];
	 
	always @(*)  //Select one BCD digit
	  case (select)
		2'b00: digit = DataIn[3:0];
		2'b01: digit = DataIn[7:4];
		2'b10: digit = DataIn[11:8];
		2'b11: digit = DataIn[15:12];
		default: digit= DataIn[3:0];
	  endcase	 
	 
	 
	always @(*)  //Set the 7-seg input a,b,c,d,e,f,g
	  case (digit)
		4'b0000: to7SegReg = 7'b1000000; 	// 0
		4'b0001: to7SegReg = 7'b1111001; 	// 1
		4'b0010: to7SegReg = 7'b0100100; 	// 2
		4'b0011: to7SegReg = 7'b0110000; 	// 3
		4'b0100: to7SegReg = 7'b0011001;    // 4
		4'b0101: to7SegReg = 7'b0010010;    // 5
		4'b0110: to7SegReg = 7'b0000010;    // 6
		4'b0111: to7SegReg = 7'b1111000;    // 7
		4'b1000: to7SegReg = 7'b0000000; 	// 8
		4'b1001: to7SegReg = 7'b0010000;		// 9
		4'b1010: to7SegReg = 7'b0001000;		// A
		4'b1011: to7SegReg = 7'b0000011;		// B
		4'b1100: to7SegReg = 7'b1000110;		// C
		4'b1101: to7SegReg = 7'b0100001;		// D
		4'b1110: to7SegReg = 7'b0000110;		// E
		4'b1111: to7SegReg = 7'b0001110;		// F
		default: to7SegReg = 7'b1111111; //Blank
	  endcase
	  
	always @(*)  //enable the prober 7Segment
	  case (select)
		2'b00: anReg = 4'b1110; 
		2'b01: anReg = 4'b1101; 
		2'b10: anReg = 4'b1011; 
		2'b11: anReg = 4'b0111; 
		default: anReg = 4'b1111;
	  endcase
	  
	//Clock divider
	always @(posedge clk, posedge clr)
		if (clr == 1'b1)
		 clkdiv <= 0;
		else 
		 clkdiv <= clkdiv + 1;
	  
endmodule