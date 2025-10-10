TME4
MUSA Marie-Christine
21318395

<listes-fichiers> dans le dossier :
- papillons.txt
- princesse.txt
- monstre.txt
- chats.txt

Je penssais qu'il fallait faire nous-même une fonction grep mais au final, je me suis rendu compte qu'il existait execl pour grep.

1.  code : grep.c
    exec :
        make grep
        ./grep <motif> <listes-fichiers>
        ex: ./grep le papillons.txt princesse.txt monstre.txt

2.  code : grep2.c
    exec : 
        make grep2
        ./grep2 <motif> <listes-fichiers>
        ex: ./grep un papillons.txt princesse.txt monstre.txt

3.  code : grep.c [ changement : wait -> wait3]
    exec :
        make grep
        ./grep <motif> <listes-fichiers>
         ex: ./grep le papillons.txt princesse.txt monstre.txt

4. Un processus zombie est un processus qui a finit son exécution dont le parent n'a pas récupérer son statut de fin avec wait().

    code : zombie.c
    exec :
        make zombie
        ./zombie