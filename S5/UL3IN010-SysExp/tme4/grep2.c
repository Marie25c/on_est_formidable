#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

#define MAXFILS 2

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
        printf("Erreur : ./grep <motif> <liste-fichiers> \n");
        return 1;
    }

    const char* motif = argv[1];
    int cpt = 2;
    int process_fils=0;

    while(cpt<argc){

        if(process_fils > MAXFILS) wait(NULL);

        pid_t pid = fork(); // Creation d'un processus
        

        if(pid == -1){ //Appel à la primitive a échoué
            perror("Erreur dans le fork. \n");
            return 1;
        }

        else{

            if( pid == 0){ // Processus fils
                printf("id_fils = %d ", getpid() );
                //grep(argv[cpt],motif);
                execl("/bin/grep", "grep", motif, argv[cpt], (char *)NULL);
                exit(0);

            }
                
            else{
                printf("id_pere = %d ", getpid() );
                while(wait(NULL) >0);
                process_fils++;
                cpt ++;

            }
            
        }
    }

    



    return 0;

}