.text
.globl main
main:
    li x20, 5        # a = 3
    li x21, 0        # b = 1

    addi x20, x21, 32  # a = b + 32
    add x22, x20, x21   # d = a + b
    addi x22, x22, -5   # d = d - 5
    sub x23, x20, x22   # e = a - d
    sub x24, x21, x20 #temp reg
    add x23, x24, x22
    addi x23, x00, 0 # e = 0
    add x23, x20, x21
    add x23, x22, x23

end:
    j end             # Infinite loop to halt program