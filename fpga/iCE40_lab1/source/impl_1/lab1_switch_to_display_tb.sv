// Jessica Li  |  jesli@g.hmc.edu
// 09/06/2026
// This is a test bench for the combinational module switch_to_display (4 switches to 7 segment display)
// It tests every input combination for a 4 bit binary s that controls a 7 segment display 
// Note: applied output logic 0 turns on the segment (common anode display)

module lab1_switch_to_display_tb();
	logic [3:0] s;
	logic [6:0] seg;
	
	switch_to_display dut(
		.switch (s),
		.segment (seg)
	);
	
	initial begin
		// test case: 0
		s = 4'b0000;
		#10;
		assert (seg == 7'b1000000)
			$display ("Success: 7-segment display 0 passed.");
		else $error("7-segment display 0 failed.");
		
		// test case: 1
		s = 4'b0001;
		#10;
		assert (seg == 7'b1111001)
			$display ("Success: 7-segment display 1 passed.");
		else $error("7-segment display 1 failed.");
			
		// test case: 2
		s = 4'b0010;
		#10;
		assert (seg == 7'b0100100)
			$display ("Success: 7-segment display 2 passed.");
		else $error("7-segment display 2 failed.");
		
		// test case: 3
		s = 4'b0011;
		#10;
		assert (seg == 7'b0110000)
			$display ("Success: 7-segment display 3 passed.");
		else $error("7-segment display 3 failed.");
		
		// test case: 4
		s = 4'b0100;
		#10;
		assert (seg == 7'b0011001)
			$display ("Success: 7-segment display 4 passed.");
		else $error("7-segment display 4 failed.");
		
		// test case: 5
		s = 4'b0101;
		#10;
		assert (seg == 7'b0010010)
			$display ("Success: 7-segment display 5 passed.");
		else $error("7-segment display 5 failed.");
			
		// test case: 6
		s = 4'b0110;
		#10;
		assert (seg == 7'b0000010)
			$display ("Success: 7-segment display 6 passed.");
		else $error("7-segment display 6 failed.");
		
		// test case: 7
		s = 4'b0111;
		#10;
		assert (seg == 7'b1111000)
			$display ("Success: 7-segment display 7 passed.");
		else $error("7-segment display 7 failed.");
		
		// test case: 8
		s = 4'b1000;
		#10;
		assert (seg == 7'b0000000)
			$display ("Success: 7-segment display 8 passed.");
		else $error("7-segment display 8 failed.");
		
		// test case: 9
		s = 4'b1001;
		#10;
		assert (seg == 7'b0010000)
			$display ("Success: 7-segment display 9 passed.");
		else $error("7-segment display 9 failed.");
			
		// test case: 10 A
		s = 4'b1010;
		#10;
		assert (seg == 7'b0001000)
			$display ("Success: 7-segment display A (10) passed.");
		else $error("7-segment display A (10) failed.");
		
		// test case: 11 B
		s = 4'b1011;
		#10;
		assert (seg == 7'b0000011)
			$display ("Success: 7-segment display B (11) passed.");
		else $error("7-segment display B (11) failed.");
		
		// test case: 12 C
		s = 4'b1100;
		#10;
		assert (seg == 7'b1000110)
			$display ("Success: 7-segment display C (12) passed.");
		else $error("7-segment display C (12) failed.");
		
		// test case: 13 D
		s = 4'b1101;
		#10;
		assert (seg == 7'b0100001)
			$display ("Success: 7-segment display D (13) passed.");
		else $error("7-segment display D (13) failed.");
		
		// test case: 14 E
		s = 4'b1110;
		#10;
		assert (seg == 7'b0000110)
			$display ("Success: 7-segment display E (14) passed.");
		else $error("7-segment display E (14) failed.");
		
		// test case: 15 F
		s = 4'b1111;
		#10;
		assert (seg == 7'b0001110)
			$display ("Success: 7-segment display F (15) passed.");
		else $error("7-segment display F (15) failed.");
		
		#10;
		$stop;
	end
endmodule