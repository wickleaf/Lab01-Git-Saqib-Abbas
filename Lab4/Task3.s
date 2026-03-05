.globl main

.globl main

main:

li x11, 0x200
li x1, 34
sw x1, 0(x11)
li x2, 15
sw x2, 4(x11)
li x3, 1
sw x3, 8(x11)
li x4, 32
sw x4, 12(x11)
li x5, 43
sw x5, 16(x11)
li x6, 100
sw x6, 20(x11)
li x7, 64
sw x7, 24(x11)
li x8, 67
sw x8, 28(x11)
li x9, 21
sw x9, 32(x11)
li x18, 57
sw x18, 36(x11)
li x19, 0 # swapped
li x17, 10 #size

li x20, 0 #i
addi x16, x17, -1 #size-1
OuterLoop:
    bge x20, x17, ExitOuter
    addi x21, x0, 0 #j = 0
    sub x22, x16, x20 #size-i-1

InnerLoop:
    bge x21, x22, ExitInner
    slli x5, x21, 2

    add x5, x5, x11  
    lw x8, 0(x5) # load i element
    lw x9, 4(x5) # load i+1 element

    bgt x8, x9, swap
    j noSwap

    swap:
        sw x9, 0(x5)
        sw x8, 4(x5)

    noSwap:
        addi x21, x21, 1 #j++
        j InnerLoop

ExitInner:
    addi x20, x20, 1 #i++
    j OuterLoop
ExitOuter:

end:
    j end