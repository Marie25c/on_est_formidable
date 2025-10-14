#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <string.h>

struct abr{
    int h;
    struct abr* fg;
    struct abr* fd;
};

int nv_arbre(int n){
    if(n==0) return 0;
    else{

        pid_t p1,p2;
        p1=fork();
        if( p1 ==-1 ){
            perror(" Erreur de fork() :( \n");
            return -1;
        }
        if( p1 == 0 ){
            nv_arbre( n - 1 );
            //printf(" FILS [%d] DODO \n",p1);
            sleep(30);
            exit(0);
        }
        p2 = fork();
        if( p2 ==-1 ){
            perror(" Erreur de fork() :( \n");
            return -1;
        }
        if( p2 == 0 ){
            nv_arbre( n - 1 );
            //printf(" FILS [%d] DODO \n",p2);
            sleep(30);
            exit(0);
        }
        waitpid(p1,NULL,0);
        printf(" FILS [%d] REVEIL \n",p1);
        waitpid(p2,NULL,0);
        printf(" FILS [%d] REVEIL \n",p2);
        return 0;
    }
}

int main(int argc, char* argv[]){

    if(argc < 2){
        printf(" Format : %s <niveau> \n",argv[0]);
        return 1;
    }

    int num = atoi(argv[1]);

    nv_arbre(num);

    return 0;

}