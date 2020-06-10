opcode drumSample, aa, iipop
  iSampleTable, iVelocity, iPitch, iShouldPlayWholeSample, iVelocityCurveDegree xin

  iAmplitude = velocityToAmplitude(iVelocity, iVelocityCurveDegree)
  iPitch = iPitch == 0 ? 1 : iPitch
  iReleaseTime = 0.01

  iSampleLength = nsamp(iSampleTable) / sr

  if iShouldPlayWholeSample == 0 then
    xtratim limit(iSampleLength / iPitch - p3, 0, 100)
    kAmplitudeEnvelope linseg iAmplitude, iSampleLength/iPitch, iAmplitude
  else
    kAmplitudeEnvelope linsegr iAmplitude, iSampleLength/iPitch, iAmplitude, iReleaseTime, 0
  endif

  if ftchnls(iSampleTable) == 1 then
    aSampleL loscil kAmplitudeEnvelope, iPitch, iSampleTable, 1, 0
    aSampleR = aSampleL
  else
    aSampleL, aSampleR loscil kAmplitudeEnvelope, iPitch, iSampleTable, 1, 0
  endif

  xout aSampleL, aSampleR
endop
