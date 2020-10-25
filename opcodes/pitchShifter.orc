;;Based on an example written by joachim heintz 2009 -- http://www.csounds.com/manual/html/pvscale.html
opcode pitchShifter, a, akkk
  aIn, kPitchScale, kKeepForm, kGain xin
  iFFTSize    =       2^9
  iOverlap    =       iFFTSize / 4
  iWindowsize    =       iFFTSize
  iWindowShape   =       0; von-Hann window

  fftin   pvsanal aIn, iFFTSize, iOverlap, iWindowsize, iWindowShape; fft-analysis of the audio-signal
  fftblur pvscale fftin, kPitchScale, kKeepForm, kGain
  aout    pvsynth fftblur; resynthesis

  xout     aout
endop
