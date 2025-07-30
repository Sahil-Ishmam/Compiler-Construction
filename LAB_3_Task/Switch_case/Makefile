input = input.txt
output = output.txt

main:prac.l prac.y
	bison -d prac.y
	flex prac.l
	gcc prac.tab.c lex.yy.c
	./a.exe < input.txt > output.txt