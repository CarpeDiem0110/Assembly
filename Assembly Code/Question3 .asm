.data
array:
.space 1000        # It allocates 1000 byte space for array  which means that array size shouldn't be exceed the 125 integer elements 

.data
array_message2:
   .asciz "Array elements after the sort are : "
array_message: 
   .asciz "Array elements before the sort are : " 
   space :
   .asciz " "
space2: 
    .asciz "\n"
array_elements: 
     .asciz "Please enter the size of your array "     
     
 
  					
.text
main: 
  la a0, array_elements   # assign message into a0 
  li a7, 4    # print string int code is 4 
  ecall       # call the message

  li a7,5   # read integer code is 5  	
  ecall     # Take the size value from user 
  mv a2, a0  #copy the a0 value into t0. a2 represent size value of array

variableDefinition:
  addi t0, a2,-1 # array size -1 
  li t1, 0 # i value 
  li t2, 0 # j value 



  li a3, 0 # counter value 
  mv s4,a3 # copy counter value 

  la s7,array  # base adresi bulalım 
  mv a1,s7     # ikinci base adres
  mv s5,s7     #üçüncü base adres


  addi sp,sp ,-4  # Allocate a space in stack pointer
  sw s7, 0(sp)     # assign the base address value 


fillTheArrayElements: 
  beq s4, a2 , printMessageBeforeTheSort   		  # If counter is equal to size jump to the arrayMessage procedure 
  li a7,5 			          # Ask the array element value from user 
  ecall  				  # Take a input 
  sw a0, 0(s5)  			  # Put the value into the array
  			 		  
  addi s5,s5,4 	 			 #baseAdress = baseAdress + 4 ; 
  addi s4, s4, 1  	                 # counter = counter++; 
  j, fillTheArrayElements




## Array elements before the sort 
printMessageBeforeTheSort: 
 la a0, array_message
 li a7,4		# message
 ecall
 

## Print array elements before the sort 
printArrayBeforeTheSort :
  beq a3,a2,bubleSortCalculations
  lw a0, 0(a1) 
  li a7,1
  ecall 
  
  la a0,space
  li a7,4
  ecall 
  
  addi a1,a1,4
  addi a3,a3,1
  j printArrayBeforeTheSort


## a1,a2,a3,a4,a5 boş 


bubleSortCalculations:
# arr[j] > arr[j+1] ' e git ve herhangi bir işlem yapma 
innerLoopIf: 
 slli s9,t2,2 				# j nin byte değerini bul 
 add s7,s7,s9 				# arr[j] nin base addresi bulundu 
 lw s10, 0(s7)				# arr[j] nin değeri bulundu 
 lw s11, 4(s7)				# arr[j+1] değeri bulundu 
 
 bge s10,s11,innerLoopElse		# If arr[j] => arr[j+1]
 mv t3,s10				# temp = arr[j]
 sw s11,0(s7)				# arr[j] = arr[j+1]
 sw t3, 4(s7)				# arr[j+1] = temp
 lw s7, 0(sp)				# base addresi yeniden sıfırıncı indekse çevirdim
 addi t2,t2,1				# j yi 1 artır 
 sub t4,t0,t1				# n-i ye göre loop hareket edecek . i de outer loopta sürekli olarak değişiyor 
 beq t2,t4,outerLoop			# j n-i ye eşitse outer loopa geç 
 j innerLoopIf

innerLoopElse:
 addi t2,t2,1				# j değerini 1 artır
 sub t4,t0,t1				# t4 değeri yani nested loopun biteceği yeri belirle ve t4 register içine at
 lw s7,0(sp)				# Make base address starting point of array base address
 beq t2,t4,outerLoop			# j değeri bu değere eşitse dış loop' açık 
 j innerLoopIf				# değilse loop içinde if koşulunu sağlıyormu ona bak

outerLoop: 			# t1 i ye eşit 
  addi t1,t1,1
  beq t1,t0,message2 		# t0  size-1 e eşit 
  li t2,0	# j yi yeni outerLoop' a geçtiğim zaman sıfırlamam lazım . 
  lw s7,0(sp)	# Make base address starting point of array base address
 j innerLoopIf
 





## After the sort print message and print array section

message2: 
 la a0, space2	
 li a7,4
 ecall

 la a0, array_message2
 li a7,4		# message
 ecall
 
 li a3,0	# counter'ın değeri değişmişti sıfırladım
 lw a1, 0(sp)   # a1 base adresi arrayi ilk print ettiğim anda değişmişti onuda sıfırladım 


printArrayAfterTheSort :
  beq a3,a2,end		# If counter is equal to array size jump to the end
  lw a0, 0(a1) 		# call the first element of array
  li a7,1		# Print integer code is 1 
  ecall 		# Print 
  	
  la a0,space		# Put a space between array elements
  li a7,4		# Print string code is 4 
  ecall 		# Print 
  
  addi a1,a1,4		#
  addi a3,a3,1
  j printArrayAfterTheSort
  
end:
