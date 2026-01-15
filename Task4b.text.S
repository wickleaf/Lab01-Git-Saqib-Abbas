.text
.globl main
main:
    #Part b
    li x10, 0x100      #A (Char array)
    li x11, 0x200      #B (short array)
    li x12, 0x300      #C unsigned int array

    #Char Array Init
    li x9, 0x61
    sb x9, 0(x10)
    li x9, 0x62
    sb x9, 1(x10)
    li x9, 0x63
    sb x9, 2(x10)
    li x9, 0x64
    sb x9, 3(x10)

    #Short array init
    li x9, 1
    sh x9, 0(x11)
    li x9, 2
    sh x9, 2(x11)
    li x9, 3
    sh x9, 4(x11)
    li x9, 4
    sh x9, 6(x11)

    #Iteration 1
    lb x13, 0(x10)
    lh x14, 0(x11)
    add x15, x13, x14
    sw x15, 0(x12)

    #Iteration 2
    lb x13, 1(x10)
    lh x14, 2(x11)
    add x15, x13, x14
    sw x15, 4(x12)

    #Iteration 3
    lb x13, 2(x10)
    lh x14, 4(x11)
    add x15, x13, x14
    sw x15, 8(x12)

    #Iteration 4
    lb x13, 3(x10)
    lh x14, 6(x11)
    add x15, x13, x14
    sw x15, 12(x12)




end:
    j end             # Infinite loop to halt program