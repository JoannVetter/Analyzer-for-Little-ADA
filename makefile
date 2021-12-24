littleAdaParser: lex.yy.c
	gcc lex.yy.c -o littleAdaParser 

lex.yy.c: littleAdaParser.l
	flex littleAdaParser.l

clean:
	rm lex.yy.c
	rm littleAdaParser