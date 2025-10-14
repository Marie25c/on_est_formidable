#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <sys/time.h>
#include <sys/resource.h>

#define MAX_ARGS 100

int commande(void){

    struct rusage r;
    char commande[100];
    const char *sep=" ";
    char *token;

    fgets(commande,100,stdin);
    printf("%s \n",commande);

    // ---- AIDE CHAT ----

    commande[strcspn(commande, "\n")] = '\0';

    int i = strlen(commande) - 1;
    while (i >= 0 && commande[i] == ' ') {
        commande[i] = '\0';
        i--;
    }

    int esperluette = 0;
    if( commande[i]=='&'){
        esperluette = 1;
        commande[i]='\0';
    }

    // ------------------

    token = strtok(commande,sep);
    char *args[MAX_ARGS];
    int j=0;
    while(token != NULL){
        args[j]=token;
        token = strtok(NULL, sep);
        j++;
    }

    args[MAX_ARGS-1]=NULL;

    if(strcmp(commande,"quit")==0) return 0;

    else{

        pid_t p = fork();

        if(p==-1){
            printf(" Erreur fork()\n");
            exit(2);
        }

        if(p==0){
            char bin[256] = "/usr/bin/";
            printf("lancement %s fils [%d]\n",args[0],p);
            execv(strcat(bin,args[0]),args);
            exit(0);
        }

        if(esperluette == 0){
            wait3(NULL,0,&r);
            printf( "FILS [%d] \n",p);
            printf(" Temps U : %f\n", r.ru_utime.tv_sec+1E-6*r.ru_utime.tv_usec);
            printf(" Temps S : %f\n", r.ru_stime.tv_sec+1E-6*r.ru_stime.tv_usec);
        }

        return 1;
    }

}

int main(int argc, char* argv[]){

    if ( argc < 1 ){
        printf(" Format : ./mini_shell \n");
        exit(2);
    }
    printf(" Lancement mini shell : \n");
    
    while(commande()!=0);
    
    return 0;

}