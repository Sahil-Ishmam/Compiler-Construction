CC = gcc
CFLAGS = -I.
DEPS = Subtrationmake.h
OBJS = Subtrationmake.o Subtrationfunc.o

all:
	gcc -o Subtration Subtration.c
	gcc -E Subtration.c > Subtration.i 
	gcc -S -masm=intel Subtration.i
	as -o Subtration.o Subtration.s
	objdump -M intel -d Subtration.o > Subtration.dump
	gcc -c -o Subtration.o Subtration.c
	objdump -M intel -d Subtration.o > Subtration2.dump

Subtrationmake: Subtrationmake.c Subtrationfunc.c
	gcc -o Subtrationmake Subtrationmake.c Subtrationfunc.c -I.

Subtrationmake2: Subtrationmake.o Subtrationfunc.o
	$(CC) -o Subtrationmake Subtrationmake.o Subtrationfunc.o $(CFLAGS)

# Subtrationmake.o: Subtrationmake.c
# 	gcc -c -o Subtrationmake.o Subtrationmake.c -I.

# Subtrationfunc.o: Subtrationfunc.c
# 	gcc -c -o Subtrationfunc.o Subtrationfunc.c -I.

Subtrationmake3: $(OBJS)
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