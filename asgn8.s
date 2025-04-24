.data               # start of data section
# put any global or static variables here
prompt:     .string "Enter n (0-40): "
input_fmt:  .string "%ld"
output_fmt: .string "%ld "
newline:    .string "\n"
n:          .quad 0


.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!


.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===
generate_fib:
      # fibonacci func
    pushq %rbp  # Savings the base pointer
    movq %rsp, %rbp # Setting a new base poiner
    
    # Used registers saved

    pushq %r12 # using for counter
    pushq %r13  # using for the first value
    pushq %r14  #  for the second value
    pushq %r15 # for the next value
    
     # Initializing the vars
    movq %rdi, %r12             
    movq $0, %r13               
    movq $1, %r14   

    
     # Checking for the n = 0 
    cmpq $0, %r12
    je end_fib

    
   # Printing first num
    movq $output_fmt, %rdi # Formatting
    movq %r13, %rsi    # value that prints
    movq $0, %rax               
    call printf   # Printing
    
     # Decrementing
    decq %r12
    
     # checking to move on
    cmpq $0, %r12
    je end_fib                   
    
     # Generating loop and printing the rest of the num
fib_loop:
     # Calculating the next fib
    movq %r13, %r15   # Saving the current value
    movq %r14, %r13   # Moving the 2nd to the 1st
    addq %r15, %r14    # Calculating the new value
    
    # Printing num
    movq $output_fmt, %rdi  # Formatting
    movq %r13, %rsi  # Num to print

    movq $0, %rax   #  No reg used
    call printf      # Printting

    
     # Decrementing
    decq %r12   # Decrement
    cmpq $0, %r12  # Checking if its zero
    jne fib_loop  # If not continue


~`
main: #main func
      #preamble
    pushq %rbp   #Saving old pointer
    movq %rsp, %rbp #Setting a new one



    # === main() code here ===


     #   Displaying prompt
    movq $prompt, %rdi  #prompt string
    movq $0, %rax    # No reg used
    call printf     # Print prompt
    
     # Getting the input
    movq $input_fmt, %rdi # formatting string
    movq $n, %rsi # addressing to save

    movq $0, %rax     # No reg used
    call scanf   # reading inp
    
    #  Verifying input range 
    movq n, %rax   # Loading 
    cmpq $0, %rax    # Compare

    jl invalid_input   # If its less than zero skip 
    cmpq $40, %rax      #  Compare
    jg invalid_input    #  If bigger than 40 skip
    
    movq n, %rdi     # Pass n
    call generate_fib   # Generating

    jmp end_main   #  Jump to end
    
invalid_input: # if invalid skip
    

end_main:
    
    movq $0, %rax                
    leave                        
    ret                          