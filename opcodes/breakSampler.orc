opcode breakSampler, aa, ikiiiio
	iAmplitude, kPitch, iStartBeat, iSampleLength, iSampleLengthInBeats, iSampleL, iSampleR xin

  iLengthOfBeat = iSampleLength / iSampleLengthInBeats
  iBreakBPM = 60 / iLengthOfBeat

  kAmplitudeEnvelope madsr .005, .01, iAmplitude, .01
  kPitch *= 1 / iSampleLength * gkBPM / iBreakBPM
  iStartTime = iStartBeat / iSampleLengthInBeats

  if iSampleR != 0 then
    aSampleR poscil kAmplitudeEnvelope, kPitch, iSampleR, iStartTime
    aSampleL poscil kAmplitudeEnvelope, kPitch, iSampleL, iStartTime
  else
    aSampleL poscil kAmplitudeEnvelope, kPitch, iSampleL, iStartTime
    aSampleR = aSampleL
  endif

  xout aSampleL, aSampleR
endop
