.text

main:
	addiu $t0,$0,100 #max/high
	addiu $t1,$0,48	#target
	addiu $t2,$0,1	#initial/low
	addiu $t3,$0,0 	#total_times
	addiu $t4,$0,0	#broke_times
	addiu $t5,$0,0 	#bool_broken
loop:	
	beq $t0,$t2,stop
	addiu	$t3,$t3,1
	addu $t6,$t0,$t2
	srl $t6,$t6,1
	slt $t7,$t6,$t1
	beq $t7,$0,gt
	j lt
	
gt:
	beq $t6,$t2,stop
	addi $t6,$t6,-1
	addu $t0,$0,$t6
	addiu $t5,$0,1
	addiu $t4,$t4,1
	j loop
	
lt:	
	beq $t6,$t0,stop
	addiu $t6,$t6,1
	addu $t2,$0,$t6
	addiu $t5,$0,0
	j loop
stop:	 

