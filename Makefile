.PHONY: all clean

all:
	nasm -g -f elf64 -o bin/main.o main.s
	ld -o bin/main bin/main.o

clean:
	rm -rf bin/*
