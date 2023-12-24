.data
.asciz
   asteriks: "*" 						
   space :  " "
   anotherRow : "\n"  
   message : "Please enter the size of diamond "
.text

_main :

## Kodda operations ve someOperations diye adlandırılan procedurlar loop içerisinde her bir işlem yapılırken 
## değişik değerler aldığı için yazıldı. 

# Kullanıcadan yıldızın değerini almak için bir mesaj gönder
la a0,message
li a7, 4 
ecall

# Kullanıcıdan integer değeri al. Bu değer satır sayısı belirlenirken kullanılacak
li a7,5
ecall



li x3,2   # 2 ile birşey carpılacak ama ne carpılacak bende bılmıyorum
# Buradakiler üst taraftaki loopta kullanılan değişkenler 


li x5 , 1   # j yi belirler
li x6, 1    # i yi belirler 
mv x7,a0    # numberofrowsu belirler
li x9 , 0   # k yı belirler 


# Buradakiler alt taraftaki loopta kullanılan değişkenler 
li x25 , 1   # s yi belirler
li x26, 1    # t yi belirler 
li x27, 1    # l yi belirler



# Bu kısmı verilen row sayısını ikiye bölüp işlem yapmak için kullandım üst taraf için 
li x22, 2 
div x22,x7,x22     
addi x22,x22,1

#Bu kısmı verilen row sayısını ikiye bölerek işlem yapmak için kullandım alt taraf için 
li x23, 2 
div x23,x7,x23     
mv x28,x23   # baseAddress
## Burda iki adet base address var. birisi değişmeyecek birisi değişilerek kullanılabilecek 
mv x4,x28

mul x23,x3,x23
addi x23,x23,-1   #İlk değer için 5 değerini buldum 


jal operations 
# This procedure is going to make a calculations for second nested loop of first loop 
operations: 
li x31, 2 	#  x31 = 2
mul x30, x31, x6 # 2 * i   
addi x30,x30,-1  # 2 * i -1 


# printSpaceAbove , printAsteriksAbove ve printAnotherRowAbove elmasın üst kısmını print eder.

## Our printing operation is divided by two loop 
## First loop has 2 inner loop 
## Second loop has 2 inner loop 
## First loop represents the above part of diamond 
## Second loop represents the below part of diamond 



# first nested loop of first loop 
printSpaceAbove: 
    beq x5,x22, printAsteriksAbove      # If x5 value (j) is equal to x22 value ( (numberofRows/2) +1 )  , jump to the printAsteriksAbove
    la a0, space			# Print space according to value of x22 
    li a7, 4				# Print string code for a7 : 4 
    ecall 				# print 
    addi x5,x5,1 			# Increase 1 the value of x5 
    j printSpaceAbove			# Repeat this procedure
 
# Second nested loop of first loop  
printAsteriksAbove :
    beq x9, x30, printAnotherRowAbove	# If x9 value (k) is equal to x30 value ( (2 * i ) -1) , jump to the printAsteriksAbove
   la a0, asteriks			# Print asteriks according to x30 value 
   li a7, 4				# Print string code for a7 : 4 
   ecall				# print 
   addi x9, x9 ,1			# Increase 1 the value of x9 
   j printAsteriksAbove 		# Repeat this procedure 
   
# First loop 
printAnotherRowAbove: 
   la a0, anotherRow			# Pass the new line 	
   li a7,4				# Print string code for a7 : 4
   ecall				# print 
   beq x6,x22,printSpaceBelow 		# If x6 value (i) is equal to x22 value ( ( numberofRows/2) + 1 ) , jump to the printSpaceBelow 
   addi x6,x6,1				# Increase 1 the value of x5 (i) 
   mv x5,x6				# x5 value ( j ) which is used for first nested loop of first loop is copied from x6 value (i) 
   li x9,0				# I made x9 value ( k ) zero  because  it should start 0 each repeat in second nested loop of first loop 
   jr ra

# First nested loop of second loop 
printSpaceBelow: 
  bgt x26,x25,printAsteriksBelow	# If x26 value (t) is greater than x25 value (s), jump to the printAsteriksBelow 
  la a0,space				# Print space according the value of x25
  li a7,4				# Print string code for a7 : 4 
  ecall					# print 
  addi x26,x26,1			# Increase 1 the value of x26 
  j printSpaceBelow			# Repeat this procedure
 
# Second nested loop of second loop 	 
printAsteriksBelow :
   bgt x27,x23,printAnotherRowBelow	# If x27 value (l) is bigger than x23 value ( ( 2 * i ) - 1 ) , jump to the printAnotherRowBelow
   la a0,asteriks			# Print asteriks according the value of x23 
   li a7,4				# Print string code for a7 : 4
   ecall				# print 
   addi x27,x27,1			# Increase 1 the value of x27 (l) 
   j printAsteriksBelow			# Repeat this procedure
   	
  
# Second loop 
printAnotherRowBelow: 
  la a0,anotherRow			# Pass the new line 
  li a7,4				# Print string code for a7 : 4
  ecall					# primt 
  addi x25,x25,1			# Increase 1 the value of x25 (s) . This value is used for check second outer loop 
  bgt x25,x28,end			# If value of x25 (s) is bigger than  x28 value ( (numberofRows/2) ) , finish all the procedures 
  j someOperations  			# Jump to the someOperations 
   
  # Change all variables of loops 	
someOperations : 
  addi x4,x4,-1				# Decrease 1 the value of x4 ( (numberofRows/2) ) 		
  mv x23, x4				# Copy this value into x23 ( (numberofRows/2) ) 
  li x27,1 				# Make the value of x27 (l) is 1 
  li x26,1				# Make the value of x26 (s) is 1 
  mul x23,x31,x23			# Find the value of 2 * ((numberofRows/2)) 
  addi x23,x23,-1			# Find the value of  2 * ((numberofRows/2)) - 1. This value is going to use in second nested loop of second loop 
  j printSpaceBelow			# Jump to the printSpaceBelow

end:					# Finish all operations 



		## HOW TO CODE IN JAVA 
		
#public class printDiamond {
 
#	
#	 
#
#	 public static void printDiamond(int numberofRows ) {
#
#		 
#	 // First loop specifies the rows another for loops specifies how column looks 
#		 for(int i= 1 ; i<= (numberofRows/2)+1; i++) {
#			 
#			// Print space for pyramid  upper part 
# 			 for(int j = i ; j<(numberofRows/2)+1; j++) {
#				 System.out.print(" ");
#			 }
#			 // Print asteriks for pyramid  upper part 
#			 for(int k = 0; k< (2*i)-1;k++) {
#				 System.out.print("*");
#			 }
#			 
#			 System.out.println();
#			 
#		 }
#		
#		
#		 // Buradan sonra yazılanlar elmasın alt tarafında kalan kısım için yazıldı. 
#		 
#		 int baseAddress = numberofRows/2; // Bunu elmasın alt kalan yıldızları bastırmak için kullanacağım 
#		 
#		 for(int s = 1 ; s<=(numberofRows/2); s++) {
#			
#			 // Print space for pyramid below part 
#			 for(int t = 1;t <= s;t++) { 
#				 System.out.print(" ");
#			 }
#			 
#			 // Print asteriks for pyramid below part 
#			 for(int l = 1; l<= (2*(baseAddress)-1); l++) {
#				 System.out.print("*");
#			 }
#			baseAddress--;
#		
#		System.out.println();
#		 }
#	
#		 
#	 }
#
#
#	
#	
#	
#	public static void main(String[] args) {
#		// TODO Auto-generated method stub
#		printDiamond(7);
#		
#		
#	}










