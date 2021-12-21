all : test

clean:
	rm *.out

test:type.c
	gcc type.c