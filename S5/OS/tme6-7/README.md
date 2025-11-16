TME 6-7
MUSA Marie-Christine
21318395

1.1 | Mécanisme de synchronisation. 


1.2 | Avoir un seul sémaphore RECEP peut embrouiller le programme et faire perdre la case occupée ou libre. AUtrement dit, il est plus prudent d'avoir un tableau de RECEP afin d'assurer le passage de chaque Récepteur.
C'est le sémaphore EMET qui prévient les émetteurs de la disponibilité de la case.

1.3 | Tab1case.c, 
quelques points :

- J'ai commenté :)

- J'ai un peu du mal à comprendre comment le sémaphore EMET prévient les ématteurs de la disponiblité de la case. J'ai compris le principe mais ça reste un peu flou.
Mais l'idée c'est que si EMET < 0 alors ça bloque et attend que le EMET soit incrémenter par V(EMET) après la lecture du message par l'ensemble des récepteurs


