#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/resource.h>
#include "tab.h"

void PrintMem(){
    struct rusage usage;
    if(getrusage(RUSAGE_SELF,&usage)==0) printf("%ld \n", usage.ru_maxrss);
}

int main(){

    srand(time(NULL));

    
    printf("Ex 1 \n");

    int tab[6] = {0,5,2,6,9,3};
    int maxtab1 = max(tab,6);
    int tab2[5] = {1,25,127,99,31};
    int maxtab2 = max(tab2,5);
    int tab3[8] = {1,9,0,38,12,88,9,10};
    int maxtab3 = max(tab3,8);

    printf("Max tab1 : %d\n",maxtab1);
    printf("Max tab2 : %d\n",maxtab2);
    printf("Max tab3 : %d\n",maxtab3);

    printf("\n");
    printf("Ex 2 \n");

    int NMAX = 10;
    int tab_stat[NMAX];
    int *tab_dyn=malloc(sizeof(int)*NMAX);

    int min;
    int min2;

    printf("Tableau Statique \n");
    InitTab(tab_stat,NMAX);
    PrintTab(tab_stat,NMAX);
    int som_stat= MinSumTab(&min,tab_stat,NMAX);
    printf("Somme : %d , Min : %d \n", som_stat, min);

    
    printf("\n");

    printf("Tableau Dynamique \n");
    printf("Print avant init \n");
    InitTab(tab_dyn,NMAX);
    printf("Print apres init \n");
    PrintTab(tab_dyn,NMAX);
    int som_dyn = MinSumTab(&min2,tab_dyn,NMAX);
    printf("Somme : %d , Min : %d \n", som_dyn, min2);

    printf("\n");

    int NMAXX = 1000000;
    int *tab_dyn2=malloc(sizeof(int)*NMAXX);

    PrintMem();
    printf("Tableau Dynamique 2 avec NMAX = 1 000 000\n");
    printf("Print avant init \n");
    PrintMem();
    InitTab(tab_dyn2,NMAXX);
    printf("Print apres init \n");
    PrintMem();

    printf("\n");

    printf("Réponse : \n"
        "Avant initialisation, on constate que l'utilisation de la RAM reste \n"
        "inchangée car les cases allouées n'ont pas encore été utilisées.\n"
        "Après initialisation, puisque les cases allouées ont été écrites,\n"
        "la taille de la RAM a nettement augmenté : on passe de 2496 à 5248.\n");


    /*
        Avant initialisation, on constate que l'utilisation de la RAM reste
        inchangée car les cases allouées n'ont pas encore été utilisées.
        Après initialisation, puisque les cases allouées ont été écrites,
        la taille de la RAM a nettement augmenté : on passe de 2496 à 5248.
    */

    free(tab_dyn);
    free(tab_dyn2);

    return 0;
}