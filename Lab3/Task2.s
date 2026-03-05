.globl main

main:
    li x10, 5
    li x11, 12
    li x12, 20
    li x13, 3

    jal ra, leaf_example


    leaf_example:
        addi sp,sp -12
        sw x18, 0(sp)      # Save x18
        sw x19, 4(sp)      # Save x19
        sw x20, 8(sp)      # Save x20
        


end:
    j end             # Infinite loop to halt program