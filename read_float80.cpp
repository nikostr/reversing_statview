#include <Rcpp.h>
#include <fstream>
#include <iostream>
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
NumericVector read_float80(int n, int offset, String filename){
    ifstream myFile (filename, ios::in | ios::binary) ;
    myFile.seekg(offset);
    char buffer[10 * n];
    myFile.read(buffer, 10 * n);
    myFile.close();
    char rev_buf[16 * n];
    int j=0;
    // reversing to switch endian-ness
    // resizing to add padding
    for (int i=0;i<16 * n;i++){
        if (i % 16 > 9) {
            continue;
        }
        rev_buf[i] = buffer[10 * n - 1 - j];
        j++;
    }
    long double* ld_buffer = (long double*) rev_buf;
    NumericVector d_buf(n);
    for (int i=0; i<n; i++) {
        d_buf[i] = ld_buffer[n - 1 - i];
    }
    return d_buf;
}
