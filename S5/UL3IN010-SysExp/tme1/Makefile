PROGRAMS = test1

all : $(PROGRAMS)

test1 : tab.c maintab.c
	gcc -Wall $^ -o $@

clean:
	rm -f *.o *~ $(PROGRAMS)