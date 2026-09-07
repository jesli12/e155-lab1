// Jessica Li  |  jesli@g.hmc.edu
// 09/07/2026
// This is a test bench for the top-level module of lab 1: lab1_jl.sv
// It verifies behaviors not covered by the two module-level sims:
// 1. Does the HSOSC work? 2. Does the switch-to-LED assign logic work? 3. Are all connections to submodules correctly linked?

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
		// ### 1.Does the HSOSC work? ###
		assert (dut.int_osc == 0)
			$display ("int_osc HSOSC clock is 0.");
		else $error("Failure HSOSC: int_osc started at 1? Breaks assumption in following tests. Time: %0t.", $time);
		
		// wait for T = 1/f = 1/48Mhz = 20.833/2 = 11 ish
		#11
		assert (dut.int_osc == 1)
			$display ("Success HSOSC: after half an expected period, int_osc toggled to 1. Time: %0t.", $time);
		else $error("Failure HSOSC: after half an expected period, int_osc did not toggle and stayed at 0. Time: %0t.", $time);
		#11
		assert (dut.int_osc == 0)
			$display ("Success HSOSC: after an expected period, int_osc toggled to 0. Time: %0t.", $time);
		else $error("Failure HSOSC: after an expected period, int_osc is 1, when it should be 0. Time: %0t.", $time);
		
		
		// ### 2. TEST IF SWITCH-TO-LED top-level assign logic works ###
		// ## 2a. led[0]
		// case 1/4
		switches = 4'bxx00;
		#10;
		assert (leds[0] == 1'b0)
			$display ("Success led0: 1/4 Switch-to-LED s=xx00, led[0] = off");
		else $error("Failure led0: 1/4 Switch-to-LED s=xx00, led[0] != off");
			
		// case 2/4
		switches = 4'bxx01;
		#10;
		assert (leds[0] == 1'b1)
			$display ("Success led0: 2/4 Switch-to-LED s=xx01, led[0] = on");
		else $error("Failure led0: 2/4 Switch-to-LED s=xx01, led[0] != on");
			
		// case 3/4
		switches = 4'bxx10;
		#10;
		assert (leds[0] == 1'b1)
			$display ("Success led0: 3/4 Switch-to-LED s=xx10, led[0] = on");
		else $error("Failure led0: 3/4 Switch-to-LED s=xx10, led[0] != on");
			
		// case 4/4
		switches = 4'bxx11;
		#10;
		assert (leds[0] == 1'b0)
			$display ("Success led0: 4/4 Switch-to-LED s=xx11, led[0] = off");
		else $error("Failure led0: 4/4 Switch-to-LED s=xx11, led[0] != off");
			
		// ## 2b. led[1]
		// case 1/4
		switches = 4'b00xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("Success led1: 1/4 Switch-to-LED s=00xx, led[0] = off");
		else $error("Failure led1: 1/4 Switch-to-LED s=00xx, led[0] != off");
			
		// case 2/4
		switches = 4'b01xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("Success led1: 2/4 Switch-to-LED s=01xx, led[0] = on");
		else $error("Failure led1: 2/4 Switch-to-LED s=01xx, led[0] != on");
			
		// case 3/4
		switches = 4'b10xx;
		#10;
		assert (leds[1] == 1'b0)
			$display ("Success led1: 3/4 Switch-to-LED s=10xx, led[0] = on");
		else $error("Failure led1: 3/4 Switch-to-LED s=10xx, led[0] != on");
			
		// case 4/4
		switches = 4'b11xx;
		#10;
		assert (leds[1] == 1'b1)
			$display ("Success led1: 4/4 Switch-to-LED s=11xx, led[0] = off");
		else $error("Failure led1: 4/4 Switch-to-LED s=11xx, led[0] != off");
		// ### END OF 2. TEST IF SWITCH-TO-LED top-level assign logic works ###
		
		
		
		
		
		#100;
		$stop;
	end
endmodule