# #include <stdio.h>

# int mult(int a, int b) {
#     if (b == 1) return a;
#     return a + mult(a, b-1);
# }

# int main() {
#     int result;

#     printf("%d\n", mult(110, 50));
#     return 0;
# }

.text
main:
    # pass the first argument to a0
    li a0 110
    li a1 50
    # pass the second argument to a1
    jal mult
    mv a1 a0
    addi a0 zero 1
    ecall
    j exit
    
mult:
    # x0-x4, x10-x17 are prohibited.
    # base case
    # compare a1 with 1 , if the two are equal you exit the mult function
    addi t0 zero 1
    # recursive case
    addi sp sp -12
    sw ra 0(sp) # storing the ra value on to the stack
    sw a1 4(sp) # storing the a0 value on to the stack
    sw a0 8(sp) # storing the a1 value on to the stack
    bne a1 t0 else
    addi sp sp 12
    jr ra # return a
else:
    addi a1 a1 -1 # b = b-1
    jal mult # call mult(a, b-1)
    # after get mult(a, b-1) -> a0 
    lw t1 8(sp) # load a0 to t1
    lw ra 0(sp) # load ra to ra previous
    
    # a + mult(a, b-1);`
    addi sp sp 12 # delete stack
    # save a0 and a1 on to the stack
    # pass the first argument to a0
    # pass the second argument to a1
#     jal mult
    
    # by convention the result is in a0
    # restore a0 and a1 on to the stack
    
    # exit from recursive case
    add a0 a0 t1 # where t1 is the result from mult(a, b-1)
    jr ra
    
# exit_base_case:
#     lw ra 0(sp)
#     addi sp sp 4
#     jr ra
exit:
    addi a0 zero 10
    ecall