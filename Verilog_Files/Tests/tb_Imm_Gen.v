`timescale 1ps/1ps

module tb_Imm_Gen ();

parameter Reg_opcode = 3'b000;
parameter Imm_opcode = 3'b001;
parameter LW_opcode = 3'b010;
parameter SW_opcode = 3'b011;
parameter LUI_opcode = 3'b100;
parameter Branch_opcode = 3'b101;
parameter Jump_opcode = 3'b110;
parameter JumpReg_opcode = 3'b111;

// Inputs and outputs to the module
reg [15:0] INSTR;
wire [15:0] IMM;

Imm_Gen immGen(
    .instr(INSTR),
    .imm(IMM)
);


// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
reg [15:0] expected;

initial begin
    $display("Starting Immediate Generator Tests");

    // Imm Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: Imm Type Positive Immediate", testNum);
    INSTR = {2'b00, 5'b01111, 3'b000, 3'b000, Imm_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h000F;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: Imm Type Negative Immediate", testNum);
    INSTR = {2'b00, 5'b10000, 3'b000, 3'b000, Imm_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFFF0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // LW Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: LW Type Positive Immediate", testNum);
    INSTR = {7'b0111111, 3'b000, 3'b000, LW_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h003F;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: LW Type Negative Immediate", testNum);
    INSTR = {7'b1000000, 3'b000, 3'b000, LW_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFFC0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // SW Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: SW Type Positive Immediate", testNum);
    INSTR = {4'b0111, 3'b000, 3'b000, 3'b111, SW_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h003F;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: SW Type Negative Immediate", testNum);
    INSTR = {4'b1000, 3'b000, 3'b000, 3'b000, SW_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFFC0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // Branch Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: Branch Type Positive Immediate", testNum);
    INSTR = {2'b00, 2'b01, 3'b000, 3'b000, 3'b111, Branch_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h000F;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: Branch Type Negative Immediate", testNum);
    INSTR = {2'b00, 2'b10, 3'b000, 3'b000, 3'b000, Branch_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFFF0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // LUI Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: LUI Type Positive Immediate", testNum);
    INSTR = {11'b01010101010, 2'b00, LUI_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h5540;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: LUI Type Negative Immediate", testNum);
    INSTR = {11'b10101010101, 2'b00, LUI_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hAAA0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // Jump Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: Jump Type Positive Immediate", testNum);
    INSTR = {10'b0101010101, 3'b000, Jump_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h0155;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: Jump Type Negative Immediate", testNum);
    INSTR = {10'b1010101010, 3'b000, Jump_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFEAA;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    // Jump Reg Type Tests
    // Positive Immediate
    testNum = testNum + 1;
    $display("Test %d: Jump Reg Type Positive Immediate", testNum);
    INSTR = {7'b0111111, 3'b000, 3'b000, JumpReg_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'h003F;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end
    // Negative Immediate
    testNum = testNum + 1;
    $display("Test %d: Jump Reg Type Negative Immediate", testNum);
    INSTR = {7'b1000000, 3'b000, 3'b000, JumpReg_opcode};
    #5 // Wait a bit of time for propagation
    // Check the immediate
    expected = 16'hFFC0;
    if (IMM != expected) begin
        $display("Test %d failed. Expected %d | Recieved %d", testNum, expected, IMM);
    end else begin
        passed = passed + 1;
    end


    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule