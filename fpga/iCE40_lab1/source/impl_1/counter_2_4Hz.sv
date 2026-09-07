// Jessica Li  |  jesli@g.hmc.edu
// 09/06/2026
// This is a module used in the top-leve module "lab1_jl"
// It contains the sequential logic for an output of led[2] blinking at 2.4 Hz

module counter_2_4Hz
	#(parameter WIDTH = 25,
		MAX_COUNT = 10_000_000) (
	input   logic   clk, rst, en,
	output  logic   led
);

	logic led_state = 0;
	logic [WIDTH-1:0] counter = 0;
	
	always_ff @(posedge clk) begin
			if (rst) begin
				counter <= 0;
				led_state <= 0;
			end
			else if (en) begin
				if (counter >= MAX_COUNT) begin
					led_state <= ~led_state; // toggles led state on or off once desired cycle time up
					counter <= 0;
				end
				else counter <= counter + 1'b1;
			end 
	end
		
	assign led = led_state;

endmodule