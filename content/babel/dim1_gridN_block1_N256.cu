#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <curand_kernel.h>
#define N 512
__global__ void add(int *a, int *b, int *c){
  int tid = threadIdx.x; // handle the data at this index
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
      a[i] = -i;
      b[i] = i*i*i;
    }
  cudaMemcpy(dev_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, N*sizeof(int), cudaMemcpyHostToDevice);
  add <<<1, N>>>(dev_a, dev_b, dev_c);
  cudaMemcpy(c, dev_c, N*sizeof(int), cudaMemcpyDeviceToHost);
  for(i=0; i < N; i++)
    printf("%d + %d = %d\n", a[i], b[i], c[i]);
  cudaFree(dev_c);
  cudaFree(dev_b);
  cudaFree(dev_a);
  return 0;
}
