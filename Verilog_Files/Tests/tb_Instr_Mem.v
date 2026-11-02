`timescale 1ps/1ps

module tb_Memory ();

// Start a clock
reg CLK;
parameter Half_PERIOD = 50;
initial begin
    CLK = 1;
    forever #(Half_PERIOD) CLK = ~CLK;
end

// Inputs and outputs to the module
reg [15:0] ADDR;
wire [15:0] OUT;

Instr_Memory mem(
    .addr(ADDR),
    .out_a(OUT),
    .clk_a(CLK),
);

// Track the passing tests
integer total = 0;
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
integer expected;

initial begin
    $display("Starting Instruction Memory Tests");

    @ (negedge CLK)
    // Test: Check initialazation to 0 #1
    testNum = testNum + 1;
    total = total + 1;
    $display("Test %d: Check initialized to 0 #1", testNum);
    // Set address arbitrarily
    ADDR = 16'h1234;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expected = 16'h0000;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    @ (negedge CLK)
    // Test: Check initialazation to 0 #2
    testNum = testNum + 1;
    total = total + 1;
    $display("Test %d: Check initialized to 0 #2", testNum);
    // Set address arbitrarily
    ADDR = 16'hFFF0;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expected = 16'h0000;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Let the last clock cycle display, then stop the sim
    @ (posedge CLK)
    $stop(0);
end

endmodule