.data
ch : .asciiz "npotfdsfu"      # Chaîne d'entrée à décrypter
ch2: .space 10                # Espace pour la chaîne décryptée
decalage : .byte 1             # Décalage pour le chiffrement César (1 ici)

.text
    addiu $29, $29, -12        # Réserver de l'espace pour les variables locales : i et tmp

main:
    lui $8, 0x1001             # Charger l'adresse de .data

    # Affichage de la chaîne ch
    or $4, $0, $8 
    ori $2, $0, 4              # Code syscall pour afficher une chaîne
    syscall 

decipher_cesar:
    sw $0, 0($29)              # i = 0
    lui $13, 0x1001
    ori $13, $13, 0x0015       # Charger l'adresse du décalage
    lbu $13, 0($13)            # Charger le décalage (1 dans ce cas)
    
    addiu $25, $0, 26          # Valeur de 26 pour le modulo (pour les 26 lettres de l'alphabet)
    addiu $15, $0, 0x61        # + 'a' (ASCII de 'a' = 97)

loop:
    lw $10, 0($29)             # Charger i
    lui $11, 0x1001
    or $11, $11, $10           # Charger src[i] : ch[i]
    lbu $11, 0($11)

    # Fin de la chaîne ? (on teste si c'est le caractère nul)
    beq $11, $0, end

    # Décryptage du caractère (avec ajustement pour 'a' et décalage)
    subu $12, $11, $15         # Soustraire 'a' (pour les minuscules)
    subu $12, $12, $13         # Soustraire le décalage
    addiu $12, $12, 26         # Assurer que ça reste positif (mod 26)
    divu $12, $25              # Appliquer modulo 26
    mfhi $24                   # tmp % 26 (le reste de la division)

    # Ajouter 'a' de nouveau pour obtenir le caractère décrypté
    addu $24, $24, $15         # Ajouter 'a' pour revenir au caractère décrypté
    
    # Stocker le résultat dans ch2
    lui $14, 0x1001
    ori $14, $14, 0x000B       # Adresse de ch2
    addu $14, $14, $10         # Déplacer à la bonne position (ch2[i])
    sb $24, 0($14)             # Sauvegarder le caractère décrypté

    # Incrémenter l'indice i
    addiu $10, $10, 1          # i++
    sw $10, 0($29)             # Mettre à jour la valeur de i
    j loop                     # Continuer la boucle

end:
    # Ajouter un caractère nul à la fin de la chaîne décryptée
    lui $14, 0x1001
    ori $14, $14, 0x000B       # Adresse de ch2
    addu $14, $14, $10         # Déplacer à la position suivante
    sb $0, 0($14)              # Ajouter le caractère nul pour terminer la chaîne

    # Affichage de la chaîne décryptée (ch2)
    lui $4, 0x1001             # Charger l'adresse de ch2
    ori $4, $4, 0x000B         # Ch2 est à l'adresse 0x1001 + 0x000B
    ori $2, $0, 4              # Code syscall pour afficher une chaîne
    syscall

    # Affichage d'une nouvelle ligne
    ori $2, $0, 10             # Code syscall pour afficher un retour à la ligne
    syscall
