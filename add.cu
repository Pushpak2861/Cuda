#include <iostream>
#define N 5
using namespace std;



__global__ void addEle(int *x , int *y , int *res){
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    res[i] = x[i] + y[i];
}


int main(int argc , char **argv){
    int a[N] = {1,2,3,4,5};
    int b[N] = {6,7,8,9,10};
    int res[N];

    // create space in gpu
    int *d_x , *d_y , *d_res;
    cudaMalloc(&d_x , N*sizeof(a[0]));
    cudaMalloc(&d_y , N*sizeof(int));
    cudaMalloc(&d_res , N*sizeof(int));

    cudaMemcpy(d_x , a , N*sizeof(int) , cudaMemcpyHostToDevice);
    cudaMemcpy(d_y , b , N*sizeof(int) , cudaMemcpyHostToDevice);

    addEle<<<1,N>>>(d_x , d_y , d_res);

    cudaMemcpy(res,d_res ,N*sizeof(int) , cudaMemcpyDeviceToHost);

    for (auto i : res){
        cout<< i << endl;
    }
}