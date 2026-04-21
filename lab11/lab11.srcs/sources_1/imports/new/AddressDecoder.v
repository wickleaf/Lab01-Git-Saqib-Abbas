`timescale 1ns / 1ps

module AddressDecoder(
    input [1:0] address,
    input readEnable,
    input writeEnable,
    output dataMemWrite,
    output dataMemRead,
    output LEDWrite,
    output switchReadEnable
);

    assign dataMemWrite     = (address == 2'b00) ? writeEnable : 1'b0;
    assign dataMemRead      = (address == 2'b00) ? readEnable  : 1'b0;
    assign LEDWrite         = (address == 2'b01) ? writeEnable : 1'b0;
    assign switchReadEnable = (address == 2'b10) ? readEnable  : 1'b0;
    
endmodule