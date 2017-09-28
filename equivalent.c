/* c equivalent of assembly code */
#include <stdio.h>

void hello(void) {
    char *output = "hi!\n";
    printf("%s", output);
}

int main(void) {
    for (int i = 0; i < 10; i++) {
        hello();
    }

    return 0;
}
