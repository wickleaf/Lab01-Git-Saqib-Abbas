module fullAdder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    // Continuous assignment for sum and carry-out logic
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule