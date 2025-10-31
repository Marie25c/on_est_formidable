#include <stdio.h>
#include <stdlib.h>

int user_num;               // entier non initialisé (valeur indéfinie au départ)
int tab_chiffre[10] = {0};  // tableau de 10 entiers initialisés à 0

// Fonction qui compte les chiffres d'un nombre et remplit le tableau d'occurrences
int occ_num_chiffre(int n, int t[]) {
    int nb_c = 1; // nombre de chiffres
    int q = n;
    int r;

    while (q >= 10) {
        r = q % 10;   // reste de la division par 10 → chiffre des unités
        q = q / 10;   // quotient → on retire le dernier chiffre
        t[r] += 1;    // +1 occurrence du chiffre r
        nb_c += 1;    // incrémenter le nombre total de chiffres
    }

    t[q] += 1; // dernier chiffre (le plus à gauche)
    return nb_c;
}

int main(void) {
    int num_ch; // nombre de chiffres décimaux

    printf("Entrez un nombre : ");
    scanf("%d", &user_num); // lire la valeur de user_num au clavier

    num_ch = occ_num_chiffre(user_num, tab_chiffre);

    printf("Nombre de chiffres : %d\n", num_ch);

    printf("Occurrences des chiffres :\n");
    for (int i = 0; i < 10; i++) {
        if (tab_chiffre[i] > 0)
            printf("Chiffre %d : %d fois\n", i, tab_chiffre[i]);
    }

    return 0;
}
