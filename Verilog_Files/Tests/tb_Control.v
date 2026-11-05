`timescale 1ps/1ps

module tb_Control ();

parameter Reg_opcode = 3'b000;
parameter Imm_opcode = 3'b001;
parameter LW_opcode = 3'b010;
parameter SW_opcode = 3'b011;
parameter LUI_opcode = 3'b100;
parameter Branch_opcode = 3'b101;
parameter Jump_opcode = 3'b110;
parameter JumpReg_opcode = 3'b111;

// Inputs and outputs to the module
reg [2:0] OPCODE;
wire REGWRITE, MEMREAD, MEMWRITE, ALUSRC;
wire [1:0] ALUOP;
wire BRANCH, JUMP, JUMPREG;
wire [1:0] REGSRC;
wire LURD;

Control control(
    .opcode(OPCODE),
    .regWrite(REGWRITE),
    .memRead(MEMREAD),
    .memWrite(MEMWRITE),
    .ALUSrc(ALUSRC),
    .ALUOp(ALUOP),
    .branch(BRANCH),
    .jump(JUMP),
    .jumpReg(JUMPREG),
    .regSrc(REGSRC),
    .lurd(LURD)
);

wire [11:0] CONTROL_LINES;
assign CONTROL_LINES = {REGWRITE, MEMREAD, MEMWRITE, ALUSRC, ALUOP, BRANCH, JUMP, JUMPREG, REGSRC, LURD};

// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
reg [11:0] expected;

initial begin
    $display("Starting Control Tests");

    // Test: Reg type
    testNum = testNum + 1;
    $display("Test %d: Reg Type", testNum);
    OPCODE = Reg_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b1x0000000000;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end


    // Test: Imm test
    testNum = testNum + 1;
    $display("Test %d: Imm Type", testNum);
    OPCODE = Imm_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b1x0100000000;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: LW test
    testNum = testNum + 1;
    $display("Test %d: Load Word Type", testNum);
    OPCODE = LW_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b110110000010;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: SW test
    testNum = testNum + 1;
    $display("Test %d: Store Word Type", testNum);
    OPCODE = SW_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b0x1110000xxx;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: LUI test
    testNum = testNum + 1;
    $display("Test %d: Load Upper Immediate Type", testNum);
    OPCODE = LUI_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b1x0xxx000101;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: Branch test
    testNum = testNum + 1;
    $display("Test %d: Branch Type", testNum);
    OPCODE = Branch_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b0x0011100xxx;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: Jump test
    testNum = testNum + 1;
    $display("Test %d: Jump Type", testNum);
    OPCODE = Jump_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b1x0xxxx10110;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    // Test: Jump Reg test
    testNum = testNum + 1;
    $display("Test %d: Jump Reg Type", testNum);
    OPCODE = JumpReg_opcode;
    #5 // Wait a bit of time for propagation
    // Check the control lines
    expected = 12'b1x0xxxxx1110;
    if (CONTROL_LINES != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, CONTROL_LINES);
    end else begin
        passed = passed + 1;
    end

    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule