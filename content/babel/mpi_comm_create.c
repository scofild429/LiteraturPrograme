#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char* argv[])
{
  MPI_Init(&argc, &argv);
  printf("\n");

  // Check that the application is run with 6 processes.
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  if(size != 6)
    {
      printf("Please run this application with 6 MPI processes.\n");
      MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

  // Get my rank in the global communicator
  int my_rank_global;
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank_global);

  // Get the group or processes of the default communicator
  MPI_Group world_group;
  MPI_Comm_group(MPI_COMM_WORLD, &world_group);

  // Create the new communicator from that group of processes.
  MPI_Comm local_communicator;

  if(my_rank_global == 0 ||
     my_rank_global == 1 ||
     my_rank_global == 2)
    {
      // Keep MPI processes 0, 1, 2 in a group we will call group A.
      int group_a_ranks[3] = {0, 1, 2};
      MPI_Group group_a;
      MPI_Group_incl(world_group, 3, group_a_ranks, &group_a);
      MPI_Comm_create(MPI_COMM_WORLD, group_a, &local_communicator);
    }
  else if(my_rank_global == 3 ||
          my_rank_global == 4)
    {
      // Keep MPI processes 3 and 4 in a group we will call group B.
      int group_b_ranks[2] = {3, 4};
      MPI_Group group_b;
      MPI_Group_incl(world_group, 2, group_b_ranks, &group_b);
      MPI_Comm_create(MPI_COMM_WORLD, group_b, &local_communicator);
    }
  else
    {
      // Only MPI process 5 remains, without a group
      MPI_Comm_create(MPI_COMM_WORLD, MPI_GROUP_EMPTY, &local_communicator);
    }

  // Check if I got into a new communicator (that is, if I was in a group to begin with)
  if(local_communicator == MPI_COMM_NULL)
    {
      // I am not part of the new communicator, I can't participate to that broadcast.
      printf("MPI process %d was not part of any group, thus did not get into a new communicator.\n", my_rank_global);

      // Let's wait all processes before proceeding to the second phase; Cleaner output.
      MPI_Barrier(MPI_COMM_WORLD);
    }
  else
    {
      // Get my rank local to the new communicator
      int my_rank_local;
      MPI_Comm_rank(local_communicator, &my_rank_local);

      printf("MPI process %d in global communicator has now rank %d in new communicator.\n", my_rank_global, my_rank_local);

      // Let's wait all processes before proceeding to the second phase; Cleaner output.
      MPI_Barrier(MPI_COMM_WORLD);

      int size_local_communicator;
      MPI_Comm_size(local_communicator, &size_local_communicator);

      // The MPI process that got assigned rank 0 in each new communicator will gather all ranks in that communicator and display them
      int global_ranks_in_local_communicator[size_local_communicator];
      MPI_Gather(&my_rank_global,
                 1,
                 MPI_INT,
                 global_ranks_in_local_communicator,
                 1,
                 MPI_INT,
                 0,
                 local_communicator);

      if(my_rank_local == 0)
        {
          printf("MPI processes ");
          for(int i = 0; i < size_local_communicator; i++)
            {
              if(i > 0)
                {
                  printf(" and ");
                }
              printf("%d", global_ranks_in_local_communicator[i]);
            }
          printf(" are in the same new communicator.\n");
        }
    }

  MPI_Finalize();

  return EXIT_SUCCESS;
}
