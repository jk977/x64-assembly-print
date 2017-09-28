SOURCE ?= main.s
DESTINATION ?= out

$(DESTINATION): $(SOURCE)
	nasm -g -f elf64 -o "$(DESTINATION).o" "$(SOURCE)"
	gcc -g -o "$(DESTINATION)" "$(DESTINATION).o"
	rm "$(DESTINATION).o"
