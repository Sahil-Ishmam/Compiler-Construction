CC = gcc
CFLAGS = -I.
DEPS = Additionmake.h
OBJS = Additionmake.o Additionfunc.o

all:
	gcc -o Addition Addition.c
	gcc -E Addition.c > Addition.i 
	gcc -S -masm=intel Addition.i
	as -o Addition.o Addition.s
	objdump -M intel -d Addition.o > Addition.dump
	gcc -c -o Addition.o Addition.c
	objdump -M intel -d Addition.o > Addition2.dump

Additionmake: Additionmake.c Additionfunc.c
	gcc -o Additionmake Additionmake.c Additionfunc.c -I.

Additionmake2: Additionmake.o Additionfunc.o
	$(CC) -o Additionmake Additionmake.o Additionfunc.o $(CFLAGS)

# Additionmake.o: Additionmake.c
# 	gcc -c -o Additionmake.o Additionmake.c -I.

# Additionfunc.o: Additionfunc.c
# 	gcc -c -o Additionfunc.o Additionfunc.c -I.

Additionmake3: $(OBJS)
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