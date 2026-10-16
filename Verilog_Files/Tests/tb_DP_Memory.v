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
integer total = 0;
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
integer expectedA = 0;
integer expectedB = 0;

initial begin
    $display("Starting Dual Port Memory Tests");

    // Explicitly set WE low for both halves
    WE_A = 1'b0;
    WE_B = 1'b0;

    // Test: Check initialazation to 0
    testNum = testNum + 1;
    total = total + 1;
    $display("Test %d: Check initialized to 0", testNum\);
    // Set addresses arbitrarily
    ADDR_A = 16'h00000000;
    ADDR_B = 16'hFFFFFFFF;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'h00000000;
    expectedB = 16'h00000000;
    if (OUT_A != expectedA) begin
        $display("Test %d_A failed. Expected %d | Recieved %d", testNum, expectedA, OUT_A);
    end
    if (OUT_B != expectedB) begin
        $display("Test %d_B failed. Expected %d | Recieved %d", testNum, expectedB, OUT_B);
    end
    if (OUT_A == expectedA && OUT_B == expectedB) begin
        passed = passed + 1;
    end

    // Test: Write to both sides
    testNum = testNum + 1;
    total = total + 1;
    $display("Test %d: Write to both sides", testNum);
    // Set input values arbitrarily
    IN_A = 16'hABCD1234;
    IN_B = 16'h6789CDEF;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'hABCD1234;
    expectedB = 16'h6789CDEF;
    if (OUT_A != expectedA) begin
        $display("Test %d_A failed. Expected %d | Recieved %d", testNum, expectedA, OUT_A);
    end
    if (OUT_B != expectedB) begin
        $display("Test %d_B failed. Expected %d | Recieved %d", testNum, expectedB, OUT_B);
    end
    if (OUT_A == expectedA && OUT_B == expectedB) begin
        passed = passed + 1;
    end

    // Test: Write to side A only, check B doesn't update
    testNum = testNum + 1;
    total = total + 1;
    $display("Test 3: Write to side A only and check B doesn't change");
    // Set input value for A arbitrarily
    IN_A = 16'hEFEFABAB;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'hEFEFABAB;
    // B shoulf not change from last time
    expectedB = 16'h6789CDEF;
    if (OUT_A != expectedA) begin
        $display("Test %d_A failed. Expected %d | Recieved %d", testNum, expectedA, OUT_A);
    end
    if (OUT_B != expectedB) begin
        $display("Test %d_B failed. Expected %d | Recieved %d", testNum, expectedB, OUT_B);
    end
    if (OUT_A == expectedA && OUT_B == expectedB) begin
        passed = passed + 1;
    end

    // Test: Write to side B only, check same addr A updates at the same time
    testNum = testNum + 1;
    total = total + 1;
    $display("Test 4: Write to side b only and check A with the same address changes at the same time");
    // Set input value for B arbitrarily
    IN_A = 16'hABCDEF00;
    // Set the address for A to the same as B
    ADDR_A = 16'hFFFFFFFF;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'hABCDEF00;
    // B shoulf not change from last time
    expectedB = 16'hABCDEF00;
    if (OUT_A != expectedA) begin
        $display("Test %d_A failed. Expected %d | Recieved %d", testNum, expectedA, OUT_A);
    end
    if (OUT_B != expectedB) begin
        $display("Test %d_B failed. Expected %d | Recieved %d", testNum, expectedB, OUT_B);
    end
    if (OUT_A == expectedA && OUT_B == expectedB) begin
        passed = passed + 1;
    end
    

    $display("Finished Tests: %d of %d passed", passed, total);
end

endmodule