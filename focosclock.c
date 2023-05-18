#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main() {
    while (1) {
        time_t currentTime = time(NULL);
        struct tm *localTime = localtime(&currentTime);
        printf("%02d:%02d:%02d\n", localTime->tm_hour, localTime->tm_min, localTime->tm_sec);
        sleep(1);
    }
    
    return 0;
}
