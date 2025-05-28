CC = gcc
CFLAGS = -I.
DEPS = Divisionmake.h
OBJS = Divisionmake.o Divisionfunc.o

all:
	gcc -o Division Division.c
	gcc -E Division.c > Division.i 
	gcc -S -masm=intel Division.i
	as -o Division.o Division.s
	objdump -M intel -d Division.o > Division.dump
	gcc -c -o Division.o Division.c
	objdump -M intel -d Division.o > Division2.dump

Divisionmake: Divisionmake.c Divisionfunc.c
	gcc -o Divisionmake Divisionmake.c Divisionfunc.c -I.

Divisionmake2: Divisionmake.o Divisionfunc.o
	$(CC) -o Divisionmake Divisionmake.o Divisionfunc.o $(CFLAGS)

# Divisionmake.o: Divisionmake.c
# 	gcc -c -o Divisionmake.o Divisionmake.c -I.

# Divisionfunc.o: Divisionfunc.c
# 	gcc -c -o Divisionfunc.o Divisionfunc.c -I.

Divisionmake3: $(OBJS)
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