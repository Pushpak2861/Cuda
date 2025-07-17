#include <iostream>
using namespace std;

#ifndef matrix
#define matrix
#endif 

#ifdef matrix
#define N 3
#endif


__global__ void matxmat(int *mat1 , int *mat2 , int *res){
    int row = threadIdx.y;
    int col = threadIdx.x;
    int sum1 = 0;

    for (int i =0 ; i<N; i++){
        sum1 += mat1[N * row + i] * mat2[i * N + col];
        
    }
    res[row * N +col] = sum1;
    
}

int main(int argc , char **argv){
    int mat1[N*N] = {1,2,3,4,5,6,7,8,9};
    int mat2[N*N] = {10,11,12,13,14,15,16,17,18};
    int res[N*N];

    int *d_mat1 , *d_mat2 , *d_res;

    cudaMalloc(&d_mat1 , N*N*(sizeof(int)));
    cudaMalloc(&d_mat2 , N*N*(sizeof(int)));
    cudaMalloc(&d_res , N*N*(sizeof(int)));

    cudaMemcpy(d_mat1 , mat1 , N*N*(sizeof(int)) , cudaMemcpyHostToDevice);
    cudaMemcpy(d_mat2 , mat2 , N*N*(sizeof(int)) , cudaMemcpyHostToDevice);

    dim3 blockDim(3,3);
    matxmat<<<1 , blockDim>>>(d_mat1 , d_mat2 , d_res);

    cudaMemcpy(res , d_res , N*N*sizeof(int) , cudaMemcpyDeviceToHost);

    for (auto result : res){
        cout << result << endl;
    }

}