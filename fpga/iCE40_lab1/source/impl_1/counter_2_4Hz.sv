// Jessica Li  |  jesli@g.hmc.edu
// 09/05/2026
// This is a module used in the top-leve module "lab1_jl"
// It contains the sequential logic for an output of led[2] blinking at 2.4 Hz

module counter_2_4Hz(
	input   logic   clk, reset, en,
	output  logic   led
);
	// logic pulse;
	logic led_state = 0;
	logic [24:0] counter = 0;
	const logic [24:0] max_count = 25'b00_1001_1000_1001_0110_1000_000; // max counter 5 million to convert 5 million cycles into one cycle (at a pace of 2.4 Hz)
	
	always_ff @(posedge clk) begin
			if (reset == 0) counter <= 0;
			else if (en) begin
				if (counter >= max_count) begin
					led_state <= ~led_state; // toggles led state on or off once cycle time up
					counter <= 0;
					end
				else counter <= counter + 1;
			end 
		end
		
	assign led = led_state;

endmodule