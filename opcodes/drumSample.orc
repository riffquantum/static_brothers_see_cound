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

opcode drumSampleP, aa, ikiopp
  iVelocity, kFrequency, iSampleTableL, iSampleTableR, iShouldRespectP3, iVelocityCurveDegree xin

  print i(kFrequency)

  iAmplitude = velocityToAmplitude(iVelocity, iVelocityCurveDegree)
  kFrequency = kFrequency == 0 ? 261.626 : kFrequency
  kPitch = kFrequency/261.626

  iReleaseTime = 0.01

  iSampleLength = nsamp(iSampleTableL) / sr

  if iShouldRespectP3 == 0 then
    xtratim limit(iSampleLength / i(kPitch) - p3, 0, 100)
    kAmplitudeEnvelope linseg iAmplitude, iSampleLength/i(kPitch), iAmplitude
  else
    kAmplitudeEnvelope linsegr iAmplitude, iSampleLength/i(kPitch), iAmplitude, iReleaseTime, 0
  endif

  if iSampleTableR != 0 then
    aSampleL poscil kAmplitudeEnvelope, 1/iSampleLength, iSampleTableL, 0
    aSampleR poscil kAmplitudeEnvelope, 1/iSampleLength, iSampleTableR, 0
  else
    aSampleL poscil kAmplitudeEnvelope, 1/iSampleLength, iSampleTableL, 0
    aSampleR = aSampleL
  endif

  xout aSampleL, aSampleR
endop
