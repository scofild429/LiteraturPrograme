#include <stdio.h>
#include <cuda.h>
#include <assert.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>
#define N 32
__global__ void add(
                    int *dthreadIdx_x,
                    int *dthreadIdx_y,
                    int *dthreadIdx_z,
                    int *dblockIdx_x,
                    int *dblockIdx_y,
                    int *dblockIdx_z,
                    int *dblockDim_x,
                    int *dblockDim_y,
                    int *dblockDim_z,
                    int *dgridDim_x,
                    int *dgridDim_y,
                    int *dgridDim_z){
  *dthreadIdx_x = threadIdx.x;
  *dthreadIdx_y = threadIdx.y;
  *dthreadIdx_z = threadIdx.z;
  *dblockIdx_x = blockIdx.x;
  *dblockIdx_y = blockIdx.y;
  *dblockIdx_z = blockIdx.z;
  *dblockDim_x = blockDim.x;
  *dblockDim_y = blockDim.y;
  *dblockDim_z = blockDim.z;
  *dgridDim_x = gridDim.x;
  *dgridDim_y = gridDim.y;
  *dgridDim_z = gridDim.z;
}
int main()
{
  int threadIdx_x = 0;
  int threadIdx_y = 0;
  int threadIdx_z = 0;
  int blockIdx_x = 0;
  int blockIdx_y = 0;
  int blockIdx_z = 0;
  int blockDim_x = 0;
  int blockDim_y = 0;
  int blockDim_z = 0;
  int gridDim_x = 0;
  int gridDim_y = 0;
  int gridDim_z = 0;

  int *dthreadIdx_x;
  int *dthreadIdx_y;
  int *dthreadIdx_z;
  int *dblockIdx_x;
  int *dblockIdx_y;
  int *dblockIdx_z;
  int *dblockDim_x;
  int *dblockDim_y;
  int *dblockDim_z;
  int *dgridDim_x;
  int *dgridDim_y;
  int *dgridDim_z;

  cudaMalloc((void **)&dthreadIdx_x, sizeof(int));
  cudaMalloc((void **)&dthreadIdx_y, sizeof(int));
  cudaMalloc((void **)&dthreadIdx_z, sizeof(int));
  cudaMalloc((void **)&dblockIdx_x, sizeof(int));
  cudaMalloc((void **)&dblockIdx_y, sizeof(int));
  cudaMalloc((void **)&dblockIdx_z, sizeof(int));
  cudaMalloc((void **)&dblockDim_x, sizeof(int));
  cudaMalloc((void **)&dblockDim_y, sizeof(int));
  cudaMalloc((void **)&dblockDim_z, sizeof(int));
  cudaMalloc((void **)&dgridDim_x, sizeof(int));
  cudaMalloc((void **)&dgridDim_y, sizeof(int));
  cudaMalloc((void **)&dgridDim_z, sizeof(int));

  dim3 BlockPerGrid(1, 1, 1);
  dim3 ThreadsPerBlock(N, N, 1);
  add <<< BlockPerGrid, ThreadsPerBlock >>>(
                                            dthreadIdx_x,
                                            dthreadIdx_y,
                                            dthreadIdx_z,
                                            dblockIdx_x,
                                            dblockIdx_y,
                                            dblockIdx_z,
                                            dblockDim_x,
                                            dblockDim_y,
                                            dblockDim_z,
                                            dgridDim_x,
                                            dgridDim_y,
                                            dgridDim_z
                                            );
  cudaMemcpy(&threadIdx_x,dthreadIdx_x, sizeof(int), cudaMemcpyDeviceToHost);
  printf("threadIdx_x is %d \n", threadIdx_x);
  cudaMemcpy(&threadIdx_y,dthreadIdx_y, sizeof(int), cudaMemcpyDeviceToHost);
  printf("threadIdx_y is %d \n", threadIdx_y);
  cudaMemcpy(&threadIdx_z,dthreadIdx_z, sizeof(int), cudaMemcpyDeviceToHost);
  printf("threadIdx_z is %d \n", threadIdx_z);

  cudaMemcpy(&blockIdx_x, dblockIdx_x, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockIdx_x is %d \n", blockIdx_x);
  cudaMemcpy(&blockIdx_y, dblockIdx_y, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockIdx_y is %d \n", blockIdx_y);
  cudaMemcpy(&blockIdx_z, dblockIdx_z, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockIdx_z is %d \n", blockIdx_z);


  cudaMemcpy(&blockDim_x, dblockDim_x, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockDim_x is %d \n", blockDim_x);
  cudaMemcpy(&blockDim_y, dblockDim_y, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockDim_y is %d \n", blockDim_y);
  cudaMemcpy(&blockDim_z, dblockDim_z, sizeof(int), cudaMemcpyDeviceToHost);
  printf("blockDim_z is %d \n", blockDim_z);

  cudaMemcpy(&gridDim_x, dgridDim_x, sizeof(int), cudaMemcpyDeviceToHost);
  printf("gridDim_x is %d \n", gridDim_x);
  cudaMemcpy(&gridDim_y, dgridDim_y, sizeof(int), cudaMemcpyDeviceToHost);
  printf("gridDim_y is %d \n", gridDim_y);
  cudaMemcpy(&gridDim_z, dgridDim_z, sizeof(int), cudaMemcpyDeviceToHost);
  printf("gridDim_z is %d \n", gridDim_z);

  return 0;
}
