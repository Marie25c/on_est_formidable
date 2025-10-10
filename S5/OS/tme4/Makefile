PROGRAMS = grep grep2 zombie

all : $(PROGRAMS)

grep : grep.c
	gcc -Wall $^ -o $@

grep2 : grep2.c
	gcc -Wall $^ -o $@

zombie : zombie.c
	gcc -Wall $^ -o $@

clean:
	rm -f *.o *~ $(PROGRAMS)