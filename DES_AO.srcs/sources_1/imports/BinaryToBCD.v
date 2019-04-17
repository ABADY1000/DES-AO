//https://pubweb.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
//Edited to include thousands digit

module BinaryToBCD(
    input  [12:0] binary,
    output [15:0] bcd);
    reg [28:0] shiftreg;
    wire [3:0] thousands = shiftreg[28:25];
    wire [3:0] hundreds = shiftreg[24:21];
    wire [3:0] tens = shiftreg[20:17];
    wire [3:0] ones = shiftreg[16:13];
    assign bcd = {thousands,hundreds,tens,ones};
    integer i;
    always @(*) begin
        shiftreg = {16'd0,binary};
        for (i=0; i<13; i = i + 1) begin
            if(ones >= 5) shiftreg[16:13] = shiftreg[16:13] + 3;
            if(tens >= 5) shiftreg[20:17] = shiftreg[20:17] + 3;
            if(hundreds >= 5) shiftreg[24:21] = shiftreg[24:21] + 3;
            if(thousands >= 5) shiftreg[28:25] = shiftreg[28:25] + 3;
            shiftreg = shiftreg << 1;
        end
    end
endmodule

module BinaryToBCD2(number, hundreds, tens, ones);
   // I/O Signal Definitions
   input  [7:0] number;
   output reg [3:0] hundreds;
   output reg [3:0] tens;
   output reg [3:0] ones;
   
   // Internal variable for storing bits
   reg [19:0] shift;
   integer i;
   
   always @(number)
   begin
      // Clear previous number and store new number in shift register
      shift[19:8] = 0;
      shift[7:0] = number;
      
      // Loop eight times
      for (i=0; i<8; i=i+1) begin
         if (shift[11:8] >= 5)
            shift[11:8] = shift[11:8] + 3;
            
         if (shift[15:12] >= 5)
            shift[15:12] = shift[15:12] + 3;
            
         if (shift[19:16] >= 5)
            shift[19:16] = shift[19:16] + 3;
         
         // Shift entire register left once
         shift = shift << 1;
      end
      
      // Push decimal numbers to output
      hundreds = shift[19:16];
      tens     = shift[15:12];
      ones     = shift[11:8];
   end
 
endmodule