#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/times.h>
#include <unistd.h>


void lance_commande(char * commande){

    // struct timeval tv;

    struct tms deb,fin;
    clock_t t0,t1;
    t0= times(&deb);
    int test = system(commande);
    if (test != 0) printf("Erreur la commande n'a pas été executée correctement.\n");

    /*
    if(gettimeofday(&tv,NULL)==0)
    printf(" Temps = Secondes : %ld Microsecondes : %ld \n", tv.tv_sec, tv.tv_usec);
    */
    
    t1= times(&fin);
    long tps = sysconf(_SC_CLK_TCK);
    double total = (t1-t0)/tps;
    printf("Statistiques de %s \n",commande);
    printf("Temps total : %f\n",total);
    printf("Temps utilisateur : %f\n",(double)fin.tms_utime/tps);
    printf("Temps systeme : %f\n",(double)fin.tms_stime/tps);
    printf("Temps utilisateur fils : %f\n",(double)fin.tms_cutime/tps);
    printf("Temps systeme fils : %f\n",(double)fin.tms_cstime/tps);
    
}

int main(int argc,char *argv[]){

    if(argc < 2 ){
        printf("Erreur, il faut un parametre : ./mytimes <commande> \n");
        return 1;
    }

    for(int i=1;i<argc;i++){
        lance_commande(argv[i]);
        printf("\n");
    }
    
    return 0;

}