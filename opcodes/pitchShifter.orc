;;Based on an example written by joachim heintz 2009 -- http://www.csounds.com/manual/html/pvscale.html
opcode pitchShifter, a, akkk
  ain, kpitchScale, kkeepform, kgain xin
  ifftsize    =       1024
  ioverlap    =       ifftsize / 4
  iwinsize    =       ifftsize
  iwinshape   =       1; von-Hann window

  fftin   pvsanal ain, ifftsize, ioverlap, iwinsize, iwinshape; fft-analysis of the audio-signal
  fftblur pvscale fftin, kpitchScale, kkeepform, kgain
  aout    pvsynth fftblur; resynthesis

  xout     aout
endop
