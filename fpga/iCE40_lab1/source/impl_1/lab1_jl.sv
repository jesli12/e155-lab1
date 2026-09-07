// Jessica Li  |  jesli@g.hmc.edu
// 09/05/2026
// This is the top-level module, taking input from 4 switches and output on 3 LEDs and a 7 segment display.
// It contains internal clock initialization (high-speed oscillator) and the switch-to-LED logic.
// The top-level module also uses another module for switch-to-7-segment display, and another module for the counter.


module lab1_jl(
	input   logic   [3:0] s,
	output  logic [2:0] led,
	output  logic [6:0] seg
);

	logic int_osc;
	assign reset = 1'b1; // make into button input later?
	
	// Internal high-speed oscillator, 48 MHz clock generated in FPGA by HSOSC primitive
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	assign led[0] = s[0] ^ s[1];
	assign led[1] = s[2] & s[3];
	
	// switch-to-7 segment display module
	switch_to_display seven_seg(
		.switch (s), 
		.segment (seg)
	);
	
	// counter for sequential LED 2.4 Hz blinker
	counter_2_4Hz blinker(
		.clk (int_osc), 
		.rst (reset),  
		.led (led[2])
	);
	

endmodule