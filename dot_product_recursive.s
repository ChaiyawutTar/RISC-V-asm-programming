# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int dot_product_recursive(int *a, int *b, int size) {
#     if (size == 1) return a[0]*b[0];
#     return a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
# }

# int main() {
#     int result;

#     result = dot_product_recursive(a, b, 5);
#     printf("The dot product is: %d\n", result);
#     return 0;
# }

.data
    a: .word 1,2,3,4,5
    b: .word 6,7,8,9,10
    newline: .string "\n"
.text
main:
# x0-x4, x10-x17 are prohibited.
    la a0 a # load address of a into a0 (*a)
    la a1 b # load address of b into a1 (*b)
    addi a2 zero 5 # add size if array into a2 (int size)
    # call function
    jal dot_product_recursive
    j exit
dot_product_recursive:
    addi sp sp -16
    sw a0 0(sp) # save a0 (a) to stack
    sw a1 4(sp) # save a1 (b) to stack
    sw a2 8(sp) # save a2 (size) to stack
    sw ra 12(sp) # save ra to stack
    # base case
    addi t0 zero 1  # (t0 = 1)
    bne a2 t0 else
    # under base case
    addi sp sp 16
    lw t1 0(a0) # t1 = a[0]
    lw t2 0(a1) # t2 = b[0]
    mul a0 t1 t2 # a0 = t1 * t2
    jr ra
    
else:
    # return a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    #dot_product_recursive(a+1, b+1, size-1)
    addi a0 a0 4 # *a = *a + 1
    addi a1 a1 4 # *b = *b + 1
    addi a2 a2 -1 # size = size - 1
    jal dot_product_recursive # recursively
    lw t1 0(sp) # load t1 = a
    lw t2 4(sp) # load t2 = b
    lw t3 8(sp) # load t3 = size
    lw ra 12(sp) # load ra
    addi sp sp 16 # delete stack pointer
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    lw t4 0(t1) # t4 = a[0]
    lw t5 0(t2) # t5 = b[0]
    mul t6 t4 t5 # t6 = t4 * t5
    add a0 a0 t6  # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    jr ra # return
exit:
#     mv t0 a0
    
#     addi a0 zero 4
    mv a1 a0
    addi a0 zero 1
    ecall
