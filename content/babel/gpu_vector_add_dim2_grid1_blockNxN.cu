#include <stdio.h>
#include <cuda.h>
#include <assert.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>
#define N 512
__global__ void add(int *a, int *b, int *c){
  int tid = threadIdx.x + threadIdx.y*blockDim.x + blockDim.x*blockDim.y*blockIdx.x; 
  if(tid < N)
    c[tid] = a[tid] + b[tid];
}
int main()
{
  int a[N], b[N], c[N], i;
  int *dev_a, *dev_b, *dev_c;
  cudaMalloc((void**)&dev_c, N*sizeof(int));
  cudaMalloc((void**)&dev_b, N*sizeof(int));
  cudaMalloc((void**)&dev_a, N*sizeof(int));
  for(i=0; i < N; i++)
    {
      a[i] = 1;
      b[i] = 2;
    }
  cudaMemcpy(dev_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, N*sizeof(int), cudaMemcpyHostToDevice);
  dim3 BlockPerGrid(1, 1, 1);
  dim3 ThreadsPerBlock(128, 4, 1);
  add <<< BlockPerGrid, ThreadsPerBlock >>>(dev_a, dev_b, dev_c);
  cudaMemcpy(c, dev_c, N*sizeof(int), cudaMemcpyDeviceToHost);
  for(i=0; i < N; i++){
    assert(a[i] + b[i] == c[i]);
  }
  printf("Passed\n");
  cudaFree(dev_c);
  cudaFree(dev_b);
  cudaFree(dev_a);
  return 0;
}
