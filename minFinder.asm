# Purpose: To construct an array of integers from user input and print the minimum integer

         .data
new_num_str:  .asciiz "Enter num: "
min_item_str: .asciiz "The minimum element in this list is "
new_line:     .asciiz "\n"
length_str:   .asciiz "Array length: "
iterator:     .word   0
min_item:     .word   0
size:         .word   0
the_list:     .word   0

        .text
        # Print request for array length
        la   $a0, length_str
        addi $v0, $zero, 4
        syscall
        
        # Get input for array length
        addi $v0, $zero, 5
        syscall
        sw   $v0, size
        
        # Allocate space for array in heap
        addi $v0, $zero, 9
        lw   $t0, size
        addi $t1, $zero, 4
        mult $t0, $t1
        mflo $a0
        addi $a0, $a0, 4
        syscall
        sw   $v0, the_list
        
        # Put length in the first cell of the array
        lw   $t0, the_list
        lw   $t1, size
        sw   $t1, ($t0)
        
loop:   # for i in range(len(the_list))
             # if i < len(the_list)
             lw   $t0, iterator
             lw   $t1, size
             slt  $t0, $t0, $t1
             beq  $t0, $zero, end_loop
             
             # Ask for number
             la   $a0, new_num_str
             addi $v0, $zero, 4
             syscall
             
             # Add new number to array
                 # Get input for new number
                 addi $v0, $zero, 5
                 syscall
                 addi $t0, $v0, 0
                 # Put into array
                 lw   $t1, iterator
                 addi $t2, $zero, 4
                 mult $t1, $t2
                 mflo $t1
                 lw   $t2, the_list
                 add  $t1, $t1, $t2
                 sw   $t0, 4($t1)
             
             # If i == 0 or ...
             lw   $t0, iterator
             beq  $t0, $zero, then
             
             # ... min_item > the_list[i]
                 # Retreive last item from the_list
                 lw   $t0, iterator
                 addi $t1, $zero, 4
                 mult $t0, $t1
                 mflo $t0
                 lw   $t1, the_list
                 add  $t0, $t0, $t1
                 lw   $t0, 4($t0)
             lw   $t1, min_item
             slt  $t0, $t0, $t1
             beq  $t0, $zero, increment
             
then:        # min_item = the_list[i]
                 # Retreive last item from the_list
                 lw   $t0, iterator
                 addi $t1, $zero, 4
                 mult $t0, $t1
                 mflo $t0
                 lw   $t1, the_list
                 add  $t0, $t0, $t1
                 lw   $t0, 4($t0)
             sw   $t0, min_item
             
increment:   # Increment iterator
             lw   $t0, iterator
             addi $t0, $t0, 1
             sw   $t0, iterator
             
             # Repeat loop
             j    loop

end_loop:
        # Print minimum element string 
        la   $a0, min_item_str
        addi $v0, $zero, 4
        syscall

        # Print minimum number
        addi $v0, $zero, 1
        lw   $a0, min_item
        syscall

        # Print new line
        la   $a0, new_line
        addi $v0, $zero, 4
        syscall
        
        # Exit
        addi $v0, $zero, 10
        syscall
