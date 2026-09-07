// Jessica Li  |  jesli@g.hmc.edu
// 09/06/2026
// This is a test bench for the sequential sub module counter_2_4Hz
// It contains the sequential logic for an output of led[2] blinking at 2.4 Hz

`timescale 1 ns/1 ns

module lab1_counter_2_4Hz_tb();
	
	logic   clock;
	logic   reset;
	logic   enable;
	logic   blinker_led;

	counter_2_4Hz dut(
		.clk(clock),
		.rst(reset),
		.en(enable),
		.led(blinker_led)
	);
	
	// generate fake clock 
	always begin
		clock = 0;
		#10;
		clock = 1;
		#10;
	end
		
	// test cases
	initial begin
		enable = 1;
		reset = 1; 
		#20;
		enable = 0; // should freeze counter at 0
		reset = 0;
		#80;
		assert (dut.counter == 0)
			$display("1. Success: Enable = 0 has successfully kept counter at 0, no writing.");
		else
			$error("1. Failure: Enable = 0 unable to prevent writing to counter");
		enable = 1; // allow writing 
		
		#200000000; // 200 million ns = 0.2 sec wait time for counter to reach max count
		#20; // after max count reached, reset back to 0
		assert (dut.counter == 0)
			$display("2. Success: counter wraps back to 0 when it reaches max count.");
		else
			$error("2. Failure: Counter does not wrap back to 0 when it reaches max count. Counter is %d", dut.counter);
		assert (blinker_led == 1)
			$display("3. Success: blinker_led turns on once first max count is reached.");
		else
			$error("3. Failure: blinker_led is off even after first max count is reached.");
		
		#200;
		assert (dut.counter > 0)
			$display("4. Success: counter is counting up.");
		else
			$error("4. Failure: counter is not counting up??");
		
		reset = 1;
		#20;
		assert ((dut.counter == 0) & (blinker_led ==0))
			$display("5. Success: Reset has returned counter and blinker_led to 0");
		else
			$error("5. Failed: Reset has not returned countern and blinker_led to 0");
		reset = 0;
		
		
		#100;
		$stop;
	end

endmodule