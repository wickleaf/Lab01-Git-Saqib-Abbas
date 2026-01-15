.text
.globl main
main:
    li x20, 5        # a = 3
    li x21, 0        # b = 1

    add x5, x20, x21  # x5 = g + h
    add x6, x22, x23  # x6 = i + j
    sub x19, x5, x6   # f = x5 - x6

end:
    j end             # Infinite loop to halt program