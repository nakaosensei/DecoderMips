#include <stdio.h>
#include <stdlib.h>

/*
	@author:nakao
	Bubble sort trivial.
*/

void initVariables(int *vet){
	*(vet)=9;
	*(vet+1)=4;
	*(vet+2)=6;
	*(vet+3)=5;
	*(vet+4)=8;
	*(vet+5)=7;
	*(vet+6)=3;
	*(vet+7)=1;
	return;
}

int main(){		   
	int i,j,tmp;	
	int *vet = calloc(8,sizeof(int));
	initVariables(vet);	
	int contLacos = 0;
	for(i=0;i<=7;i++){
		for(j=i+1;j<=7;j++){
			contLacos++;
			if(vet[i]>vet[j]){
				tmp=vet[j];
				vet[j]=vet[i];
				vet[i]=tmp;	
			}			
		}
		printf("%d ",vet[i]);
	}		
	printf("\nCont lacos: %d",contLacos);
	return 0;
}
