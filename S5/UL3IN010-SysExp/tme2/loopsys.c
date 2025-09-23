#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int main(){
    long int i =0;
    while(i<50000000){
        getpid();
        i++;
    }
    return 0;

}