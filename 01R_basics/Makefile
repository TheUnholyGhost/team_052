SRC = hello.c
EXEC = helloworld
EXECSHELL = shellutilstest
CC = clang
OBJS = test.o shellutils.o
CFLAGS = -std=c11 -pedantic -Wall -Wextra
DEBUGFLAGS = -g -O0

all:	 $(EXEC) $(EXECSHELL)
$(EXEC): $(SRC)
	$(CC) $(DEBUGFLAGS) $(CFLAGS) $< -o $@
.PHONY: clean all
clean:
	rm -f $(EXEC)
	rm -f *.o
	rm -f $(EXECSHELL)
%.o: %.c
	@echo Kompiliere Datei: $<
	$(CC) -c $(DEBUGFLAGS) $(FLAGS) $< -o $@
$(EXECSHELL): $(OBJS)
	$(CC) $(DEBUGFLAGS) -o $@ $(OBJS)

