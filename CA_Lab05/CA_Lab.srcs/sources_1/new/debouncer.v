`timescale 1ns / 1ps

module debouncer #(
    parameter integer COUNT_MAX = 20'hFFFFF // Default for hardware
)(
    input wire clk,
    input wire pbin,    
    output wire pbout  
);
    reg [19:0] count = 0;    
    reg sync_0 = 0;          
    reg sync_1 = 0;          
    reg clean_out = 0;      

    assign pbout = clean_out;

    always @(posedge clk) begin
        sync_0 <= pbin;
        sync_1 <= sync_0;

        if (sync_1 != clean_out) begin
            count <= count + 1;
            // Use the parameter instead of a hardcoded value
            if (count >= COUNT_MAX) begin
                clean_out <= sync_1;
                count <= 0;
            end
        end
        else begin
            count <= 0;
        end
    end
endmodule