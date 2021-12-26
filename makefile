littleAdaParser: littleAdaParser.tab.c lex.yy.c
	gcc -g lex.yy.c littleAdaParser.tab.c -o littleAdaParser

lex.yy.c: littleAdaParser.l littleAdaParser.tab.c
	flex littleAdaParser.l

littleAdaParser.tab.c: littleAdaParser.y
	bison -d littleAdaParser.y

clean:
	rm lex.yy.c || true
	rm littleAdaParser.tab.c || true
	rm littleAdaParser.tab.h ||true
	rm littleAdaParser || true