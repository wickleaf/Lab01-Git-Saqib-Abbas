module topLevelModule(
    input clk, btn_reset,
    input [15:0] sw,
    output [15:0] leds
);

    wire clean_reset;
    debouncer db(
        .clk(clk),
        .pbin(btn_reset),
        .pbout(clean_reset)
    );

    wire [31:0] sw_readData;
    switches sw_inst(
        .clk(clk),
        .rst(clean_reset),
        .btns(16'b0),
        .writeData(32'b0),
        .writeEnable(1'b0),
        .readEnable(1'b1),
        .memAddress(30'b0),
        .switches(sw),
        .readData(sw_readData)
    );

    wire [31:0] Result;
    wire zero;
    
    ALU_top alu(
        .A(32'h10101010),
        .B(32'h01010101),
        .ALUControl(sw_readData[3:0]),
        .ALUResult(Result),
        .zero(zero)
    );
    
    leds led_inst (
        .clk(clk),
        .rst(clean_reset),
        .writeData({16'b0, zero, Result[14:0]}),
        .writeEnable(1'b1),         
        .readEnable(1'b0),          
        .memAddress(30'b0),         
        .readData(),                
        .leds(leds)
    );

endmodule