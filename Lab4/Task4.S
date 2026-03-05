.globl

main:
    li x10, 7
    jal x01, fib

    addi x11,x10,0
    li x10,1
    ecall

    j end
fib:
    addi x02, x02, -12
    sw x01, 8(x02)
    sw x10, 0(x02)

    li x5, 1
    ble x10, x5, base_case

    lw x10, 0(x02)    #fib(n-1)
    addi x10, x10, -1
    jal x01, fib
    sw x10, 4(x02)

    lw x10, 0(x02)    #fib(n-2)
    addi x10, x10, -2
    jal x01, fib
    
    lw x06, 4(x02)    #fib(n-1) + fib(n-2)
    add x10, x10, x06

    lw x01, 8(x02)
    addi x02, x02, 12
    ret

base_case:          #base case n <= 1
    lw x01, 8(x02)
    addi x02, x02, 12
    ret

end:
    j end