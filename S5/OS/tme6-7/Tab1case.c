/* Diffusion tampon 1 case */

  #include <stdio.h> 
  #include <unistd.h> 
  #include <stdlib.h> 
  #include <signal.h> 
  #include <libipc.h>


/************************************************************/

/* definition des parametres */ 

  #define NE          2     /*  Nombre d'emetteurs         */ 
  #define NR          5     /*  Nombre de recepteurs       */ 

/************************************************************/

/* definition des semaphores */ 

int def_sem(){

  if (creer_sem(2+NR)==-1){
    perror("Erreur de création de semaphore");
    return 1;
  }
  return 0;

}

int init_des_sem(){

  // Sémaphore EMET -> pour les émetteurs
  if(init_un_sem(0,1)==-1){
    perror("Erreur création sémaphore EMET");
    return 1;
  }

  // Sémaphore MUTEX -> contrôle de l'écriture des messages 
  if(init_un_sem(1,1)==-1){
    perror("Erreur création sémaphore MUTEX");
    return 1;
  }

  // Tableau RECEP : 1 -> NR + 1
  for(int i = 2; i<NR+2 ; i++){
    if(init_un_sem(i,0)==-1){
      perror("Erreur création sémaphore RECEP");
      return 1;
    }
  }

  return 0;

}
        
/************************************************************/

/* definition de la memoire partagee */ 

void *sp;

struct Memoire_partagee {
    int nb_recepteurs; // Plusieurs récepteurs peuvent lire presque en même temps mais pas dans le même ordre de création de processus
    int TAMPON; // le TAMPON des émetteurs
};

/************************************************************/

/* variables globales */ 
    int emet_pid[NE], recep_pid[NR]; 

/************************************************************/

/* traitement de Ctrl-C */ 

  void handle_sigint(int sig) { 
      int i;
      for (i = 0; i < NE; i++) kill(emet_pid[i], SIGKILL); 
      for (i = 0; i < NR; i++) kill(recep_pid[i], SIGKILL); 
      det_sem(); 
      det_shm((char *)sp); 
  } 

/************************************************************/

/* fonction EMETTEUR */ 

void fct_emetteur(int sem, int message){
  // Ecrit dans tampon
  struct Memoire_partagee *partage = (struct Memoire_partagee *)sp;
  while(1){
  P(0); // P(EMET)
  partage->TAMPON=message; // Ecriture de EMET dans Tampon
  for(int i = 2; i<NR+2 ; i++){
    V(i); // V(RECEP[i])
  }
  }
  
}

/************************************************************/

/* fonction RECEPTEUR */ 

	// A completer - contient les instructions executees
        // par un recepteur

void fct_recepteur(int sem){
  while(1){
    P(sem);
    P(1);
    struct Memoire_partagee *partage = (struct Memoire_partagee *)sp;
    printf(" RECEP[ %d ] lit : %d \n", sem-1,partage->TAMPON );
    // lecture des émetteurs
    partage -> nb_recepteurs ++;
    V(1);
    if( partage -> nb_recepteurs == NR ){
      partage -> nb_recepteurs = 0;
      V(0);
    }
  }
}


/************************************************************/

int main() { 
    struct sigaction action;
    /* autres variables (a completer) */
    
    setbuf(stdout, NULL);

/* Creation du segment de memoire partagee */

	// A completer

  if ( (sp = (struct Memoire_partagee *)(init_shm(sizeof(struct Memoire_partagee) )))== NULL) {
		perror("init_shm");
		exit(1);
	}

  struct Memoire_partagee *partage = (struct Memoire_partagee *) sp;
  partage->nb_recepteurs = 0;
  partage->TAMPON = 0;


/* creation des semaphores */ 

	// A completer

  def_sem();

/* initialisation des semaphores */ 

	// A completer

  init_des_sem();

/* creation des processus emetteurs */ 

	// A completer - les pid des processus crees doivent
        // etre stockes dans le tableau emet_pid

  pid_t pid_e;
  for(int i = 0; i < NE ; i++){

    pid_e = fork();

    if(pid_e == 0 ){ // J'ai du mal à comprendre quand quel émetteur écrit ?
      fct_emetteur(i, getpid());
      exit(0);
    }

    if( pid_e > 0){
      emet_pid[i] = pid_e;
    }
    
  }



/* creation des processus recepteurs */ 

	// A completer - les pid des processus crees doivent
        // etre stockes dans le tableau recep_pid
  
  pid_t pid_r;
  for(int i = 0; i < NR ; i++){

    pid_r = fork();

    if( pid_r > 0){
      recep_pid[i] = pid_r;
    }

    if( pid_r == 0){
      fct_recepteur(i+2); // Rapel le tableau de recpeteur commence à 2 -> NR + 2
      exit(0);

    }
    
  }

  
/* redefinition du traitement de Ctrl-C pour arreter le programme */ 

    sigemptyset(&action.sa_mask);
    action.sa_flags = 0;
    action.sa_handler = handle_sigint;
    sigaction(SIGINT, &action, 0); 
    
    pause();                    /* attente du Ctrl-C  */
    return EXIT_SUCCESS;
} 
