#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <string.h>

int grep(const char* filename,const char* motif ){

    FILE *f=fopen(filename,"r");

    if(!f){

        printf(" Erreur d'ouverture de fichier \n");
        return 1;

    }

    printf(" Recherche dans %s : ",filename );

    char buffer[256];
    int nb_lignes=0;
    while(fgets(buffer,256,f))
    {
        if(strstr(buffer,motif))
        {
            printf("%d: %s",nb_lignes, buffer);
        }
        nb_lignes++;

    }
    printf("\n");

    fclose(f);

    return 0;

}

int main(int argc,const char* argv[]){

    if( argc < 3 ){
        printf("Usage : ./grep <motif> <liste-fichiers> \n");
        return 1;
    }

    const char* motif = argv[1];
    int cpt = 2;
    struct rusage r;

    while(cpt<argc){

        pid_t pid = fork(); // Creation d'un processus

        if(pid == -1){ //Appel à la primitive a échoué
            perror("Erreur dans le fork. \n");
            return 1;
        }

        else{
            if( pid == 0){ // Processus fils
                printf(" Père : %d Fils : %d \n ",getppid(), getpid());
               /* if(grep(argv[cpt],motif)== 1){
                    printf(" Erreur dans la liste de fichier \n");
                    return 1;
                }*/
                execl("/bin/grep", "grep", motif, argv[cpt], (char *)NULL);
                exit(0); // Fin processus fils
            }
            else{
                printf(" Père : %d Compteur : %d \n ",getpid(), cpt);
            }
            
        }

        cpt++;

    }

    int status;
    pid_t child = wait3(&status,0,&r);

    while(child > 0){
        printf("Fils %d \n",child);
        printf("Temps Util. : %f\n", r.ru_utime.tv_sec + 1E-6*r.ru_utime.tv_usec);
        printf("Temps Syst. : %f\n", r.ru_stime.tv_sec + 1E-6*r.ru_stime.tv_usec);
        child = wait3(&status,0,&r);
    }

    //while(wait(NULL) > 0);
    /* wait(null) -> ne récupére pas pid fils
     tous processus fils terminés */

    return 0;

}