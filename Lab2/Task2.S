.text
.globl main
main:
    #Part a
    li x20, 4       # x = 1
    li x22, 4       # b = 3
    li x23, 4       # c = 4

    Switch:
        li x9, 1
        beq x20, x9, case1
        li x9, 2
        beq x20, x9, case2
        li x9, 3
        beq x20, x9, case3
        li x9, 4
        beq x20, x9, case4
        j default

    case1:
        add x21, x22, x23 # a = b+c
        beq x0, x0, Exit
    case2:
        sub x21, x22, x23 # a = b-c
        beq x0, x0, Exit
    case3:
        li x9, 2 #temporarily store 2
        mul x21, x22, x9 # a = b*2
        beq x0, x0, Exit
    case4:
        li x9, 2 #temporarily store 2
        div x21, x22, x9 # a = b/2
        beq x0, x0, Exit
    default:
        li x21, 0

    Exit:
    
    
end:
    j end             # Infinite loop to halt program