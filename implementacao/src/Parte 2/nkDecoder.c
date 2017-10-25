#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>


/*
	@author: nakaosensei
	email: nakaosensei@gmail.com
	Decodificador de instruções elementar em C.
	O código abaixo contém o código base reaproveitado do esqueleto
	passado pelo professor Rogério Alves Gonçalves, UTFPR - CM, todos
	os creditos a ele atribuidos.

	O objetivo deste código foi a criação de um decodificador de 
	instruções de 32 bits do MIPS, esse decodificar NÃO IMPLEMENTA
	TODAS AS FUNÇÕES PRESENTES NO MIPS, foi apenas um trabalho de
	graduação, esse código pode ser usado/atualizado por qualquer
	um, exceto alunos posteriores da disciplina de arquitetura e
	organização de computadores da UTFPR-cm.
*/

//Definição das mascaras
int maskImmediate =  0x0000FFFF; //0000 0000 0000 0000 1111 1111 1111 1111
int maskAddress =    0x03FFFFFF; //0000 0011 1111 1111 1111 1111 1111 1111
int maskOpCode =     0xFC000000; //1111 1100 0000 0000 0000 0000 0000 0000 
int maskRs =         0x03E00000; //0000 0011 1110 0000 0000 0000 0000 0000
int maskRt =         0x001F0000; //0000 0000 0001 1111 0000 0000 0000 0000
int maskRd =         0x0000F800; //0000 0000 0000 0000 1111 1000 0000 0000
int maskShamt =      0x000007C0; //0000 0000 0000 0000 0000 0111 1100 0000
int maskFunct =      0x0000003F; //0000 0000 0000 0000 0000 0000 0011 1111

//Vetor com as labels/posições dos 32 registradores do mips, manter nessa ordem é crucial
char * regs[32]=
	{"$zero","$at","$v0",
	 "$v1","$a0","$a1",
	 "$a2","$a3","$t0",
	 "$t1","$t2","$t3",
	 "$t4","$t5","$t6",
	 "$t7","$s0","$s1",
	 "$s2","$s3","$s4",
	 "$s5","$s6","$s7", 
	 "$t8","$t9","$k0",
	 "$k1","$gp","$sp",
	 "$fp", "$ra"};

//Funções de filtragem -> Realizando operações de shift sobre as mascaras com & lógico sobre um registrador de instrução,
//é possível obter somente os numeros num intervalo desejado, no mips, os registradores tem tamanho fixo de 32 bits,
//sendo sempre 6 para op code, 5 para rs, 5 para rt, 5 para rd, 5 para shamt e 6 para funct. Esse é um ótimo recurso
//para obter 'subnumeros' em um intervalo especifico sem ter que trabalhar com strings, detalhes:
//1)Essas operações estão sendo realizadas sobre numeros em hexadecimal e retornam valores hexadecimais.
//2)Tendo em vista o item 1, cabe ao programador saber o que fazer com a saida em hexa.


unsigned int getOpCode(unsigned int ir) {
	return (ir&maskOpCode) >> 26;
}

int getImmediate(int ir) {
	return (ir&maskImmediate);
}

int getFunct(int ir) {
	return (ir&maskFunct);
}

int getRt(int ir) {
	return (ir&maskRt) >> 16;
}

int getRs(int ir) {
	return (ir&maskRs) >> 21;
}

int getRd(int ir) {
	return (ir&maskRd) >> 11;
}

int getShamt(int ir) {
	return (ir&maskShamt) >> 6;
}

int getAddress(int ir) {
	return (ir&maskAddress);
}

//Finalmente, vamos a função que decodifica uma instrucao! 
//Não é atoa que o decodificador é chamado de elementar, ele apenas printa o codigo decoficado na saida padrão.
void decodeIR(int ir){
	switch(getOpCode(ir)){
		case 0://Quando o OP code é 0, devemos olhar para o funct para saber o que fazer
			switch(getFunct(ir)){
				case 0:
					if(ir==0x00000000){
						printf("nop\n");
					}else{
						printf("sll ");
						printf("%s\n",regs[getRs(ir)]);
					}	
				break;
				
				case 2:
					printf("srl ");
					printf("%s\n",regs[getRs(ir)]);
				case 8:
					printf("jr ");
					printf("%s\n", regs[getRs(ir)]);
				break;
				case 10:
					printf("mfhi ");
					printf("%s\n", regs[getRd(ir)]);
				break;
				case 18:
					printf("mflo ");
					printf("%s\n", regs[getRd(ir)]);
				break;
				case 24:
					printf("mult ");
					printf("%s, ", regs[getRs(ir)]);
		         		printf("%s\n", regs[getRt(ir)]);
				break;
				case 32:
					printf("add ");
					printf("%s, ", regs[getRd(ir)]);
					printf("%s, ", regs[getRs(ir)]);
					printf("%s\n", regs[getRt(ir)]);
				break;
				case 33:
					printf("addu ");
					printf("%s, ", regs[getRd(ir)]);
					printf("%s, ", regs[getRs(ir)]);
					printf("%s\n", regs[getRt(ir)]);
				break;
				case 34:
					printf("sub ");
					printf("%s, ", regs[getRd(ir)]);
					printf("%s, ", regs[getRs(ir)]);
					printf("%s\n", regs[getRt(ir)]);
				break;
				case 35:
					printf("subu ");
				        printf("%s, ", regs[getRd(ir)]);
				        printf("%s, ", regs[getRs(ir)]);
				        printf("%s\n", regs[getRt(ir)]);                
				break;
				case 36:
		                        printf("and ");
				        printf("%s, ", regs[getRd(ir)]);
				        printf("%s, ", regs[getRs(ir)]);
				        printf("%s\n", regs[getRt(ir)]);				
				break;
				case 37:
				        printf("or ");
				        printf("%s, ", regs[getRd(ir)]);
				        printf("%s, ", regs[getRs(ir)]);
				        printf("%s\n", regs[getRt(ir)]);				
				break;
				case 42:
				        printf("slt ");
				        printf("%s, ", regs[getRd(ir)]);
				        printf("%s, ", regs[getRs(ir)]);
				        printf("%s\n", regs[getRt(ir)]);
				break;
			}					
		break;
		case 2:
                	printf("j ");
			printf("%X\n", getAddress(ir));
		break;
		case 3:
			printf("jal ");
			printf("%X\n", getAddress(ir));
		break;
		case 4:
			printf("beq ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 5:
			printf("bne ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 8:
			printf("addi ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 9:
			printf("addiu ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 12:
			printf("andi ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 13:
			printf("ori ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 35:
			printf("lw ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 41:
			printf("sh ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		case 43:
			printf("sw ");
			printf("%s, ", regs[getRt(ir)]);
			printf("%s, ", regs[getRs(ir)]);
			printf("%d\n", getImmediate(ir));
		break;
		default : 
		       printf("Deu ruim, nao implementei essa instrucao. \n");
		}
}

//Funcoes de conversão
void printByte(int in){
   int i;
   for(i=0;i<=31;i++){
      if((in&0x80)!=0){ 
         printf("1");
      }else{
         printf("0");
      }
      if (i==3){
         printf(" "); 
      }
      in = in<<1;
   }
}

int convertBinaryToInt(char *in) {
  int out = (int)strtol(in, 0, 2);
  return out;
}

//Funcoes de manipulacao de arquivos
char* readLine(FILE*);

char* readLine(FILE* file) {
    char* result = calloc(60, sizeof(char));
    char* lineRemover;
    if (!fgets(result, 60, file)) {
	return NULL;
    }
    if ((lineRemover = strchr(result, '\n'))) {
	*lineRemover = 0;
    }
    return result;
}

int main(int argc,char *argv[]){	
    //if(argc<=1){
    //   printf("Uso:\n ./decodificador arquivo.b\n");
    //   return 0;
    //}
    FILE *f = fopen("nkBbSort.b","r");
    if(!f){
	printf("Arquivo nao encontrado");
	exit(1);
    }
    char *line;	
    while(line=readLine(f)){					
	decodeIR(convertBinaryToInt(line));
    }
    if(line){
	free(line);
    }
    fclose(f);
    return 0;
}























