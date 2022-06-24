#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
int main(int argc, char* argv[])
{
    MPI_Init(&argc, &argv);
    int my_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    printf("I am MPI process %d.\n", my_rank);
    MPI_Finalize();
    return EXIT_SUCCESS;
}
