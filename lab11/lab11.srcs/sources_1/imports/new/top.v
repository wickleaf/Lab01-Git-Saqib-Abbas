module top_control (
    input         clk,
    input         rst,
    input  [15:0] sw,
    output [15:0] led
    );
    
    localparam IDLE    = 2'b00;
    localparam COMPUTE = 2'b01;
    localparam DISPLAY = 2'b10;
    
    reg [1:0] state, next_state;
    
    wire [31:0] sw_readData;
    
    switches sw_inst (
        .clk        (clk),
        .rst        (rst),
        .btns       (16'b0),
        .writeData  (32'b0),
        .writeEnable(1'b0),
        .readEnable (1'b1),
        .memAddress (30'b0),
        .switches   (sw),
        .readData   (sw_readData)
    );
    
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    
    assign opcode = sw_readData[14:8];
    assign funct3 = sw_readData[7:5];
    assign funct7 = {1'b0, sw_readData[4], 5'b0};
    
    wire        RegWrite;
    wire        MemRead;
    wire        MemWrite;
    wire        ALUSrc;
    wire        MemtoReg;
    wire        Branch;
    wire [1:0]  ALUOp;
    
    main_control uut_main (
        .opcode   (opcode),
        .RegWrite (RegWrite),
        .ALUOp    (ALUOp),
        .MemRead  (MemRead),
        .MemWrite (MemWrite),
        .ALUSrc   (ALUSrc),
        .MemtoReg (MemtoReg),
        .Branch   (Branch)
    );
    
    wire [3:0] ALUControl;
    
    alu_control uut_alu (
        .ALUOp      (ALUOp),
        .funct3     (funct3),
        .funct7     (funct7),
        .ALUControl (ALUControl)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) state <= IDLE;
        else     state <= next_state;
    end
    
    always @(*) begin
        case (state)
            IDLE   : next_state = COMPUTE;
            COMPUTE: next_state = DISPLAY;
            DISPLAY: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    reg [31:0] led_writeData;
    reg        led_writeEnable;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led_writeData   <= 32'b0;
            led_writeEnable <= 1'b0;
        end
        else if (state == DISPLAY) begin
            led_writeData   <= {20'b0,
                                ALUControl,
                                ALUOp[1],
                                ALUOp[0],
                                Branch,
                                MemtoReg,
                                ALUSrc,
                                MemWrite,
                                MemRead,
                                RegWrite};
            led_writeEnable <= 1'b1;
        end
        else begin
            led_writeEnable <= 1'b0;
        end
    end
    
    wire [31:0] led_readData;
    wire [15:0] led_out;
    
    leds led_inst (
        .clk        (clk),
        .rst        (rst),
        .writeData  (led_writeData),
        .writeEnable(led_writeEnable),
        .readEnable (1'b0),
        .memAddress (30'b0),
        .readData   (led_readData),
        .leds       (led_out)
    );
    
    assign led = led_out;
endmodule