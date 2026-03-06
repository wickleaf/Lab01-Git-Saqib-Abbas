`timescale 1ns / 1ps
module fsm_controller(
input clk,
input rst,
input [31:0] switch_data,
output reg [31:0] led_data,
output reg led_write_en,
output reg switch_read_en
);
localparam IDLE = 1'b0;
localparam COUNTDOWN = 1'b1;
reg state, next_state;
reg [15:0] counter;
reg [26:0] ticker;
wire tick;
always @(posedge clk or posedge rst) begin
if(rst) ticker <= 0;
else ticker <= ticker + 1;
end
assign tick = (ticker == 0);
always @(posedge clk or posedge rst) begin
if (rst) begin
state <= IDLE;
counter <= 0;
led_data <= 0;
led_write_en <= 0;
end else begin
state <= next_state;
case (state)
IDLE: begin
led_write_en <= 1;
led_data <= 0;
if (switch_data[15:0] != 0) begin
counter <= switch_data[15:0];
end
end
COUNTDOWN: begin
led_write_en <= 1;
led_data <= {16'b0, counter};
if (tick && counter > 0)counter <= counter - 1;
end
endcase
end
end
always @(*) begin
switch_read_en = 0;
case (state)
IDLE: begin
switch_read_en = 1;
if (switch_data[15:0] != 0)
next_state = COUNTDOWN;
else
next_state = IDLE;
end
COUNTDOWN: begin
if (counter == 0)
next_state = IDLE;
else
next_state = COUNTDOWN;
end
default: next_state = IDLE;
endcase
end
endmodule
