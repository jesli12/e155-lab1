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
	inital begin
		enable = 1;
		reset = 1; 
		#20;
		enable = 0; // should freeze counter at 0
		reset = 0;
		#80;
		assert (counter == 0)
			$display("Success: Enable = 0 has successfully kept counter at 0, no writing.");
		else
			$error("Failure: Enable = 0 unable to prevent writing to counter");
		enable = 1; // allow writing 
		
		#20000000; // 200 million ns = 20 second wait time for counter to reach max count
		#20; // after max count reached, reset back to 0
		assert (counter == 0)
			$display("Success: counter wraps back to 0 when it reaches max count.");
		else
			$error("Failure: Counter does not wrap back to 0 when it reaches max count.");
		assert (blinker_led == 1)
			$display("Success: blinker_led turns on once first max count is reached.");
		else
			$error("Failure: blinker_led is off even after first max count is reached.");
		
		#200;
		assert (counter > 0)
			$display("Success: counter is counting up.");
		else
			$error("Failure: counter is not counting up??");
		
		reset = 1;
		#10;
		assert ((counter == 0) & (blinker_led ==0))
			$display("Success: Reset has returned counter and blinker_led to 0");
		else
			$error("Failed: Reset has not returned countern and blinker_led to 0");
		reset = 0;
		
		
		#100;
		$stop;
	end

endmodule