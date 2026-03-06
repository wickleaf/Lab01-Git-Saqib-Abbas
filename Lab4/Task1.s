.globl main

main:
    addi x19, x19, 1
    addi x20, x20, 5
    loop:
        mul x19, x19, x20
        addi x20, x20, -1 
        bne x20, x0, loop
end:
    j end