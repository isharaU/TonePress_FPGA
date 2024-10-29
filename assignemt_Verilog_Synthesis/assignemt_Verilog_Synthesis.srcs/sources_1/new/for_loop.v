`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2024 10:56:15 PM
// Design Name: 
// Module Name: for_loop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module for_loop(
    input [15:0] in,
output reg [4:0] out
);
integer i;

always @(*) begin: count
out = 0;
for (i = 15; i >= 0; i = i - 1) begin
    if (~in[i]) disable count;
    out = out + 1;
end
end

endmodule
