#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
 
int main() {

    pid_t p=fork();

    if(p==-1){
        printf("Erreur de fork.\n");
        return 1;
    }

    if(p == 0){
        printf(" [ PERE %d ] FILS %d \n",getppid(), getpid());
        exit(0);
    }

    pid_t p2=fork();

    if(p2==-1){
        printf("Erreur de fork.\n");
        return 1;
    }

    if(p2 == 0){
        printf(" [ PERE %d ] FILS %d \n",getppid(), getpid());
        exit(0);
    }
        
    printf(" PERE %d au dodo \n", getpid());
    sleep(10);

    wait(NULL);
    wait(NULL);

    printf("FIN du dodo !\n");

    return 0;
 }