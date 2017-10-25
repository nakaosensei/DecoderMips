# Iniciado em: 10/04/2017 as 14:44
# @author:nakao email:nakaosensei@gmail.com

#void initVariables(int *vet){
#	*(vet)=9;
#	*(vet+1)=4;
#	*(vet+2)=6;
#	*(vet+3)=5;
#	*(vet+4)=8;
#	*(vet+5)=7;
#	*(vet+6)=3;
#	*(vet+7)=1;
#	return;
#};

#void troca(int *vet,int i,int j){
#	int tmp = vet[i];
#	vet[i] = vet[j];
#	vet[j] = tmp
#};

#int main(){		   
#	int *vet = calloc(8,sizeof(int));
#	initVariables(vet);
#	int i = 0;
#	int j = 0;
#	int tmp = 0;	
#	for(i=0;i<8;i++){
#		for(j=i+1;j<8;j++){
#			if(vet[i]>=vet[j]){
#				tmp=vet[j];
#				vet[j]=vet[i];
#				vet[i]=tmp;	
#			}			
#		}
#		printf("%d ",vet[i]);
#	}		
#	return 0;
#}	
	.globl main	
	.data				# seção de dados.
	str_out: .asciiz ""
	.text	
jal main
j exit

main:
	addi $sp, $sp, -28 #Separa 8 posicoes na pilha para trabalhar
	jal initVariables 
	add $t0, $zero, $zero # i = 0, pos na pilha = -48(-20 a partir do topo)
	add $t1, $zero, $zero # j = 0, pos na pilha = -52(-24 a partir do topo)
	add $t2, $zero, $zero # tmp = 0, pos na pilha = -56(-28 a partir do topo)
	
	#Vamos escrever o i, $t0
	addi $sp, $sp, -20 #Move o cursor para posicao -28 - 20, que é -48
	sw $t0, 0($sp) #Armazena i
	addi $sp, $sp, 20 #Retorna para a posicao -28		
	#PRONTO
				
	#Vamos escrever o j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24,, que é -52
	sw $t1, 0($sp) #Armazena j
	addi $sp, $sp, 24 #Retorna para a posicao -28						
	#PRONTO
																			
	#Vamos escrever o tmp, $t2
	addi $sp, $sp, -28 #Move o cursor para posicao -28 - 28,, que é -56
	sw $t2, 0($sp) #Armazena tmp
	addi $sp, $sp, 28 #Retorna para a posicao -28
	#PRONTO
																															
	addi $t8, $zero, 4    #Constante com 4
	addi $t9, $zero, 28
	
	#Primeiro laço de repetição
	addi $t7, $zero, 7 #Atribui 8 a um registrador, esse sera usada na igualdade do if do for (i<8) ou j<8
for1:	
	#Vamos ler i, $t0
	addi $sp, $sp, -20 #Move o cursor para posicao -28 - 20, que é -48
	lw $t0, 0($sp) #lê i e passa pra t0
	addi $sp, $sp, 20 #Retorna para a posicao -28
	#PRONTO, I CARREGADO, ABAIXO A COMPARACAO DO FOR
	
	#COMPARACAO DO FOR
	slt $t5, $t7, $t0 # 7>=i?
	beq $t5, 0, forExec1
	j exit
forExec1:
	#Vamos ler  j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24,, que é -52
	lw $t1, 0($sp) #lê j e passa pra t1
	addi $sp, $sp, 24 #Retorna para a posicao -28	
	#PRONTO
	
	addi $t1, $t0, 1#j = i+1
	
	#Vamos escrever o j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24, que é -52
	sw $t1, 0($sp) #Armazena j
	addi $sp, $sp, 24 #Retorna para a posicao -28
	#PRONTO
for2:	
	#Vamos ler  j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24,, que é -52
	lw $t1, 0($sp) #lê j e passa pra t1
	addi $sp, $sp, 24 #Retorna para a posicao -28
	#PRONTO, agora a comparacao do segundo for
	slt $t6, $t7, $t1 #7>=j?	
	beq $t6, 0, forExec2																			
	j printValue						
																			
forExec2:
	mult $t0, $t8 
	mflo $t3 #t3 = 4*i
	mult $t1, $t8 
	mflo $t4 #t4 = 4*j
	sub $t3, $t9, $t3 # t3 = 28 - 4*i, isso implica na posicao i na pilha
	sub $t4, $t9, $t4 # t4 = 28 - 4*j, isso implica na posicao j na pilha
	add $sp, $sp, $t3
	lw $s1, 0($sp) #Armazena em $s1 v[i]
	sub $sp, $sp, $t3
	add $sp, $sp, $t4
	lw $s2, 0($sp) #Armazena em $s2 v[j]
	sub $sp, $sp, $t4
	slt $s3, $s1, $s2 #Se v[i]>=v[j], s3 := 0
	beq $s3, 0, troca
		
	#Vamos ler  j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24,, que é -52
	lw $t1, 0($sp) #lê j e passa pra t1
	addi $sp, $sp, 24 #Retorna para a posicao -28
	
	addi $t1, $t1, 1#j++
	
	#Vamos escrever o j, $t1
	addi $sp, $sp, -24 #Move o cursor para posicao -28 - 24,, que é -52
	sw $t1, 0($sp) #Armazena j
	addi $sp, $sp, 24 #Retorna para a posicao -28						
	#PRONTO	
	j for2
troca:
	#Vamos escrever o tmp, $t2
	addi $sp, $sp, -28 #Move o cursor para posicao -28 - 28,, que é -56
	lw $t2, 0($sp) #Armazena tmp
	addi $sp, $sp, 28 #Retorna para a posicao -28
	#PRONTO
	
	
	
	add $t2, $zero, $s2 #tmp = v[j]
	
	#Vamos escrever o tmp, $t2
	addi $sp, $sp, -28 #Move o cursor para posicao -28 - 28,, que é -56
	sw $t2, 0($sp) #Armazena tmp
	addi $sp, $sp, 28 #Retorna para a posicao -28
	#PRONTO
	
	add $sp, $sp, $t4
	sw $s1, 0($sp)
	sub $sp, $sp, $t4	
	add $sp, $sp, $t3
	sw $s2, 0($sp) 
	sub $sp, $sp, $t3	
	j for2
	
initVariables:
	addi $t1, $zero, 9
	sw $t1, 28($sp)
	addi $t1, $zero, 4
	sw $t1, 24($sp)
	addi $t1, $zero, 6
	sw $t1, 20($sp)
	addi $t1, $zero, 5
	sw $t1, 16($sp)
	addi $t1, $zero, 8
	sw $t1, 12($sp)
	addi $t1, $zero, 7
	sw $t1, 8($sp)
	addi $t1, $zero, 3
	sw $t1, 4($sp)
	addi $t1, $zero, 1
	sw $t1, 0($sp)
	addu $t1, $zero, $zero
	jr $ra	
	
printValue:
	add $sp, $sp, $t3 #T3 ja foi carregado no for de j, move o cursor para a posicao i
	lw $s1, 0($sp) #Armazena em $s1 v[i]
	sub $sp, $sp, $t3 #T3 ja foi carregado no for de j, retorna o cursor para a posicao original
	add $a0, $zero,$s1	
	li $v0, 1			 # print num syscall 1. 
	la $a0, ($s1)			# load no endereço da string a ser impressa.	
	syscall
	
    	addi $t0, $t0, 1 #i++
    	#Vamos escrever o i, $t0
	addi $sp, $sp, -20 #Move o cursor para posicao -28 - 20, que é -48
	sw $t0, 0($sp) #Armazena i
	addi $sp, $sp, 20 #Retorna para a posicao -28		
	#PRONTO
	j for1	
exit:
