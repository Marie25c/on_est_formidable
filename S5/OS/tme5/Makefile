PROGRAMS = arbre mini_shell mini_shell2

all : $(PROGRAMS)

arbre : arbre.c
	gcc -Wall $^ -o $@

mini_shell : mini_shell.c
	gcc -Wall $^ -o $@

mini_shell2 : mini_shell2.c
	gcc -Wall $^ -o $@

clean : 
	rm -f *.o *~ $(PROGRAMS)