#include <Rcpp.h>
//#include <boost/numeric/conversion/cast.hpp>
//#include <boost/cstdfloat.hpp> 
//#include <bit>
#include <fstream>
#include <iostream>
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
NumericVector read_float10(int n, int offset, String filename){
    //ifstream myFile ("MEP PARA AND PLUM", ios::in | ios::binary) ;
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
    //boost::float80_t* ld_buffer = (boost::float80_t*) rev_buf;
    long double* ld_buffer = (long double*) rev_buf;
    //cout << "ldbuffer size: " << sizeof(ld_buffer) << "\n";
    //cout << "buffer size: "<< sizeof(buffer) << "\n";
    //for (int i=0; i<2; i++) {
    //    cout << ld_buffer[i] << "\n";
    //}
    NumericVector d_buf(n);
    for (int i=0; i<n; i++) {
        //d_buf[i] = static_cast<double>(ld_buffer[n - 1 - i]);
        d_buf[i] = ld_buffer[n - 1 - i];
    }
    //cout << "printing all\n";
    //for (int i=0; i<113; i++) {
    //    cout << d_buf[i] << "\n";
    //}
    //cout << "d_buf size: " << sizeof(d_buf) << "\n";
    //cout << "d_buf[0] size: " << sizeof(d_buf[0]) << "\n";

    return d_buf;
}


int main() {
    read_float10(113, 14226, "MEP PARA AND PLUM");
    return 0;
}
