# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }
.data
    A: .word 1,2,3,4,5
    B: .word 6,7,8,9,10
    newline: .asciiz "\n"
.text
main:
# x0-x4, x10-x17 are prohibited.
    li x5 0 # set x5 = i = 0
    li x6 0 # set x6 = sop = 0
    li x19 5 # set x19 = 5 (limit of for loop)
    la x9 A # load address A to x9
    la x18 B # load address B to x18
    j loop
loop:
    bge x5 x19 exit
    slli x7 x5 2 # set x7 to offset
    add x20 x7 x9 # add offset of A
    add x21 x7 x18 # add offset of B
    lw x22 0(x20) # x22 = A[i]
    lw x23 0(x21) # x23 = B[i]
    mul x24 x23 x22 # x24 = x22 * x23 -> x24 = A[i] * B[i]
    add x6 x24 x6 # x6 = x24 + x6 => x6 +=  A[i] * B[i]
    addi x5 x5 1 # x5 (i) = x5 (i) + 1
    li x4 0
    j loop
    
exit:
# print sop
    add a1 x6 zero
    li a0 1
    ecall 