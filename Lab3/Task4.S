.globl
.text

main:
    addi sp, sp, -8
    sw x19, 0(sp)
    li x11, 0x100
    li x10, 0x200
    li x5, 'A'
    sb x5, 0(x11)
    li x5, 'P'
    sb x5, 1(x11)
    li x5, 'P'
    sb x5, 2(x11)
    li x5, 'L'
    sb x5, 3(x11)
    li x5, 'E'
    sb x5, 4(x11)
    li x5, 0
    sb x5, 5(x11)
    li x19, 0
    jal x1, strcopy
    lw x19, 0(sp)
    addi sp, sp, 8
    jalr x0, 0(x1)
    j exit
    strcopy:
        add x5, x11, x19
        add x6, x10, x19
        lb x7, 0(x5)
        sb x7, 0(x6)
        addi x19, x19, 1
        beq x7, x0, exit
        j strcopy
  exit:
end:
    j end