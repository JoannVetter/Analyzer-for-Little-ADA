littleAdaParser: littleAdaParser.c littleAdaParser.h lex.yy.c
	gcc littleAdaParser.c lex.yy.c -ll -o littleAdaParser 

lex.yy.c: littleAdaParser.l
	lex littleAdaParser.l

clean:
	rm littleAdaParser
	rm lex.yy.c