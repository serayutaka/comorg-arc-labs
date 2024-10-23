#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<unistd.h>

// Structure to hold thread data
struct thread_data {
    int thread_id;
    int sleep_duration;
    char task_name;
};

pthread_mutex_t lock;

void* task(void* arg) {
    struct thread_data *data = (struct thread_data*) arg;
    int thread_id = data->thread_id;
    int sleep_duration = data->sleep_duration;
    char task_name = data->task_name;
    // My code
    for (int i = 0; i < 5; i++) {
        sleep(sleep_duration);
        printf("Thread %d: Task %c - Iteration %d\n", thread_id, task_name, i);
    }
}

int main(void) {
    pthread_t th[3];
    struct thread_data data1, data2, data3;
    
    // Thread 1 data
    data1.thread_id = 1;
    data1.sleep_duration = 1;
    data1.task_name = 'A';

    // Thread 2 data
    data2.thread_id = 2;
    data2.sleep_duration = 2;
    data2.task_name = 'B';

    // Thread 3 data
    data3.thread_id = 3;
    data3.sleep_duration = 3;
    data3.task_name = 'C';

    pthread_create(&th[0], NULL, task, &data1);
    pthread_create(&th[1], NULL, task, &data2);
    pthread_create(&th[2], NULL, task, &data3);
    
    pthread_join(th[0], NULL);
    pthread_join(th[1], NULL);
    pthread_join(th[2], NULL);

    printf("All threads have completed their task!\n");

    return 0;
}