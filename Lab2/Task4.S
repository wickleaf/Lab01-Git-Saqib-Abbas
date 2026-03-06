.text
.globl main
main:
        addi x5, x0, 5
        addi x6, x0, 5
        addi x7, x0, 0
        addi x29, x0, 0
        addi x10, x0, 0x200
    OuterLoop:
        bge x7, x5, ExitOuter
        addi x29, x0, 0
    InnerLoop:
        bge x29, x6, ExitInner
        add x28, x7, x29
        slli x30, x29, 4
        add x30, x30, x10
        sw x28, 0(x30)
        addi x29, x29, 1
        jal x0, InnerLoop
    ExitInner:
        addi x7, x7, 1
        jal x0, OuterLoop
    ExitOuter:
end:
    j end             # Infinite loop to halt program