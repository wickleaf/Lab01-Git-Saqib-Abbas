.text
.globl main
main:
    #Part a
    li x10, 0x78786464        # a = 3
    li x11, 0xA8A81919        # b = 1
    li x9, 0x100
    sw x10, 0(x9)
    li x8, 0x1F0
    sw x11, 0(x8)
    lhu x12, 0(x9)
    lh x13, 0(x8)
    lh x14, 0(x8)

end:
    j end             # Infinite loop to halt program