;breakSamplerDiskin

opcode breakSamplerDiskin, aa, Siik
	SBreakFilePath, iSegmentLength, iSkipTimeInBeats, kPitchFactor xin

  iFileNumChannels filenchnls SBreakFilePath
  iBreakFileLength filelen SBreakFilePath
  iBreakLengthOfBeat = iBreakFileLength / iSegmentLength
  iBreakBPM init 60 /iBreakLengthOfBeat
  kBreakFactor = gkBPM / iBreakBPM

  if kPitchFactor==0 then
    kPitchFactor = 1
  endif

  kpitch = kBreakFactor * kPitchFactor

  iSkipTime = iBreakLengthOfBeat * iSkipTimeInBeats

  iwraparound = 1
  iformat = 0
  iskipinit = 0

  if iFileNumChannels == 2 then
    aBreakL, aBreakR diskin SBreakFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
  elseif  iFileNumChannels == 1 then
    aBreakL diskin SBreakFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
    aBreakR = aBreakL
  endif

  xout aBreakL, aBreakR
endop
