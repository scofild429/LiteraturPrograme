from mpi4py import MPI
import numpy
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
if rank == 0:
 data = numpy.arange(100, dtype=numpy.float)
 comm.Send(data,dest=1,tag=11)
elif rank == 1:
 data = numpy.empty(100,dtype=numpy.float)
 comm.Recv(data, source=0,tag=11)
 print(data)
