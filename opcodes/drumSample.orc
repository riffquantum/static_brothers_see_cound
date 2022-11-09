opcode drumSample, aa, iikopj
  iSampleTable, iVelocity, kPitch, iShouldRespectP3, iVelocityCurveDegree, iReleaseTime xin

  iAmplitude = velocityToAmplitude(iVelocity, iVelocityCurveDegree)
  kPitch = kPitch == 0 ? 1 : kPitch
  iReleaseTime = iReleaseTime == -1 ? 0.01 : iReleaseTime

  iSampleLength = nsamp(iSampleTable) / sr

  if iShouldRespectP3 == 0 then
    xtratim limit(iSampleLength / i(kPitch) - p3, 0, 100)
    kAmplitudeEnvelope linseg iAmplitude, iSampleLength/i(kPitch), iAmplitude
  else
    kAmplitudeEnvelope linsegr iAmplitude, iSampleLength/i(kPitch), iAmplitude, iReleaseTime, 0
  endif

  if ftchnls(iSampleTable) == 1 then
    aSampleL loscil kAmplitudeEnvelope, kPitch, iSampleTable, 1, 0
    aSampleR = aSampleL
  else
    aSampleL, aSampleR loscil kAmplitudeEnvelope, kPitch, iSampleTable, 1, 0
  endif

  xout aSampleL, aSampleR
endop
