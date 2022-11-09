opcode breakSampler, aa, ikiiiio
	iAmplitude, kPitch, iStartBeat, iSampleLength, iSampleLengthInBeats, iSampleL, iSampleR xin

  iLengthOfBeat = iSampleLength / iSampleLengthInBeats
  iBreakBPM = 60 / iLengthOfBeat

  aAmplitudeEnvelope = madsr:a(.005, .01, 1, .01) * iAmplitude
  kPitch *= 1 / iSampleLength * gkBPM / iBreakBPM
  iStartTime = iStartBeat / iSampleLengthInBeats

  if iSampleR != 0 then
    aSampleR poscil aAmplitudeEnvelope, kPitch, iSampleR, iStartTime
    aSampleL poscil aAmplitudeEnvelope, kPitch, iSampleL, iStartTime
  else
    aSampleL poscil aAmplitudeEnvelope, kPitch, iSampleL, iStartTime
    aSampleR = aSampleL
  endif

  xout aSampleL, aSampleR
endop
