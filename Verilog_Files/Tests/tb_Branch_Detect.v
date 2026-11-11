`timescale 1ps/1ps

module tb_Branch_Control ();

parameter eq_f2 = 2'b00;
parameter ne_f2 = 2'b01;
parameter lt_f2 = 2'b10;
parameter ge_f2 = 2'b11;

// Inputs and outputs to the module
reg BRANCH, ZERO, MSB;
reg [1:0] F2;
wire BRANCHCONTROL;

Branch_Detect branchDetect(
    .branch(BRANCH),
    .zero(ZERO),
    .msb(MSB),
    .f2(F2),
    .branchControl(BRANCHCONTROL)
);


// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
reg expected;

initial begin
    $display("Starting Branch Detect Tests");

    // BEQ no branch
    testNum = testNum + 1;
    $display("Test %d: BEQ zero low", testNum);
    BRANCH = 1'b1;
    ZERO = 1'b0;
    MSB = 1'bx;
    F2 = eq_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b0;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end
    // BEQ branch
    testNum = testNum + 1;
    $display("Test %d: BEQ zero high", testNum);
    BRANCH = 1'b1;
    ZERO = 1'b1;
    MSB = 1'bx;
    F2 = eq_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b1;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end

    // BNE no branch
    testNum = testNum + 1;
    $display("Test %d: BNE zero high", testNum);
    BRANCH = 1'b1;
    ZERO = 1'b1;
    MSB = 1'bx;
    F2 = ne_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b0;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end
    // BNE branch
    testNum = testNum + 1;
    $display("Test %d: BNE zero high", testNum);
    BRANCH = 1'b1;
    ZERO = 1'b0;
    MSB = 1'bx;
    F2 = ne_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b1;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end

    // BLT no branch
    testNum = testNum + 1;
    $display("Test %d: BLT msb low", testNum);
    BRANCH = 1'b1;
    ZERO = 1'bx;
    MSB = 1'b0;
    F2 = lt_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b0;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end
    // BLT branch
    testNum = testNum + 1;
    $display("Test %d: BLT msb high", testNum);
    BRANCH = 1'b1;
    ZERO = 1'bx;
    MSB = 1'b1;
    F2 = lt_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b1;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end

    // BGE no branch
    testNum = testNum + 1;
    $display("Test %d: BGE msb high", testNum);
    BRANCH = 1'b1;
    ZERO = 1'bx;
    MSB = 1'b1;
    F2 = ge_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b0;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end
    // BGE branch
    testNum = testNum + 1;
    $display("Test %d: BGE msb low", testNum);
    BRANCH = 1'b1;
    ZERO = 1'bx;
    MSB = 1'b0;
    F2 = ge_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b1;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end

    // Branch control low
    testNum = testNum + 1;
    $display("Test %d: Branch control low", testNum);
    BRANCH = 1'b0;
    ZERO = 1'bx;
    MSB = 1'b0;
    F2 = ge_f2;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = 1'b0;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, BRANCHCONTROL);
    end else begin
        passed = passed + 1;
    end

    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule