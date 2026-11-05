module Register(
    input wire [15:0] d,
    input wire clk,
    input wire we,
    input wire reset,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset == 1'b1) begin
        q <= 16'h0000;
    end else if (we == 1'b1) begin
        q <= d;
    end
end

endmodule