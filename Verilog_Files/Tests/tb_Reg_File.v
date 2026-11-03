`timescale 1ps/1ps

module tb_Reg_File ();

// Start a clock
reg CLK;
parameter Half_PERIOD = 50;
initial begin
    CLK = 1;
    forever #(Half_PERIOD) CLK = ~CLK;
end

// Inputs and outputs to the module
reg [2:0] RS1, RS2, RD;
reg [15:0] WRITE_DATA;
reg WE;
wire [15:0] DATA_A, DATA_B;

Reg_File reg_file(
    .rs1(RS1),
    .data_a(DATA_A),
    .rs2(RS2),
    .data_b(DATA_B),
    .rd(RD),
    .write_data(WRITE_DATA),
    .we(WE),
    .clk(CLK)
);

// Track the passing tests
integer passed = 0;
// Track the test number
integer testNum = 0;
// Used to store values expected as outputs for the tests
integer expectedA;
integer expectedB;

initial begin
    $display("Starting Reg File Tests");

    // Set WE low
    WE = 1'b0;

    @ (negedge CLK)
    // Test: Check initialazation
    testNum = testNum + 1;
    $display("Test %d: Check x1 initialized 0 and x2 initialized to 0xFFFF", testNum);
    // Set rs1 to 1 and rs2 to 2
    RS1 = 3'h1;
    RS2 = 3'h2;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'h0000;
    expectedB = 16'hFFFF;
    if (DATA_A != expectedA || DATA_B != expectedB) begin
        if (DATA_A != expectedA) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedA, DATA_A);
        end
        if (DATA_B != expectedB) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedB, DATA_B);
        end
    end else begin
        passed = passed + 1;
    end

    @ (negedge CLK)
    // Test: Try write to x0
    testNum = testNum + 1;
    $display("Test %d: Try write to x0", testNum);
    // Set we high
    WE = 1'b1;
    // Set rs1 and rs2
    RS1 = 3'h0;
    RS2 = 3'h0;
    // Set rd and write data
    RD = 3'h0;
    WRITE_DATA = 16'h1234;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'h0000;
    expectedB = 16'h0000;
    if (DATA_A != expectedA || DATA_B != expectedB) begin
        if (DATA_A != expectedA) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedA, DATA_A);
        end
        if (DATA_B != expectedB) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedB, DATA_B);
        end
    end else begin
        passed = passed + 1;
    end

    @ (negedge CLK)
    // Test: Try write to non-x0
    testNum = testNum + 1;
    $display("Test %d: Try write to non-x0, WE high", testNum);
    // Set we high
    WE = 1'b1;
    // Set rs1 and rs2
    RS1 = 3'h3;
    RS2 = 3'h7;
    // Set rd and write data
    RD = 3'h3;
    WRITE_DATA = 16'h1234;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'h1234;
    expectedB = 16'h0000;
    if (DATA_A != expectedA || DATA_B != expectedB) begin
        if (DATA_A != expectedA) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedA, DATA_A);
        end
        if (DATA_B != expectedB) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedB, DATA_B);
        end
    end else begin
        passed = passed + 1;
    end

    @ (negedge CLK)
    // Test: Try write to non-x0 with we low
    testNum = testNum + 1;
    $display("Test %d: Try write to non-x0, WE low", testNum);
    // Set we low
    WE = 1'b0;
    // Set rs1 and rs2
    RS1 = 3'h3;
    RS2 = 3'h7;
    // Set rd and write data
    RD = 3'h7;
    WRITE_DATA = 16'h1234;
    // Wait till the next clock cycle
    @ (posedge CLK)
    #5 // Wait a bit of time for propagation
    // Check the values
    expectedA = 16'h1234;
    expectedB = 16'h0000;
    if (DATA_A != expectedA || DATA_B != expectedB) begin
        if (DATA_A != expectedA) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedA, DATA_A);
        end
        if (DATA_B != expectedB) begin
            $display("Test %d failed. Expected %d | Recieved %d", testNum, expectedB, DATA_B);
        end
    end else begin
        passed = passed + 1;
    end

    // Let the last clock cycle display, then stop the sim
    @ (posedge CLK)
    $display("%d/%d Tests Passed", passed, testNum);
    $stop(0);
end

endmodule