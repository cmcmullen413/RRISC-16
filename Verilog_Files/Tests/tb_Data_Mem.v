`timescale 1ps/1ps

module tb_Data_Mem ();

// Start a clock
reg CLK;
parameter Half_PERIOD = 50;
initial begin
    CLK = 1;
    forever #(Half_PERIOD) CLK = ~CLK;
end

// Inputs and outputs to the module
reg [15:0] IN;
reg [15:0] ADDR;
reg WE;
wire [15:0] OUT;

Data_Memory mem(
    .in(IN),
    .addr(ADDR),
    .we(WE),
    .out(OUT),
    .clk(CLK)
);

// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
integer expected;

initial begin
    $display("Starting Instruction Memory Tests");

    // Explicitly set WE to low
    WE = 1'b0;

    @ (negedge CLK)
    // Test: Check initialazation to 0 #1
    testNum = testNum + 1;
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

    @ (negedge CLK)
    // Test: Try write with we low
    testNum = testNum + 1;
    $display("Test %d: Try write with we low", testNum);
    // Set address arbitrarily
    IN = 16'h1234;
    ADDR = 16'hABCD;
    // Wait two clock cycles for read propagation
    @ (posedge CLK)
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
    // Test: Try write with we high
    testNum = testNum + 1;
    $display("Test %d: Try write with we high", testNum);
    // Set address arbitrarily
    WE = 1'b1;
    // Wait two clock cycles for read propagation
    @ (posedge CLK)
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expected = 16'h1234;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    @ (negedge CLK)
    // Test: Check read for other address didn't change
    testNum = testNum + 1;
    $display("Test %d: Check read for other address didn't change", testNum);
    // Set address arbitrarily
    WE = 1'b0;
    ADDR = 16'hAAAA;
    // Wait two clock cycles for read propagation
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
    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule