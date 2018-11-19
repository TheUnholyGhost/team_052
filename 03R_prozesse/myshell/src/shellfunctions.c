#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "plist.h"
#include "shellfunctions.h"
#include "shellutils.h"

// write your local helper functions here


void read_input(char* const command_line, int size, FILE* stream)
{
    // Write your code here

    // delete the following lines if you are implementing this function
    (void)command_line; //mark command_line used for the compiler
    (void)size;         //mark size used for the compiler
    (void)stream;       //mark stream used for the compiler

}


void execute_command(char* command_line)
{
    // Write your code here

    // delete the following lines if you are implementing this function
    (void)command_line; //mark command_line used for the compiler
}


void collect_defunct_process()
{
    // Write your code here
}
