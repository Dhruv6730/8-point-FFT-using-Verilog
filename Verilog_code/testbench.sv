module fft_tb;
  real inp_real[0:7] = {1,2,3,4,5,6,7,8};
  real inp_imag[0:7] = {0,0,0,0,0,0,0,0};
  real out_real[0:7];
  real out_imag[0:7];
  real r,i;
  
  fft_8 DUT(.*);
  
  initial begin
    #5;
    $display("--------------");
    $display("INPUT SEQUENCE ");
    $display("--------------");
    $display("%0f + j%0f",inp_real[0], inp_imag[0]);
    $display("%0f + j%0f",inp_real[1], inp_imag[1]);
    $display("%0f + j%0f",inp_real[2], inp_imag[2]);
    $display("%0f + j%0f",inp_real[3], inp_imag[3]);
    $display("%0f + j%0f",inp_real[4], inp_imag[4]);
    $display("%0f + j%0f",inp_real[5], inp_imag[5]);
    $display("%0f + j%0f",inp_real[6], inp_imag[6]);
    $display("%0f + j%0f",inp_real[7], inp_imag[7]);
    $display("------------");
    $display("------------");
    $display("OUTPUT ");
    $display("------------");
    $display("%0f + j%0f",out_real[0], out_imag[0]);
    $display("%0f + j%0f",out_real[1], out_imag[1]);
    $display("%0f + j%0f",out_real[2], out_imag[2]);
    $display("%0f + j%0f",out_real[3], out_imag[3]);
    $display("%0f + j%0f",out_real[4], out_imag[4]);
    $display("%0f + j%0f",out_real[5], out_imag[5]);
    $display("%0f + j%0f",out_real[6], out_imag[6]);
    $display("%0f + j%0f",out_real[7], out_imag[7]);
    $display("------------");
    
    $finish(1);
  end
  
  initial begin
    $dumpfile("fft.vcd");
    $dumpvars(2,fft_tb);
  end
endmodule