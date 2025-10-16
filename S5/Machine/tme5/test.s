.data

.align 2
a : .space 4

.align 2
b : .space 4

.text

	lui $8, 0x1001
	lw $9, 0($8) # a
	lw $10, 4($8) # b
	
	ori $2, $0, 5 # init a
	syscall
	ori $9, $2, 0 # $9 <- a
	
	ori $2, $0, 5 # init b
	syscall
	ori $10, $2, 0 # $10 <- b
	
	beq $9,$10,fin
	
loop :  
	sltu $12, $10, $9
	bne $12, $0, if
	j else

	
if : 	
	subu $9, $9, $10
	j fin	

else :	
	subu $10, $10, $9
	j fin
	
fin :		
	ori $4, $10, 0
	ori $2, $0, 1 # print
	syscall 