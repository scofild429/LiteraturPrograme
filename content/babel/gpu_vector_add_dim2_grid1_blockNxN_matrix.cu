#include <stdio.h>
#include <cuda.h>
#include <assert.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>
#define n 32
#define N n*n
__global__ void add(float *a, float *b, float *c){
  __shared__ float A[n][n];
  __shared__ float B[n][n];
  __shared__ float C[n][n];
  int tidx = threadIdx.x;
  int tidy = threadIdx.y;

  A[tidy][tidx] = a[tidx +n*tidy];
  B[tidy][tidx] = b[tidx +n*tidy];

  C[tidy][tidx]= A[tidy][tidx] + B[tidy][tidx];

  c[tidx +n*tidy] = C[tidy][tidx];
}
int main()
{
  float a[N], b[N], out[N];
  float *d_a, *d_b, *d_out; 

  for(int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      a[i+j*n] = 1.0f + i;
      b[i+j*n] = 1.0f + i;
    }
  }

  // Allocate device memory 
  cudaMalloc((void**)&d_a, sizeof(float) * N);
  cudaMalloc((void**)&d_b, sizeof(float) * N);
  cudaMalloc((void**)&d_out, sizeof(float) * N);

  // Transfer data from host to device memory
  cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);

  dim3 BlockPerGrid(1, 1, 1);
  dim3 ThreadsPerBlock(n, n, 1);
  add <<< BlockPerGrid, ThreadsPerBlock >>>(d_a, d_b, d_out);
  cudaMemcpy(out, d_out, sizeof(int) * N, cudaMemcpyDeviceToHost);
  for(int i=0; i < N; i++){
    printf("a[%d] + b[%d] == out[%d] is %f + %f = %f\n", i,i,i, a[i], b[i], out[i]);
  }
  printf("Passed\n");
  cudaFree(d_out);
  cudaFree(d_b);
  cudaFree(d_a);
  return 0;
}
