#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "tab.h"

int max(int* liste,int taille){
    int max = liste[0];
    for(int i=1;i<taille;i++){
        if(max < liste[i]) {
            max = liste[i];
        }
    }
    return max;
}

void InitTab(int *tab,int size){
    for(int i=0; i<size;i++){
        tab[i] = rand() % 10;
    }

}

void PrintTab(int *tab,int size){
    printf("Test -- PrintTab \n");
    for(int i=0; i<size;i++){
        printf("tab[%d]=%d \n",i,tab[i]);
    }

}

int SumTab(int *tab, int size){
    int somme=0;
    for(int i=0; i<size;i++){
        somme += tab[i];
    }
    return somme;
}

int MinSumTab(int *min, int *tab, int size){

    *min = tab[0];
    printf("%d \n",*min);
    for(int i=1;i<size;i++){
        if(*min > tab[i]) {
            *min = tab[i];
        }
    }

    return SumTab(tab,size);
}


