.text
.globl _start
_start:
li sp, 0x1F0 # init stack pointer
addi s1, zero, 512 # s1 = LED address
addi s2, zero, 768 # s2 = switch address
addi s3, zero, 772 # s3 = reset button address
INPUT_WAITING:
sw zero, 0(s1) # clear LEDs
POLL_SWITCHES:
lw a0, 0(s2) # read switches
beq a0, zero, POLL_SWITCHES # wait until non-zero
jal ra, COUNTDOWN_SUB # a0 = captured switch value
j INPUT_WAITING
# arg: a0 = initial count value
# stack frame: sp+4 = ra, sp+0 = s0
COUNTDOWN_SUB:
addi sp, sp, -8
sw ra, 4(sp)
sw s0, 0(sp)
mv s0, a0 # s0 = counter
COUNTDOWN_LOOP:
beq s0, zero, COUNTDOWN_DONE
lw t0, 0(s3) # check reset
bne t0, zero, RESET_DETECTED
sw s0, 0(s1) # update LEDs
jal ra, DELAY
addi s0, s0, -1
j COUNTDOWN_LOOP
RESET_DETECTED:
sw zero, 0(s1) # clear LEDs
j COUNTDOWN_DONE
COUNTDOWN_DONE:
sw zero, 0(s1) # clear LEDs
lw ra, 4(sp) # restore frame
lw s0, 0(sp)
addi sp, sp, 8
ret
# busy-wait: 1000 x 500 x ~2 cycles = ~100ms at 10MHz
# leaf function — does not touch stack
DELAY:
addi t1, zero, 1000
DELAY_OUTER:
addi t2, zero, 500
DELAY_INNER:
addi t2, t2, -1
bne t2, zero, DELAY_INNER
addi t1, t1, -1
bne t1, zero, DELAY_OUTER
ret