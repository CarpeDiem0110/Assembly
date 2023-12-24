.eqv constant , x31
.eqv constant2, x30
.data
.asciz
 inputMessage: " Please enter your input  "

.text
main: 
# These are my constants . constant is used for 3 * f(x)  , constant2 is used for control given input is bigger than 1 or not 
li constant, 3
li constant2, 1 

# Send a message to user in order to take input
la a0, inputMessage
li a7, 4
ecall

# Senden hesaplanacak faktoriyelin integer değerini alır 
li a7, 5
ecall

# Call function and pc =  address of jal + 4 => points to the line 23
jal ra, function
j print



function: 
 ble a0,constant2,else  #  if input < 1 , jump to the else label 
 addi sp,sp,-8          # Allocate 8 byte space from stack
 sw ra, 4(sp)           #  Assign the adress value into the stack
 sw a0, 0(sp)  		# Assign the input value into the stack
 addi a0, a0, -1        # Decrease the value of input => n = n-1
 jal ra, function       # call the function
 lw a1, 0(sp)           # Assign the value of stack into a1 register
 addi sp, sp, 4		# Increase stack pointer value in order to change the pointer place in the stack. Because we need to use all variables in the stack
 mul a0, constant, a0   # a0 = a0 *3 
 add a0,a0,a1		# f(x) = f(x-1) + x => a0 = a0 + a1 
 lw ra, 0(sp) 		#  Modify address of ra 
 addi sp, sp, 4 	# Increase stack pointer value 
 jr ra 			# jump to the ra ( ra represents x1 register ) 

else:
 li a0, 3		# If a0 were a 1 , value of a0 will be 3 
 jr ra 			# jump to the ra 


# print the function value 
print:			
  li a7,1
  ecall