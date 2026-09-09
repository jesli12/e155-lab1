// Jessica Li  |  jesli@g.hmc.edu
// 09/07/2026
// This is a test bench for the top-level module of lab 1: lab1_jl.sv
// It verifies behaviors not covered by the two module-level sims:
// 1. Does the HSOSC work? 2. Does the switch-to-LED assign logic work? 3. Are all connections to submodules correctly linked? 4. If blinker led is blinking at 2.4 Hz

`timescale 1 ns/1 ns

module lab1_jl_tb();
	logic   [3:0] switches;
	logic rst;
	logic en;
	logic [2:0] leds;
	logic [6:0] sev_seg;
	
	lab1_jl dut(
		.s (switches),
		.reset (rst),
		.enable (en),
		.led (leds),
		.seg(sev_seg)
	);
	
	initial begin
		rst = 1;
		en = 1;
		switches = 4'b0000;
		// ### 1.Does the HSOSC work? ###############################################################################
		// Visualization on questa shows HSOSC clock tick is 48 Hz
		
		$display("### Test 1: Does HSOSC work? See Questa waveform screenshots, but below are sanity checks.");
		#1; // avoiding edge by 1 ns
		assert (dut.int_osc == 0)
			$display ("1a. Success HSOSC: int_osc HSOSC clock is 0. Time: %0t.", $time);
		else $error("1a. Failure HSOSC: int_osc started at 1? Breaks assumption in following tests. Time: %0t.", $time);
		
		// wait for T = 1/f = 1/48Mhz = 20.833ns, then 20.833/2 = 10.4165 = estimate 11 ish
		#11;
		assert (dut.int_osc == 1)
			$display ("1b. Success HSOSC: after half an expected period, int_osc toggled to 1. Time: %0t.", $time);
		else $error("1b. Failure HSOSC: after half an expected period, int_osc did not toggle and stayed at 0. Time: %0t.", $time);
		#11;
		assert (dut.int_osc == 0)
			$display ("1c. Success HSOSC: after an expected period, int_osc toggled to 0. Time: %0t.", $time);
		else $error("1c. Failure HSOSC: after an expected period, int_osc is 1, when it should be 0. Time: %0t.", $time);
		
		
		// ### 2. TEST IF SWITCH-TO-LED top-level assign logic works ################################################
		$display("### Test 2: Does top-level assign logic for switch-to-LED work??");
		// ## 2a. led[0]
		// case 1/4
		switches = 4'bxx00;
		#10;
		assert (leds[0] == 1'b0)
			$display ("2a. Success led0: 1/4 Switch-to-LED s=xx00, led[0] = off. Time: %0t.", $time);
		else $error("2a. Failure led0: 1/4 Switch-to-LED s=xx00, led[0] != off. Time: %0t.", $time);
		// case 2/4
		switches = 4'bxx01;
		#10;
		assert (leds[0] == 1'b1)
			$display ("2a. Success led0: 2/4 Switch-to-LED s=xx01, led[0] = on. Time: %0t.", $time);
		else $error("2a. Failure led0: 2/4 Switch-to-LED s=xx01, led[0] != on. Time: %0t.", $time);
		// case 3/4
		switches = 4'bxx10;
		#10;
		assert (leds[0] == 1'b1)
			$display ("2a. Success led0: 3/4 Switch-to-LED s=xx10, led[0] = on. Time: %0t.", $time);
		else $error("2a. Failure led0: 3/4 Switch-to-LED s=xx10, led[0] != on. Time: %0t.", $time);
		// case 4/4
		switches = 4'bxx11;
		#10;
		assert (leds[0] == 1'b0)
			$display ("2a. Success led0: 4/4 Switch-to-LED s=xx11, led[0] = off. Time: %0t.", $time);
		else $error("2a. Failure led0: 4/4 Switch-to-LED s=xx11, led[0] != off. Time: %0t.", $time);
			
		// ## 2b. led[1]
		// case 1/4
		switches = 4'b00xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("2b. Success led1: 1/4 Switch-to-LED s=00xx, led[1] = off. Time: %0t.", $time);
		else $error("2b. Failure led1: 1/4 Switch-to-LED s=00xx, led[1] != off. Time: %0t.", $time);
		// case 2/4
		switches = 4'b01xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("2b. Success led1: 2/4 Switch-to-LED s=01xx, led[1] = off. Time: %0t.", $time);
		else $error("2b. Failure led1: 2/4 Switch-to-LED s=01xx, led[1] != off. Time: %0t.", $time);
		// case 3/4
		switches = 4'b10xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("2b. Success led1: 3/4 Switch-to-LED s=10xx, led[1] = off. Time: %0t.", $time);
		else $error("2b. Failure led1: 3/4 Switch-to-LED s=10xx, led[1] != off. Time: %0t.", $time);
		// case 4/4
		switches = 4'b11xx;
		#10;
		assert (leds[1] == 1'b1)
			$display ("2b. Success led1: 4/4 Switch-to-LED s=11xx, led[1] = on. Time: %0t.", $time);
		else $error("2b. Failure led1: 4/4 Switch-to-LED s=11xx, led[1] != on. Time: %0t.", $time);
		// ### END OF 2. TEST IF SWITCH-TO-LED top-level assign logic works ###
		
		// ### 3.  Connections to Submodules: 3a. switch_to_display, 3b. counter_2_4Hz   #####################################
		$display("Test 3: Are submodule connections correct? (3a. switch_to_display, 3b. counter_2_4Hz)");
		// ## 3a. switch_to_display connection verification by showing top-level signals for switches and segments are correct
		$display("Test 3a: Show that switch_to_display are connected correctly with top module's switches and segments by showing that top module switch to segment encoding works");
		// test case: 0
		switches = 4'b0000;
		#10;
		assert (sev_seg == 7'b1000000)
			$display ("Success: 7-segment display 0 passed. Time: %0t.", $time);
		else $error("7-segment display 0 failed. Time: %0t.", $time);
		// test case: 1
		switches = 4'b0001;
		#10;
		assert (sev_seg == 7'b1111001)
			$display ("Success: 7-segment display 1 passed. Time: %0t.", $time);
		else $error("7-segment display 1 failed. Time: %0t.", $time);
		// test case: 2
		switches = 4'b0010;
		#10;
		assert (sev_seg == 7'b0100100)
			$display ("Success: 7-segment display 2 passed. Time: %0t.", $time);
		else $error("7-segment display 2 failed. Time: %0t.", $time);
		// test case: 3
		switches = 4'b0011;
		#10;
		assert (sev_seg == 7'b0110000)
			$display ("Success: 7-segment display 3 passed. Time: %0t.", $time);
		else $error("7-segment display 3 failed. Time: %0t.", $time);
		// test case: 4
		switches = 4'b0100;
		#10;
		assert (sev_seg == 7'b0011001)
			$display ("Success: 7-segment display 4 passed. Time: %0t.", $time);
		else $error("7-segment display 4 failed. Time: %0t.", $time);
		// test case: 5
		switches = 4'b0101;
		#10;
		assert (sev_seg == 7'b0010010)
			$display ("Success: 7-segment display 5 passed. Time: %0t.", $time);
		else $error("7-segment display 5 failed. Time: %0t.", $time);
		// test case: 6
		switches = 4'b0110;
		#10;
		assert (sev_seg == 7'b0000010)
			$display ("Success: 7-segment display 6 passed. Time: %0t.", $time);
		else $error("7-segment display 6 failed. Time: %0t.", $time);
		// test case: 7
		switches = 4'b0111;
		#10;
		assert (sev_seg == 7'b1111000)
			$display ("Success: 7-segment display 7 passed. Time: %0t.", $time);
		else $error("7-segment display 7 failed. Time: %0t.", $time);
		// test case: 8
		switches = 4'b1000;
		#10;
		assert (sev_seg == 7'b0000000)
			$display ("Success: 7-segment display 8 passed. Time: %0t.", $time);
		else $error("7-segment display 8 failed. Time: %0t.", $time);
		// test case: 9
		switches = 4'b1001;
		#10;
		assert (sev_seg == 7'b0010000)
			$display ("Success: 7-segment display 9 passed. Time: %0t.", $time);
		else $error("7-segment display 9 failed. Time: %0t.", $time);
		// test case: 10 A
		switches = 4'b1010;
		#10;
		assert (sev_seg == 7'b0001000)
			$display ("Success: 7-segment display A (10) passed. Time: %0t.", $time);
		else $error("7-segment display A (10) failed. Time: %0t.", $time);
		// test case: 11 B
		switches = 4'b1011;
		#10;
		assert (sev_seg == 7'b0000011)
			$display ("Success: 7-segment display B (11) passed. Time: %0t.", $time);
		else $error("7-segment display B (11) failed. Time: %0t.", $time);
		// test case: 12 C
		switches = 4'b1100;
		#10;
		assert (sev_seg == 7'b1000110)
			$display ("Success: 7-segment display C (12) passed. Time: %0t.", $time);
		else $error("7-segment display C (12) failed. Time: %0t.", $time);
		// test case: 13 D
		switches = 4'b1101;
		#10;
		assert (sev_seg == 7'b0100001)
			$display ("Success: 7-segment display D (13) passed. Time: %0t.", $time);
		else $error("7-segment display D (13) failed. Time: %0t.", $time);
		// test case: 14 E
		switches = 4'b1110;
		#10;
		assert (sev_seg == 7'b0000110)
			$display ("Success: 7-segment display E (14) passed. Time: %0t.", $time);
		else $error("7-segment display E (14) failed. Time: %0t.", $time);
		// test case: 15 F
		switches = 4'b1111;
		#10;
		assert (sev_seg == 7'b0001110)
			$display ("Success: 7-segment display F (15) passed. Time: %0t.", $time);
		else $error("7-segment display F (15) failed. Time: %0t.", $time);
			
		// ## 3b. Show that counter_2_4Hz is correctly connected to the top module (clk, reset, enable, led) ###########################
		// clk and led can be show through questa wave forms
		// let's test reset and enable to show that it is connected to the submodule correctly!
		en = 1;
		rst = 0;
		#21;
		rst = 1;  // reset OFF
		#100000000; 
		en = 0;   // expected behavior: enable off, counter in submodule freezes
		#200000000;
		assert (leds[2] == 0)
			$display ("3b1. Success: enable off prevented led write. Time: %0t.", $time);
		else $error("3b1. Failure: enable off did not prevent led write. Time: %0t.", $time);
		en = 1;
		#200000000; // expected behavior post 200,000,000 ns total since reset: max count hits once and resets, led toggles
		assert (leds[2] ==1)
			$display ("3b2. Success: led[2] (blinker) successfully turned on. Time: %0t.", $time);
		else $error("3b2. Failure: led[2] (blinker) failed to turn on. Time: %0t.", $time);
		
		rst = 0;
		#21;
		assert (leds[2] == 0)
			$display ("3b3. Success: led[2] (blinker) successfully reset back to 0. Time: %0t.", $time);
		else $error("3b3. Failure: led[2] (blinker) failed to reset back to 0. Time: %0t.", $time);
		rst = 1;
		
		
		
		#100;
		$stop;
	end
endmodule