.globl main

main:
    li x11, 2
    jal ra, swap
    li x12, 8
    

    swap:
    mul x13, x11, x12

    add x10, x10, x13


end:
    j end             # Infinite loop to halt program