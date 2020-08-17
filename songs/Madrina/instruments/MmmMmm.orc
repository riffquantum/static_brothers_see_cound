instrumentRoute "MmmMmm", "FreezerInput"
alwayson "MmmMmmMixerChannel"

gkMmmMmmEqBass init 1
gkMmmMmmEqMid init 1
gkMmmMmmEqHigh init 1
gkMmmMmmFader init 1
gkMmmMmmPan init 50

gSMmmMmmSamplePath = "localSamples/Lifestyle - This Dream/MmmMmm.wav"
giMmmMmmSampleChannels filenchnls gSMmmMmmSamplePath
giMmmMmmSampleLength filelen gSMmmMmmSamplePath
giMmmMmmSampleLengthInBeats = 4
giMmmMmmLengthOfBeat = giMmmMmmSampleLength / giMmmMmmSampleLengthInBeats
giMmmMmmLengthBPM init 60 /giMmmMmmLengthOfBeat
giMmmMmmLengthOfBeatFactor = i(gkBPM) / giMmmMmmLengthBPM

if giMmmMmmSampleChannels = 2 then
  giMmmMmmSampleL ftgen 0, 0, 0, 1, gSMmmMmmSamplePath, 0, 0, 1
  giMmmMmmSampleR ftgen 0, 0, 0, 1, gSMmmMmmSamplePath, 0, 0, 2
else
  giMmmMmmSample ftgen 0, 0, 0, 1, gSMmmMmmSamplePath, 0, 0, 0
endif

instr MmmMmm
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giMmmMmmSampleLength * p5 * giMmmMmmLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giMmmMmmSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giMmmMmmSampleLengthInBeats

  if giMmmMmmSampleChannels = 2 then
    aMmmMmmR poscil kAmplitudeEnvelope, kPitch, giMmmMmmSampleR, iStartTime
    aMmmMmmL poscil kAmplitudeEnvelope, kPitch, giMmmMmmSampleL, iStartTime
  else
    aMmmMmmL poscil kAmplitudeEnvelope, kPitch, giMmmMmmSample, iStartTime
    aMmmMmmR = aMmmMmmL
  endif

  outleta "OutL", aMmmMmmL
  outleta "OutR", aMmmMmmR
endin

instr MmmMmmBassKnob
  gkMmmMmmEqBass linseg p4, p3, p5
endin

instr MmmMmmMidKnob
  gkMmmMmmEqMid linseg p4, p3, p5
endin

instr MmmMmmHighKnob
  gkMmmMmmEqHigh linseg p4, p3, p5
endin

instr MmmMmmFader
  gkMmmMmmFader linseg p4, p3, p5
endin

instr MmmMmmPan
  gkMmmMmmPan linseg p4, p3, p5
endin

instr MmmMmmMixerChannel
  aMmmMmmL inleta "InL"
  aMmmMmmR inleta "InR"

  aMmmMmmL, aMmmMmmR mixerChannel aMmmMmmL, aMmmMmmR, gkMmmMmmFader, gkMmmMmmPan, gkMmmMmmEqBass, gkMmmMmmEqMid, gkMmmMmmEqHigh

  outleta "OutL", aMmmMmmL
  outleta "OutR", aMmmMmmR
endin

