#include <iostream>
#include <cstdlib>

using namespace std;
#define mask_len 7



__constant__ int Mask[mask_len];


__global__ void convolution(int* input , int* output , int N){

    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    int radius = mask_len / 2;
    int start = tid - radius;
    int temp = 0;
    for (int i =0 ; i< mask_len ; i++){
        if ((start + i >= 0 ) && (start + i < N)){
            temp += input[start+i] * Mask[i];

        }
    }

    output[tid] = temp;
}


void init_arr(int *a , int N){

    for (int i = 0 ; i<N ; i++){
        a[i] = rand() % 100;
    }
}

int main(int argc , char **argv){
    int N = 1 << 20;
    int bytes = N * sizeof(int);
    int bytes_m = mask_len * sizeof(int);
    int* out = new int[N];
    int* inp = new int[N];
    int mask[mask_len];
    int *input , *output;

    //allocate space in GPU

    cudaMalloc(&input , bytes);
    cudaMalloc(&output , bytes);

    init_arr(inp , N);
    init_arr(mask , mask_len);

    cudaMemcpyToSymbol(Mask , mask , bytes_m);
    cudaMemcpy(input , inp , bytes , cudaMemcpyHostToDevice);


    int threads = 512;
    int blocks = (N + threads -1 )/threads;

    convolution<<< blocks , threads >>>(input , output , N);
    cudaDeviceSynchronize();


    cudaMemcpy(out , output , bytes , cudaMemcpyDeviceToHost);
    

    for (int i=0; i<N; i++){
        cout << out[i] << endl;
    }

    delete[] out;
    delete[] inp;

}

