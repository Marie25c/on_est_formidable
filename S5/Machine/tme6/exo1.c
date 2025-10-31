#include <stdio.h>
#include <stdlib.h>

int main() {
    char chaine[11];       // Au plus 10 chiffres + 1 caractère de fin de chaîne
    int i, nb, r;

    scanf("%d", &nb);      // Lecture d’un nombre entier au clavier
    chaine[10] = '\0';     // Caractère de fin de chaîne (null terminator)

    // Remplissage de la chaîne représentant le nombre,
    // avec des zéros en tête si nécessaire
    for (i = 9; i >= 0; i--) {
        r = nb % 10;               // Extraction du chiffre des unités
        nb = nb / 10;              // Passage au chiffre suivant
        chaine[i] = r + '0';       // Conversion en caractère ASCII
    }

    printf("%s\n", chaine);        // Affichage de la chaîne
    return 0;
}
