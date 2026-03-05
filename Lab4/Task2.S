.globl main

.text
main:
    li x10, 5
    jal x01, ntri
    
    addi x11,x10,0
    li x10,1
    ecall


    j end

ntri:
    addi x02, x02, -8
    sw x01, 4(x02)
    sw x10, 0(x02)

    li x05, 1
    ble x10, x05, base_case

    addi x10, x10, -1
    jal x01, ntri

    lw x06, 0(x02)
    add x10, x10, x06
    
    j exit_ntri

base_case:
    li x10, 1

exit_ntri:
    lw x01, 4(x02)
    addi x02, x02, 8
    ret

end:
    j end