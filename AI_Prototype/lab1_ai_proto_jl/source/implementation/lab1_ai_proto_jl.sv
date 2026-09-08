// Written by Gemini Pro
// Target Device: Lattice iCE40UP5K
// Description: Drives an LED at 2 Hz using the internal high-speed oscillator (HSOSC)

module top (
    output logic led
);

    // Internal clock signal driven by the Lattice HSOSC primitive
    logic clk_48mhz;

    // Lattice iCE40 UltraPlus High-Speed Oscillator Primitive
    // Parameters configure the output frequency:
    // "0b00" = 48 MHz (Default)
    // "0b01" = 24 MHz
    // "0b10" = 12 MHz
    // "0b11" = 6 MHz
    HSOSC #(
        .CLKHF_DIV("0b00") 
    ) hf_osc_inst (
        .CLKHFPU(1'b1),     // Power up the oscillator
        .CLKHFEN(1'b1),     // Enable clock output
        .CLKHF  (clk_48mhz) // Output clock signal
    );

    // 48 MHz clock period = ~20.83 ns
    // To toggle an LED at 2 Hz (0.5s period), we need 24,000,000 clock cycles per toggle.
    // $clog2(24_000_000) requires a 25-bit counter (2^25 = 33,554,432).
    localparam int CLK_FREQ_HZ = 48_000_000;
    localparam int TOGGLE_COUNT = (CLK_FREQ_HZ / 2) - 1;

    logic [24:0] count = '0;

    // Clock division logic
    always_ff @(posedge clk_48mhz) begin
        if (count == TOGGLE_COUNT) begin
            count <= '0;
            led   <= ~led; // Toggle LED state every 0.5s (2 Hz toggle rate)
        end else begin
            count <= count + 1'b1;
        end
    end

endmodule