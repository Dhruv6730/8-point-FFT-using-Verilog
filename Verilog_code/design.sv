function void multiply(input real real_a,
                input real imag_a,
                input real real_b,
                input real imag_b,
                output real out_r,
                output real out_i);
  
      out_r = (real_a*real_b) - (imag_a*imag_b);
      out_i = (real_a*imag_b) + (real_b*imag_a);

endfunction

module fft_8(input real inp_real[0:7],
             input real inp_imag[0:7],
             output real out_real[0:7],
             output real out_imag[0:7],
             output real r,
             output real i);
  
  real twiddle_real[0:3] = {1,0.7071,0,-0.7071};
  real twiddle_imag[0:3] = {0,-0.7071,-1,-0.7071};
  
  real X_real[0:7] ;
  real X_imag[0:7];
  real X_real_prev[0:7];
  real X_imag_prev[0:7];
  
  always_comb begin
        
    	// STAGE 1 : 2 Point FFT
    
        X_real[0] = inp_real[0] + inp_real[4];
        X_real[1] = inp_real[0] - inp_real[4];
        X_real[2] = inp_real[2] + inp_real[6];
        X_real[3] = inp_real[2] - inp_real[6];
        X_real[4] = inp_real[1] + inp_real[5];
        X_real[5] = inp_real[1] - inp_real[5];
        X_real[6] = inp_real[3] + inp_real[7];
        X_real[7] = inp_real[3] - inp_real[7];
    
        X_imag[0] = inp_imag[0] + inp_imag[4];
        X_imag[1] = inp_imag[0] - inp_imag[4];
        X_imag[2] = inp_imag[2] + inp_imag[6];
        X_imag[3] = inp_imag[2] - inp_imag[6];
        X_imag[4] = inp_imag[1] + inp_imag[5];
        X_imag[5] = inp_imag[1] - inp_imag[5];
        X_imag[6] = inp_imag[3] + inp_imag[7];
        X_imag[7] = inp_imag[3] - inp_imag[7];
        
        X_real_prev = X_real;
        X_imag_prev = X_imag;

    
    	// STAGE 2 : 4 Point FFT
        
    	multiply(X_real[3], X_imag[3],twiddle_real[2],twiddle_imag[2],X_real_prev[3],X_imag_prev[3]);
        multiply(X_real[7], X_imag[7],twiddle_real[2],twiddle_imag[2],X_real_prev[7],X_imag_prev[7]);
    
       	X_real[0] = X_real_prev[0] + X_real_prev[2];
        X_real[1] = X_real_prev[1] + X_real_prev[3];
        X_real[2] = X_real_prev[0] - X_real_prev[2];
        X_real[3] = X_real_prev[1] - X_real_prev[3];
        X_real[4] = X_real_prev[4] + X_real_prev[6];
        X_real[5] = X_real_prev[5] + X_real_prev[7];
        X_real[6] = X_real_prev[4] - X_real_prev[6];
        X_real[7] = X_real_prev[5] - X_real_prev[7];
        
        X_imag[0] = X_imag_prev[0] + X_imag_prev[2];
        X_imag[1] = X_imag_prev[1] + X_imag_prev[3];
        X_imag[2] = X_imag_prev[0] - X_imag_prev[2];
        X_imag[3] = X_imag_prev[1] - X_imag_prev[3];
        X_imag[4] = X_imag_prev[4] + X_imag_prev[6];
        X_imag[5] = X_imag_prev[5] + X_imag_prev[7];
        X_imag[6] = X_imag_prev[4] - X_imag_prev[6];
        X_imag[7] = X_imag_prev[5] - X_imag_prev[7];
        
        X_real_prev = X_real;
        X_imag_prev = X_imag;
    
    
    	// Stage 3: 8 Point FFT
    
        multiply(X_real[5], X_imag[5],twiddle_real[1],twiddle_imag[1],X_real_prev[5],X_imag_prev[5]);
        multiply(X_real[6], X_imag[6],twiddle_real[2],twiddle_imag[2],X_real_prev[6],X_imag_prev[6]);
        multiply(X_real[7], X_imag[7],twiddle_real[3],twiddle_imag[3],X_real_prev[7],X_imag_prev[7]);
    
        X_real[0] = X_real_prev[0] + X_real_prev[4];
        X_real[1] = X_real_prev[1] + X_real_prev[5];
        X_real[2] = X_real_prev[2] + X_real_prev[6];
        X_real[3] = X_real_prev[3] + X_real_prev[7];
        X_real[4] = X_real_prev[0] - X_real_prev[4];
        X_real[5] = X_real_prev[1] - X_real_prev[5];
        X_real[6] = X_real_prev[2] - X_real_prev[6];
        X_real[7] = X_real_prev[3] - X_real_prev[7];
        
        X_imag[0] = X_imag_prev[0] + X_imag_prev[4];
        X_imag[1] = X_imag_prev[1] + X_imag_prev[5];
        X_imag[2] = X_imag_prev[2] + X_imag_prev[6];
        X_imag[3] = X_imag_prev[3] + X_imag_prev[7];
        X_imag[4] = X_imag_prev[0] - X_imag_prev[4];
        X_imag[5] = X_imag_prev[1] - X_imag_prev[5];
        X_imag[6] = X_imag_prev[2] - X_imag_prev[6];
        X_imag[7] = X_imag_prev[3] - X_imag_prev[7];
      
        out_real = X_real;
        out_imag = X_imag;

  end
endmodule