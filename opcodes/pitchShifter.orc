;;Based on an example written by joachim heintz 2009 -- http://www.csounds.com/manual/html/pvscale.html
opcode pitchShifter, a, akkk
  aIn, kPitchScale, kKeepForm, kGain xin
  iFFTSize = 2^11
  iOverlap = iFFTSize / 50
  iWindowsize = iFFTSize
  iWindowShape = 1; von-Hann window

  fftin   pvsanal aIn, iFFTSize, iOverlap, iWindowsize, iWindowShape; fft-analysis of the audio-signal
  fftblur pvscale fftin, kPitchScale, kKeepForm, kGain
  aOut    pvsynth fftblur; resynthesis

  xout     aOut
endop

opcode pitchShifter2, a, akk
  aIn, kPitchScale, kTime xin

  fSignal pvsanal aIn, 1024, 256, 1024, 1
  fShift pvshift fSignal, kPitchScale * 440, 0
  aOut pvsynth fShift

  aOut = vdelay3(aOut, kTime * kPitchScale, 512)

  xout aOut
endop

; opcode pitchShifter2, a, a
;   aIn xin


;   ilock  =  1
;   itab ftgen 0, 0, (0.25 * sr), 2, 0
;   recordBuffer itab, aIn
;   ipitch =  0.9
;   iamp   =  1
;   ktime  = 1
;   ; https://csound.com/docs/manual/temposcal.html
;   aOut temposcal ktime, iamp, ipitch, itab, ilock

;   xout aOut
; endop


; opcode pitchShifter4, a, akki
; ; https://github.com/csudo/csudo/blob/master/misc/DelTp.csd
;  aSnd, kPitch, kDelTim, iMaxDel xin

;  iEnvTable = ftgen(0,0,4096,9,.5,1,0)
;  kPhasorFreq = -(kPitch-1) / kDelTim
;  aPhasor_1 = phasor:a(kPhasorFreq)
;  aPhasor_2 = (aPhasor_1+0.5) % 1
;  aDelay_1 = vdelayx(aSnd,aPhasor_1*kDelTim,iMaxDel,4)
;  aDelay_2 = vdelayx(aSnd,aPhasor_2*kDelTim,iMaxDel,4)
;  aDelay_1 *= tablei:a(aPhasor_1,iEnvTable,1)
;  aDelay_2 *= tablei:a(aPhasor_2,iEnvTable,1)

;  xout aDelay_1+aDelay_2
; endop


