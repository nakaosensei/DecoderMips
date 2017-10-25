jal 100002
j 10006C
addi $sp, $sp, 65508
jal 10004D
add $t0, $zero, $zero
add $t1, $zero, $zero
add $t2, $zero, $zero
addi $sp, $sp, 65516
sw $t0, $sp, 0
addi $sp, $sp, 20
addi $sp, $sp, 65512
sw $t1, $sp, 0
addi $sp, $sp, 24
addi $sp, $sp, 65508
sw $t2, $sp, 0
addi $sp, $sp, 28
addi $t8, $zero, 4
addi $t9, $zero, 28
addi $t7, $zero, 7
addi $sp, $sp, 65516
lw $t0, $sp, 0
addi $sp, $sp, 20
slt $t5, $t7, $t0
addi $at, $zero, 0
beq $t5, $at, 1
j 10006C
addi $sp, $sp, 65512
lw $t1, $sp, 0
addi $sp, $sp, 24
addi $t1, $t0, 1
addi $sp, $sp, 65512
sw $t1, $sp, 0
addi $sp, $sp, 24
addi $sp, $sp, 65512
lw $t1, $sp, 0
addi $sp, $sp, 24
slt $t6, $t7, $t1
addi $at, $zero, 0
beq $t6, $at, 1
j 10005F
mult $t0, $t8
mflo $t3
mult $t1, $t8
mflo $t4
sub $t3, $t9, $t3
sub $t4, $t9, $t4
add $sp, $sp, $t3
lw $s1, $sp, 0
sub $sp, $sp, $t3
add $sp, $sp, $t4
lw $s2, $sp, 0
sub $sp, $sp, $t4
slt $s3, $s1, $s2
addi $at, $zero, 0
beq $s3, $at, 8
addi $sp, $sp, 65512
lw $t1, $sp, 0
addi $sp, $sp, 24
addi $t1, $t1, 1
addi $sp, $sp, 65512
sw $t1, $sp, 0
addi $sp, $sp, 24
j 100021
addi $sp, $sp, 65508
lw $t2, $sp, 0
addi $sp, $sp, 28
add $t2, $zero, $s2
addi $sp, $sp, 65508
sw $t2, $sp, 0
addi $sp, $sp, 28
add $sp, $sp, $t4
sw $s1, $sp, 0
sub $sp, $sp, $t4
add $sp, $sp, $t3
sw $s2, $sp, 0
sub $sp, $sp, $t3
j 100021
addi $t1, $zero, 9
sw $t1, $sp, 28
addi $t1, $zero, 4
sw $t1, $sp, 24
addi $t1, $zero, 6
sw $t1, $sp, 20
addi $t1, $zero, 5
sw $t1, $sp, 16
addi $t1, $zero, 8
sw $t1, $sp, 12
addi $t1, $zero, 7
sw $t1, $sp, 8
addi $t1, $zero, 3
sw $t1, $sp, 4
addi $t1, $zero, 1
sw $t1, $sp, 0
addu $t1, $zero, $zero
jr $ra
add $sp, $sp, $t3
lw $s1, $sp, 0
sub $sp, $sp, $t3
add $a0, $zero, $s1
addiu $v0, $zero, 4
Deu ruim, nao implementei essa instrucao. 
ori $a0, $at, 0
addi $t0, $t0, 1
addi $sp, $sp, 65516
sw $t0, $sp, 0
addi $sp, $sp, 20

