// Jessica Li  |  jesli@g.hmc.edu
// 09/05/2026
// This is a module used in the top-leve module "lab1_jl"
// It contains the sequential logic for an output of led[2] blinking at 2.4 Hz

module counter_2_4Hz
	#(parameter WIDTH = 25,
		EN = 1) (
	input   logic   clk, rst,
	output  logic   led
);
	// logic pulse;
	logic led_state = 0;
	logic [WIDTH-1:0] counter = 0;
	const logic [WIDTH-1:0] max_count = 10_000_000; // max counter 10 million to convert 10 million cycles into one cycle (at a pace of 2.4 Hz)
	
	always_ff @(posedge clk) begin
			if (rst == 0) begin
				counter <= 0;
				led_state <= 0;
			end
			else if (EN) begin
				if (counter >= max_count) begin
					led_state <= ~led_state; // toggles led state on or off once cycle time up
					counter <= 0;
				end
				else counter <= counter + 1'b1;
			end 
	end
		
	assign led = led_state;

endmodule