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
  float a[N][N], b[N][N], out[N][N];
  float d_a[N][N], d_b[N][N], d_out[N][N]; 

  for(int i = 0; i < N; i++){
    for (int j = 0; j < N; j++){
      a[i][j] = 1.0f;
      b[i][j] = 2.0f;
    }
  }

  // Allocate device memory 
  cudaMalloc((void**)&d_a, sizeof(float) * N *N);
  cudaMalloc((void**)&d_b, sizeof(float) * N * N);
  cudaMalloc((void**)&d_out, sizeof(float) * N * N);

  // Transfer data from host to device memory
  cudaMemcpy(d_a, a, sizeof(float) * N * N, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, sizeof(float) * N * N, cudaMemcpyHostToDevice);

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
