`timescale 1ps/1ps

module tb_Instruction_Memory ();

// Start a clock
reg CLK;
parameter Half_PERIOD = 50;
initial begin
    CLK = 1;
    forever #(Half_PERIOD) CLK = ~CLK;
end

// Inputs and outputs to the module
reg [15:0] ADDR_A, ADDR_B;
reg [15:0] IN_A, IN_B;
wire [15:0] OUT_A, OUT_B;
reg WE_A, WE_B;

DP_Memory mem(
    .addr_a(ADDR_A),
    .in_a(IN_A),
    .out_a(OUT_A),
    .clk_a(CLK),
    .we_a(WE_A),

    .addr_b(ADDR_B),
    .in_b(IN_B),
    .out_b(OUT_B),
    .clk_b(CLK),
    .we_b(WE_B)
);

// Track the passing tests
integer passed = 0;
integer total = 0;
initial begin
    $display("Starting Dual Port Memory Tests");

    // TODO Put tests in here

    $display("Finished Tests. %d of %d Passed", passed, total);
end

endmodule