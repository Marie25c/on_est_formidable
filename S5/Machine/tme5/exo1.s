.data

.align 2
p : .space 4

.align 2
q : .space 4

.text

	lui $8, 0x1001
	lw $9, 0($8) # p
	lw $10, 4($8) # q
	
	ori $2, $0, 5 # init p
	syscall
	
	ori $9, $2, 0 # $9 <- p
	
	ori $2, $0, 5 # init p
	syscall
	
	ori $10, $2, 0 # $10 <- q

	ori $4, $0, 0 # somme = 0
	
	slt $12, $10, $9
	bne $12, $0, jump
	
loop : 	addu $4, $4, $9	 #res = res + 1
	addiu $9, $9, 1 #p = p + 1
	slt $12, $9, $10 # 0 | 1 <- $9 < $10
	bne $12, $0, loop # 0 -> loop
	j jump
	
jump :	ori $2, $0, 1 # print
	syscall 
	
	ori $2, $0, 10 # exit
	syscall