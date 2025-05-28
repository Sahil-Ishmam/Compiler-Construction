CC = gcc
CFLAGS = -I.
DEPS = Multiplicationmake.h
OBJS = Multiplicationmake.o Multiplicationfunc.o

all:
	gcc -o Multiplication Multiplication.c
	gcc -E Multiplication.c > Multiplication.i 
	gcc -S -masm=intel Multiplication.i
	as -o Multiplication.o Multiplication.s
	objdump -M intel -d Multiplication.o > Multiplication.dump
	gcc -c -o Multiplication.o Multiplication.c
	objdump -M intel -d Multiplication.o > Multiplication2.dump

Multiplicationmake: Multiplicationmake.c Multiplicationfunc.c
	gcc -o Multiplicationmake Multiplicationmake.c Multiplicationfunc.c -I.

Multiplicationmake2: Multiplicationmake.o Multiplicationfunc.o
	$(CC) -o Multiplicationmake Multiplicationmake.o Multiplicationfunc.o $(CFLAGS)

# Multiplicationmake.o: Multiplicationmake.c
# 	gcc -c -o Multiplicationmake.o Multiplicationmake.c -I.

# Multiplicationfunc.o: Multiplicationfunc.c
# 	gcc -c -o Multiplicationfunc.o Multiplicationfunc.c -I.

Multiplicationmake3: $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

%.o: %.c $(DEPS) 
	gcc -c -o $@ $< -I.

.PHONY: clean

clean:
	rm -f *.o

assembler:
	C:\masm32\bin\ml /c /coff /Cp prog1.asm
	C:\masm32\bin\link -entry:main /subsystem:console prog1.obj
	prog1