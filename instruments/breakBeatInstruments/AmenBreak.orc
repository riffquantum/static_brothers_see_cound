instrumentRoute "AmenBreak", "FreezerInput"
alwayson "AmenBreakMixerChannel"

gkAmenBreakEqBass init 1
gkAmenBreakEqMid init 1
gkAmenBreakEqHigh init 1
gkAmenBreakFader init 1
gkAmenBreakPan init 50

gSAmenBreakSamplePath = "instruments/breakBeatInstruments/amenBreak.wav"
giAmenBreakSampleChannels filenchnls gSAmenBreakSamplePath
giAmenBreakSampleLength filelen gSAmenBreakSamplePath

if giAmenBreakSampleChannels = 2 then
  giAmenBreakSampleL ftgen 0, 0, 0, 1, gSAmenBreakSamplePath, 0, 0, 1
  giAmenBreakSampleR ftgen 0, 0, 0, 1, gSAmenBreakSamplePath, 0, 0, 2
else
  giAmenBreakSampleL ftgen 0, 0, 0, 1, gSAmenBreakSamplePath, 0, 0, 0
  giAmenBreakSampleR = 0
endif

instr AmenBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aAmenBreakL, aAmenBreakR breakSampler iAmplitude, kPitch, iStartBeat, giAmenBreakSampleLength, iSampleLengthInBeats, giAmenBreakSampleL, giAmenBreakSampleR

  outleta "OutL", aAmenBreakL
  outleta "OutR", aAmenBreakR
endin

instr AmenBreakBassKnob
  gkAmenBreakEqBass linseg p4, p3, p5
endin

instr AmenBreakMidKnob
  gkAmenBreakEqMid linseg p4, p3, p5
endin

instr AmenBreakHighKnob
  gkAmenBreakEqHigh linseg p4, p3, p5
endin

instr AmenBreakFader
  gkAmenBreakFader linseg p4, p3, p5
endin

instr AmenBreakPan
  gkAmenBreakPan linseg p4, p3, p5
endin

instr AmenBreakMixerChannel
  aAmenBreakL inleta "InL"
  aAmenBreakR inleta "InR"

  aAmenBreakL, aAmenBreakR mixerChannel aAmenBreakL, aAmenBreakR, gkAmenBreakFader, gkAmenBreakPan, gkAmenBreakEqBass, gkAmenBreakEqMid, gkAmenBreakEqHigh

  outleta "OutL", aAmenBreakL
  outleta "OutR", aAmenBreakR
endin

