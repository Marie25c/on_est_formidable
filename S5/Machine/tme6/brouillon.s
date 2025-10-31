.data

    .align 0

chaine: .space 11          # 10 chiffres + fin de chaîne



.text



    lui $8, 0x1001          # $8 = partie haute de l’adresse de chaine

    ori $9, $8, 0           # $9 = adresse complète de chaine



    addiu $29, $29, -16     # allocation pile (16 octets)



    ori $2, $0, 5           # syscall 5 : lecture d’un entier

    syscall

    sw $2, 0($29)           # nb → pile[0]



    sb $0, 10($9)           # fin de chaîne à l’indice 10



    ori $10, $0, 9          # i = 9

    sw $10, 4($29)          # pile[4]



    ori $11, $0, 0          # r = 0

    sw $11, 8($29)          # pile[8]



    addiu $15, $0, -1       # seuil = -1

    sw $15, 12($29)         # pile[12]



    ori $24, $0, 10         # diviseur = 10

    ori $25, $0, 1          # décrément = 1



for:

    lw $10, 4($29)          # i

    lw $15, 12($29)         # seuil

    beq $10, $15, fin_for   # si i == -1 → fin



    lw $14, 0($29)          # nb

    divu $14, $24           # nb / 10



    mflo $11                # r = quotient

    sw $11, 8($29)



    mfhi $14                # nb = reste

    sw $14, 0($29)



    addu $13, $9, $10       # adresse chaine[i]

    addi $11, $11, 0x30     # conversion ASCII

    sb $11, 0($13)          # stockage caractère



    subu $10, $10, $25      # i--

    sw $10, 4($29)

    j for



fin_for:

    addiu $29, $29, 16      # libération pile



    ori $2, $0, 4           # syscall 4 : afficher chaîne

    ori $4, $9, 0           # $4 = adresse de chaine

    syscall



    ori $2, $0, 10          # syscall 10 : exit

    syscall
