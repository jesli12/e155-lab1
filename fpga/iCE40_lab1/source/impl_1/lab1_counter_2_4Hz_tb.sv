// Jessica Li  |  jesli@g.hmc.edu
// 09/06/2026
/* This is a test bench for the sequential sub module counter_2_4Hz
	Goal: check 3 features of the counter submodule
		1. Enable (pause/resume write to counter)
		2. Reaching Max_Count returns counter to 0 and toggles LED
		3. Reset (on sets both counter and led_state)
*/


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
		// ### FIRST reset values to have a known starting value.
		enable = 1;  // allow writing to counter
		reset = 1;   // reset blinker_led to 0, counter to 0
		#20;
		enable = 0; // pause writing to counter (should freeze counter at 0)
		reset = 0;  // turn off reset (so blinker_led and counter don't stay at reset state)
		
		// ### TEST 1a: Enable prevents counter from changing.
		#80;
		assert (dut.counter == 0)
			$display("1a. Success [Enable]: Enable = 0 has successfully kept counter at 0, no writing. Time: %0t.", $time);
		else
			$error("1a. Failure: Enable = 0 unable to prevent writing to counter. Time: %0t.", $time);
			
			
		// ## TEST 1b: Enabled Enable unfreezes counter, allowing counter to increase with clock cycles.
		enable = 1; // allow writing 
		#200000000; // 200 million ns = 10 million cycles (recall max count is 10 million)
		
		// The following confirms 2 things: Did enable = 1 allow for counter to incrase? and Did counter reach max count as expected?
		assert (dut.counter == 10_000_000)
			$display("1b. Success [Counter & Enable]: Counter counted up to max count of 10 000 000 as expected. Time: %0t.", $time);
		else
			$error("1b. Failure: Counter did not reach max count in expected cycles. Counter: %0d. Time: %0t.", dut.counter, $time);
		
		// ## Test 1c. Enable = 0 can hold a non-zero number. (This test is just for thoroughness)
		enable = 0; // pause all writing, counter should freeze at max count.
		#200 // 10 cycles, shouldn't change count
		assert (dut.counter == 10_000_000)
			$display("1c. Success [Enable]: Enable = 0 leads to counter holding 10 000 000 as expected. Time: %0t.", $time);
		else
			$error("1c. Failure [Enable]: Enable = 0 did not lead to counter holding 10 000 000. Counter: %0d. Time: %0t.", dut.counter, $time);
		enable = 1;
		
		// ### TEST 2: Reaching max count resets the counter AND blinker_led to 0
		#20; // after max count reached, one more cycle to reset back to 0
		assert (dut.counter == 0)
			$display("2a. Success [Max Count Counter Reset]: counter wraps back to 0 when it reaches max count. Time: %0t.", $time);
		else
			$error("2a. Failure [Max Count Counter Reset]: Counter does not wrap back to 0 when it reaches max count. Counter: %0d. Time: %0t.", dut.counter, $time);
		assert (blinker_led == 1)
			$display("2b. Success [Max Count LED Toggle]: blinker_led turns on once first max count is reached.");
		else
			$error("2b. Failure [Max Count LED Toggle]: blinker_led is off even after first max count is reached.");
		
		// ### TEST 3: Reset sets counter and blinker_led to 0
		// This test is important to run here because blinker_led = 1 and we run some cycles (200 ns = 10 cycles) to make sure counter > 0
		// Thus, after a reset, checking that both are 0 is evidence that reset has worked.
		
		#200;
		assert (dut.counter > 0)
			$display("3a. Success: counter is counting up, and is non-zero. Counter: %0d. Time: %0t.", dut.counter, $time);
		else
			$error("3a. Failure: counter is not counting up, stuck at 0. Counter: %0d. Time: %0t.", dut.counter, $time);
		
		reset = 1;
		#20;
		assert ((dut.counter == 0) & (blinker_led ==0))
			$display("3b. Success [Reset]: Reset has returned counter and blinker_led to 0. Time: %0t.", $time);
		else
			$error("3b. Failed [Reset]: Reset has not returned countern and blinker_led to 0. Counter: %0d. Time: %0t.", dut.counter, $time);
		reset = 0;
		#100;
		$stop;
	end

endmodule