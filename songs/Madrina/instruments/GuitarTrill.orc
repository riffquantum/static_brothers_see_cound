instrumentRoute "GuitarTrill", "FreezerInput"
alwayson "GuitarTrillMixerChannel"

gkGuitarTrillEqBass init 1
gkGuitarTrillEqMid init 1
gkGuitarTrillEqHigh init 1
gkGuitarTrillFader init 1
gkGuitarTrillPan init 50

gSGuitarTrillSamplePath = "localSamples/Lifestyle - This Dream/GuitarTrill.wav"
giGuitarTrillSampleChannels filenchnls gSGuitarTrillSamplePath
giGuitarTrillSampleLength filelen gSGuitarTrillSamplePath
giGuitarTrillSampleLengthInBeats = 4
giGuitarTrillLengthOfBeat = giGuitarTrillSampleLength / giGuitarTrillSampleLengthInBeats
giGuitarTrillLengthBPM init 60 /giGuitarTrillLengthOfBeat
giGuitarTrillLengthOfBeatFactor = i(gkBPM) / giGuitarTrillLengthBPM

if giGuitarTrillSampleChannels = 2 then
  giGuitarTrillSampleL ftgen 0, 0, 0, 1, gSGuitarTrillSamplePath, 0, 0, 1
  giGuitarTrillSampleR ftgen 0, 0, 0, 1, gSGuitarTrillSamplePath, 0, 0, 2
else
  giGuitarTrillSample ftgen 0, 0, 0, 1, gSGuitarTrillSamplePath, 0, 0, 0
endif

instr GuitarTrill
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giGuitarTrillSampleLength * p5 * giGuitarTrillLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giGuitarTrillSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giGuitarTrillSampleLengthInBeats

  if giGuitarTrillSampleChannels = 2 then
    aGuitarTrillR poscil kAmplitudeEnvelope, kPitch, giGuitarTrillSampleR, iStartTime
    aGuitarTrillL poscil kAmplitudeEnvelope, kPitch, giGuitarTrillSampleL, iStartTime
  else
    aGuitarTrillL poscil kAmplitudeEnvelope, kPitch, giGuitarTrillSample, iStartTime
    aGuitarTrillR = aGuitarTrillL
  endif

  outleta "OutL", aGuitarTrillL
  outleta "OutR", aGuitarTrillR
endin

instr GuitarTrillBassKnob
  gkGuitarTrillEqBass linseg p4, p3, p5
endin

instr GuitarTrillMidKnob
  gkGuitarTrillEqMid linseg p4, p3, p5
endin

instr GuitarTrillHighKnob
  gkGuitarTrillEqHigh linseg p4, p3, p5
endin

instr GuitarTrillFader
  gkGuitarTrillFader linseg p4, p3, p5
endin

instr GuitarTrillPan
  gkGuitarTrillPan linseg p4, p3, p5
endin

instr GuitarTrillMixerChannel
  aGuitarTrillL inleta "InL"
  aGuitarTrillR inleta "InR"

  aGuitarTrillL, aGuitarTrillR mixerChannel aGuitarTrillL, aGuitarTrillR, gkGuitarTrillFader, gkGuitarTrillPan, gkGuitarTrillEqBass, gkGuitarTrillEqMid, gkGuitarTrillEqHigh

  outleta "OutL", aGuitarTrillL
  outleta "OutR", aGuitarTrillR
endin

