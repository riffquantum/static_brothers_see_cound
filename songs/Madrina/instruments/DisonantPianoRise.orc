instrumentRoute "DisonantPianoRise", "FreezerInput"
alwayson "DisonantPianoRiseMixerChannel"

gkDisonantPianoRiseEqBass init 1
gkDisonantPianoRiseEqMid init 1
gkDisonantPianoRiseEqHigh init 1
gkDisonantPianoRiseFader init 1
gkDisonantPianoRisePan init 50

gSDisonantPianoRiseSamplePath = "localSamples/Lifestyle - This Dream/DisonantPianoRise.wav"
giDisonantPianoRiseSampleChannels filenchnls gSDisonantPianoRiseSamplePath
giDisonantPianoRiseSampleLength filelen gSDisonantPianoRiseSamplePath
giDisonantPianoRiseSampleLengthInBeats = 4
giDisonantPianoRiseLengthOfBeat = giDisonantPianoRiseSampleLength / giDisonantPianoRiseSampleLengthInBeats
giDisonantPianoRiseLengthBPM init 60 /giDisonantPianoRiseLengthOfBeat
giDisonantPianoRiseLengthOfBeatFactor = i(gkBPM) / giDisonantPianoRiseLengthBPM

if giDisonantPianoRiseSampleChannels = 2 then
  giDisonantPianoRiseSampleL ftgen 0, 0, 0, 1, gSDisonantPianoRiseSamplePath, 0, 0, 1
  giDisonantPianoRiseSampleR ftgen 0, 0, 0, 1, gSDisonantPianoRiseSamplePath, 0, 0, 2
else
  giDisonantPianoRiseSample ftgen 0, 0, 0, 1, gSDisonantPianoRiseSamplePath, 0, 0, 0
endif

instr DisonantPianoRise
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giDisonantPianoRiseSampleLength * p5 * giDisonantPianoRiseLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giDisonantPianoRiseSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giDisonantPianoRiseSampleLengthInBeats

  if giDisonantPianoRiseSampleChannels = 2 then
    aDisonantPianoRiseR poscil kAmplitudeEnvelope, kPitch, giDisonantPianoRiseSampleR, iStartTime
    aDisonantPianoRiseL poscil kAmplitudeEnvelope, kPitch, giDisonantPianoRiseSampleL, iStartTime
  else
    aDisonantPianoRiseL poscil kAmplitudeEnvelope, kPitch, giDisonantPianoRiseSample, iStartTime
    aDisonantPianoRiseR = aDisonantPianoRiseL
  endif

  outleta "OutL", aDisonantPianoRiseL
  outleta "OutR", aDisonantPianoRiseR
endin

instr DisonantPianoRiseBassKnob
  gkDisonantPianoRiseEqBass linseg p4, p3, p5
endin

instr DisonantPianoRiseMidKnob
  gkDisonantPianoRiseEqMid linseg p4, p3, p5
endin

instr DisonantPianoRiseHighKnob
  gkDisonantPianoRiseEqHigh linseg p4, p3, p5
endin

instr DisonantPianoRiseFader
  gkDisonantPianoRiseFader linseg p4, p3, p5
endin

instr DisonantPianoRisePan
  gkDisonantPianoRisePan linseg p4, p3, p5
endin

instr DisonantPianoRiseMixerChannel
  aDisonantPianoRiseL inleta "InL"
  aDisonantPianoRiseR inleta "InR"

  aDisonantPianoRiseL, aDisonantPianoRiseR mixerChannel aDisonantPianoRiseL, aDisonantPianoRiseR, gkDisonantPianoRiseFader, gkDisonantPianoRisePan, gkDisonantPianoRiseEqBass, gkDisonantPianoRiseEqMid, gkDisonantPianoRiseEqHigh

  outleta "OutL", aDisonantPianoRiseL
  outleta "OutR", aDisonantPianoRiseR
endin

