`timescale 1ps/1ps

module tb_ALU_Control ();

parameter add_op = 3'b000;
parameter sub_op = 3'b100;
parameter xor_op = 3'b001;
parameter or_op  = 3'b010;
parameter and_op = 3'b011;
parameter sll_op = 3'b101;
parameter srl_op = 3'b110;
parameter sra_op = 3'b111;

// Inputs and outputs to the module
reg [1:0] ALUOP, F2;
reg FR;
wire [2:0] ALUFUNCT;

ALU_Control aluControl(
    .ALUOp(ALUOP),
    .f2(F2),
    .fr(FR),
    .ALUfunct(ALUFUNCT)
);


// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
reg [2:0] expected;

initial begin
    $display("Starting ALU Control Tests");

    // Tests: R Types ALUOp
    //
    // Add
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - add", testNum);
    ALUOP = 2'b00;
    F2 = 2'b00;
    FR = 1'b0;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = add_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SLL
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - sll", testNum);
    ALUOP = 2'b00;
    F2 = 2'b01;
    FR = 1'b0;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sll_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SRL
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - srl", testNum);
    ALUOP = 2'b00;
    F2 = 2'b10;
    FR = 1'b0;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = srl_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SRA
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - sra", testNum);
    ALUOP = 2'b00;
    F2 = 2'b11;
    FR = 1'b0;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sra_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SUB
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - sub", testNum);
    ALUOP = 2'b00;
    F2 = 2'b00;
    FR = 1'b1;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sub_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // XOR
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - xor", testNum);
    ALUOP = 2'b00;
    F2 = 2'b01;
    FR = 1'b1;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = xor_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // OR
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - or", testNum);
    ALUOP = 2'b00;
    F2 = 2'b10;
    FR = 1'b1;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = or_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // AND
    testNum = testNum + 1;
    $display("Test %d: R-Type ALUOp - and", testNum);
    ALUOP = 2'b00;
    F2 = 2'b11;
    FR = 1'b1;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = and_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    

    // Tests: I Types ALUOp
    //
    // Add
    testNum = testNum + 1;
    $display("Test %d: I-Type ALUOp - add", testNum);
    ALUOP = 2'b01;
    F2 = 2'b00;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = add_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SLL
    testNum = testNum + 1;
    $display("Test %d: I-Type ALUOp - sll", testNum);
    ALUOP = 2'b01;
    F2 = 2'b01;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sll_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SRL
    testNum = testNum + 1;
    $display("Test %d: I-Type ALUOp - srl", testNum);
    ALUOP = 2'b01;
    F2 = 2'b10;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = srl_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end
    // SRA
    testNum = testNum + 1;
    $display("Test %d: I-Type ALUOp - sra", testNum);
    ALUOP = 2'b01;
    F2 = 2'b11;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sra_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end


    // Test: Add ALUOp
    testNum = testNum + 1;
    $display("Test %d: Add ALUOp", testNum);
    ALUOP = 2'b10;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = add_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end


    // Test: Sub ALUOp
    testNum = testNum + 1;
    $display("Test %d: Sub ALUOp", testNum);
    ALUOP = 2'b11;
    #5 // Wait a bit of time for propagation
    // Check the funct
    expected = sub_op;
    if (ALUFUNCT != expected) begin
        $display("Test %d failed. Expected %b | Recieved %b", testNum, expected, ALUFUNCT);
    end else begin
        passed = passed + 1;
    end


    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule