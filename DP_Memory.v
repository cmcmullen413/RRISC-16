// Dual Port Memory to be used for instruction and regular memory
module DP_Memory

// Reduced ADDR_WIDTH so my computer doesn't blow up
//
#(parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 8)
(
    input wire [DATA_WIDTH-1:0] in_a, in_b
    input wire [ADDR_WIDTH-1:0] addr_a, addr_b,
    input wire clk_a, clk_b, we_a, we_b,                // Two clocks allows for reading and writing of each port on different edges
    output reg [DATA_WIDTH-1:0] out_a, out_b
)

// Declare the RAM
reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

initial begin
    // Currently just starts everything as zeros
    integer i;
    for (i = 0; i < 2**ADDR_WIDTH-1; i = i + 1) begin
        rom[i] = {DATA_WIDTH{0}};
    end
    // TODO: Make this load from a text file
end

// Update outputs on rising edge for the respecive clock
// To do a falling edge, the input clock can be inverted
always @ (posedge clk_a) begin
    // If writing is enabled, update the value
    if (we_a) begin
        ram[addr_a] <= in_a;
    end
    // Update the output
    out_a <= ram[addr_a];
end
always @ (posedge clk_b) begin
    // If writing is enabled, update the value
    if (we_b) begin
        ram[addr_b] <= in_b;
    end
    // Update the output
    out_b <= ram[addr_b];
end


endmodule