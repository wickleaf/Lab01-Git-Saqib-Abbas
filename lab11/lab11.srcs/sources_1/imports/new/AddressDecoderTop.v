`timescale 1ns / 1ps
module AddressDecoderTOP(
    input clk,
    input rst,
    input [31:0] address,
    input readEnable,
    input writeEnable,
    input [31:0] writeData,
    input [15:0] switches_in,   // renamed to avoid conflict with module name
    output [31:0] readData,
    output [15:0] leds_out
);
    wire dataMemWrite, dataMemRead, LEDWrite, switchReadEnable;
    wire [31:0] dm_readData, sw_readData;

    // Address Decoder
    AddressDecoder ad (
        .address(address[9:8]),
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .dataMemWrite(dataMemWrite),
        .dataMemRead(dataMemRead),
        .LEDWrite(LEDWrite),
        .switchReadEnable(switchReadEnable)
    );

    // Data Memory
    DataMemory dataMem (
        .clk(clk),
        .rst(rst),
        .address(address[7:0]),
        .memWrite(dataMemWrite),
        .writeData(writeData),
        .readData(dm_readData)
    );

    // LED module - new interface requires readEnable and memAddress
    leds led_inst (
        .clk(clk),
        .rst(rst),
        .writeData(writeData),
        .writeEnable(LEDWrite),
        .readEnable(1'b0),              // LEDs are write-only in this system
        .memAddress(address[31:2]),     // pass upper bits as memAddress [29:0]
        // readData output unused
        .leds(leds_out)
    );

    // Switch module - new interface requires btns, writeData, writeEnable, memAddress
    switches sw_inst (
        .clk(clk),
        .rst(rst),
        .btns(16'b0),                   // no physical buttons used here
        .writeData(32'b0),              // switches are read-only
        .writeEnable(1'b0),
        .readEnable(switchReadEnable),
        .memAddress(address[31:2]),
        .switches(switches_in),
        .readData(sw_readData)
    );

    // Read data MUX
    assign readData = (address[9:8] == 2'b00) ? dm_readData :
                      (address[9:8] == 2'b10) ? sw_readData :
                      32'b0;

endmodule