`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 09:19:10 PM
// Design Name: 
// Module Name: leds
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


module leds(
    input clk,
    input rst,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [29:0] memAddress,
    output reg [31:0] readData = 0,
    output [15:0] leds
);

    reg [7:0] led_low = 0;
    reg [7:0] led_high = 0;

    always @(posedge clk) begin
        if (rst) begin
            led_low <= 8'b0;
            led_high <= 8'b0;
        end
        else if (writeEnable) begin
            led_low <= writeData[7:0];
            led_high <= writeData[15:8];
        end
    end

    assign leds = {led_high, led_low};
endmodule
