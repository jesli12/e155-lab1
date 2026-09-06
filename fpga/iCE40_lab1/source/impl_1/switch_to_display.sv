// Jessica Li  |  jesli@g.hmc.edu
// 09/05/2026
// This is a module used in the top-leve module "lab1_jl"
// It contains the combinational logic for the switch-to-7-segment display.
// This module takes s[3:0] and displays its single hexadecimal digit on a 7 segment display.
// Note: applied logic 0 turns on the segment (common anode display)


module switch_to_display(
	input   logic   s[3:0],
	output  logic seg[6:0],
);
	
	always_comb
		case (s)
			4'b0000: seg = 7'b1000000; //0
			4'b0001: seg = 7'b1111001; //1
			4'b0010: seg = 7'b0100100; //2
			4'b0011: seg = 7'b0110000; //3
			4'b0100: seg = 7'b0011001; //4
			4'b0101: seg = 7'b0010010; //5
			4'b0110: seg = 7'b0000010; //6
			4'b0111: seg = 7'b1111000; //7
			4'b1000: seg = 7'b0000000; //8
			4'b1001: seg = 7'b0010000; //9
			4'b1010: seg = 7'b0001000; //10  A
			4'b1011: seg = 7'b0000011; //11  B
			4'b1100: seg = 7'b1000110; //12  C
			4'b1101: seg = 7'b0100001; //13  D
			4'b1110: seg = 7'b0000110; //14  E
			4'b1111: seg = 7'b0001110; //15  F
		endcase
	

endmodule
