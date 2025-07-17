#include <iostream>
#include <vector>
using namespace std;

#ifndef flat
#define flat
#endif

#ifdef flat
#define N 3
#endif 


__global__ void vectoradd(int *mat , int *vec , int *res){
    int i = threadIdx.x;
    int sum1 = 0;
    for (int j =0 ; j<N ; j++){
        sum1 += mat[i*N + j] * vec[j];

    }

    res[i] = sum1;

}



int main(int argc , char **argv){
    int vec[N];
    int mat[N*N];
    int res[N];
    int sum1 = 1;
    int prevsum1 = sum1;
    for (int i=0 ; i<N ; i++){
        vec[i] = i;

    }

    for (int i=0; i<N*N ; i++){
        mat[i] = sum1;
        sum1 = sum1 + prevsum1;
        prevsum1 = mat[i];
    }

    int *d_vec , *d_mat; // *d_vec is a pointer in host(cpu) whose address in cpu itself
    int*d_res;
    // a pointer has two things 1) its own address 2) address which its pointing

    cudaMalloc(&d_mat ,N*N*sizeof(int)); // now we give the address of the pointer to store the address of allocated space in gpu
    cudaMalloc(&d_vec ,N*sizeof(int));
    cudaMalloc(&d_res , N*sizeof(int));

    cudaMemcpy(d_mat , mat , N*N*sizeof(int) , cudaMemcpyHostToDevice);
    cudaMemcpy(d_vec , vec , N*sizeof(int) , cudaMemcpyHostToDevice);

    vectoradd<<<1,N>>>(d_mat , d_vec , d_res);

    cudaMemcpy(res , d_res , N*sizeof(int) , cudaMemcpyDeviceToHost);

    for (auto i : res){
        cout<< i << endl;
    }

}
