`timescale 1ps/1ps

module tb_ALU ();

parameter add_op = 3'b000;
parameter sub_op = 3'b100;
parameter xor_op = 3'b001;
parameter or_op  = 3'b010;
parameter and_op = 3'b011;
parameter sll_op = 3'b101;
parameter srl_op = 3'b110;
parameter sra_op = 3'b111;

// Inputs and outputs to the module
reg [15:0] A, B;
reg [2:0] ALU_FUNCT;
wire [15:0] OUT;

ALU alu(
    .a(A),
    .b(B),
    .funct(ALU_FUNCT),
    .out(OUT)
);

// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
integer expected;

initial begin
    $display("Starting ALU Tests");

    // Test: Add test
    testNum = testNum + 1;
    $display("Test %d: Add", testNum);
    A = 16'h1234;
    B = 16'h4321;
    ALU_FUNCT = add_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'h5555;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end


    // Test: Sub test
    testNum = testNum + 1;
    $display("Test %d: Sub", testNum);
    A = 16'hABCD;
    B = 16'h0B0D;
    ALU_FUNCT = sub_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'hA0C0;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: Xor test
    testNum = testNum + 1;
    $display("Test %d: Xor", testNum);
    A = 16'hAAEE;
    B = 16'h5577;
    ALU_FUNCT = xor_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'hFF99;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: Or test
    testNum = testNum + 1;
    $display("Test %d: Or", testNum);
    A = 16'hAA55;
    B = 16'hEE22;
    ALU_FUNCT = or_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'hEE77;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: And test
    testNum = testNum + 1;
    $display("Test %d: And", testNum);
    A = 16'hAA55;
    B = 16'hEE22;
    ALU_FUNCT = and_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'hAA00;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: Sll test
    testNum = testNum + 1;
    $display("Test %d: Sll", testNum);
    A = 16'h1234;
    B = 16'h0004;
    ALU_FUNCT = sll_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'h2340;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: Srl test
    testNum = testNum + 1;
    $display("Test %d: Srl", testNum);
    A = 16'hF0F0;
    B = 16'h0008;
    ALU_FUNCT = srl_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'h00F0;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    // Test: Sra test
    testNum = testNum + 1;
    $display("Test %d: Sra", testNum);
    A = 16'hF0F0;
    B = 16'h0008;
    ALU_FUNCT = sra_op;
    #5 // Wait a bit of time for propagation
    // Check the value
    expected = 16'hFFF0;
    if (OUT != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, OUT);
    end else begin
        passed = passed + 1;
    end

    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule