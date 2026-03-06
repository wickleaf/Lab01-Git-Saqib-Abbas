module debouncer(
    input clk,
    input pbin,
    output pbout
);

    reg sync_0, sync_1;
    always @(posedge clk) begin
        sync_0 <= pbin;
        sync_1 <= sync_0;
    end

    reg [29:0] divider = 0;
    reg sample_en = 0;
    always @(posedge clk) begin
        if (divider >= 249999) begin
            divider <= 0;
            sample_en <= 1;
        end else begin
            divider <= divider + 1;
            sample_en <= 0;
        end
    end

    reg [2:0] shift_reg = 0;
    always @(posedge clk) begin
        if (sample_en)
            shift_reg <= {shift_reg[1:0], sync_1};
    end

    wire stable_high = &shift_reg;

    reg prev_stable = 0;
    always @(posedge clk)
        prev_stable <= stable_high;

    assign pbout = stable_high & ~prev_stable;
endmodule