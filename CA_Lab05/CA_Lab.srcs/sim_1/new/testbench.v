`timescale 1ns / 1ps
module tb_fsm_counter;
reg clk;
reg btnC;
reg [15:0] sw;
wire [15:0] led;
// Instantiate Top Module with a tiny clock divider for fast simulation
fsm_counter_top #(
.CLOCK_FREQ(5) // Normally 100,000,000. Set to 5 for fast simulation ticks
) dut (
.clk(clk),
.btnC(btnC),
.sw(sw),
.led(led)
);
// 100 MHz clock generation
initial clk = 0;
always #5 clk = ~clk;
initial begin
btnC = 1;
sw = 16'd0;
#100;
btnC = 0;
#50;
sw = 16'd8;
#20;
sw = 16'd0;
#400;
sw = 16'd15; // Start a new count from 15
#100;
btnC = 1; // Press reset mid-count
#50;
btnC = 0;
#200;
$stop;
end
endmodule