.data
arr1: .word 0,0,0,0,0,0,0,0,0,0
arr2: .word 0,0,0,0,0,0,0,0,0,0
newline: .asciiz "\n"

.text
main:
    # x0-x4, x10-x17 are prohibited.
    li x5 10 #size=1
    li x6 0 #sum1=0
    li x7 0 #sum2=0


    #first for loop
    li x8 0 #i=0
    la x9 arr1 # load base address of arr1
    j loop1

loop1:
    bge x8 x5 reset_i_for_loop1   
    slli x18 x8 2 # set x18 to i*4
    add x19 x18 x9 # add offset to x19
    addi x20 x8 1 # x20 = i + 1
    sw x20 0(x19)
    addi x8 x8 1
    j loop1
    

reset_i_for_loop1: 
    li x8 0 # reset i
    li x18 0 #reset x18 to 0
    li x19 0 #reset offset variable
    li x20 0 #reset x20
    la x21 arr2 #load base address of arr2
    j loop2

loop2:
    bge x8 x5 reset_i_for_loop2
    slli x18 x8 2 # set x18 to i*4
    add x19 x21 x18 # add offset to x19
    add x20 x8 x8 #x20 = 2*i
    sw x20 0(x19)
    addi x8 x8 1
    j loop2
    
reset_i_for_loop2:
    li x8 0 # reset i
    li x18 0 #reset x18 to 0
    li x19 0 #reset offset to 0
    li x20 0 #reset x20
   # li x22 0 #sum1 = 0
   # li x23 0 #sum2 = 0
    li x24 0
    li x25 0
    li x26 0
    j loop3
    
loop3:
    bge x8 x5 exit
    slli x18 x8 2 # set x18 to i*4
    add x24 x9 x18 #add offset arr1 to x24
    add x19 x21 x18 # add offset arr2 to x19
    lw x25 0(x24) # x25 = arr1[i]
    lw x26 0(x19) # x26 = arr2[i]
    add x6 x6 x25 # sum1 = sum1 + arr1[i]
    add x7 x7 x26 # sum2 = sum2 + arr2[i]
    addi x8 x8 1
    j loop3
      
exit:
    #print sum1
    add a1 zero x6
    li a0 1
    ecall 
    #print new blank line
    la a1 newline
    addi a0 x0 4
    ecall
    #print sum2
    add a1 zero x7
    li a0 1 
    ecall
    
    


    
    
