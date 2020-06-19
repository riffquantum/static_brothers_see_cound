instrumentRoute "RafflesiaBreak", "FreezerInput"
alwayson "RafflesiaBreakMixerChannel"

gkRafflesiaBreakEqBass init 1
gkRafflesiaBreakEqMid init 1
gkRafflesiaBreakEqHigh init 1
gkRafflesiaBreakFader init 1
gkRafflesiaBreakPan init 50

gSRafflesiaBreakSamplePath = "instruments/breakBeatInstruments/rafflesiaBreak.wav"
giRafflesiaBreakSampleChannels filenchnls gSRafflesiaBreakSamplePath
giRafflesiaBreakSampleLength filelen gSRafflesiaBreakSamplePath

if giRafflesiaBreakSampleChannels = 2 then
  giRafflesiaBreakSampleL ftgen 0, 0, 0, 1, gSRafflesiaBreakSamplePath, 0, 0, 1
  giRafflesiaBreakSampleR ftgen 0, 0, 0, 1, gSRafflesiaBreakSamplePath, 0, 0, 2
else
  giRafflesiaBreakSampleL ftgen 0, 0, 0, 1, gSRafflesiaBreakSamplePath, 0, 0, 0
  giRafflesiaBreakSampleR = 0
endif

instr RafflesiaBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 4

  aRafflesiaBreakL, aRafflesiaBreakR breakSampler iAmplitude, kPitch, iStartBeat, giRafflesiaBreakSampleLength, iSampleLengthInBeats, giRafflesiaBreakSampleL, giRafflesiaBreakSampleR

  outleta "OutL", aRafflesiaBreakL
  outleta "OutR", aRafflesiaBreakR
endin

instr RafflesiaBreakBassKnob
  gkRafflesiaBreakEqBass linseg p4, p3, p5
endin

instr RafflesiaBreakMidKnob
  gkRafflesiaBreakEqMid linseg p4, p3, p5
endin

instr RafflesiaBreakHighKnob
  gkRafflesiaBreakEqHigh linseg p4, p3, p5
endin

instr RafflesiaBreakFader
  gkRafflesiaBreakFader linseg p4, p3, p5
endin

instr RafflesiaBreakPan
  gkRafflesiaBreakPan linseg p4, p3, p5
endin

instr RafflesiaBreakMixerChannel
  aRafflesiaBreakL inleta "InL"
  aRafflesiaBreakR inleta "InR"

  aRafflesiaBreakL, aRafflesiaBreakR mixerChannel aRafflesiaBreakL, aRafflesiaBreakR, gkRafflesiaBreakFader, gkRafflesiaBreakPan, gkRafflesiaBreakEqBass, gkRafflesiaBreakEqMid, gkRafflesiaBreakEqHigh

  outleta "OutL", aRafflesiaBreakL
  outleta "OutR", aRafflesiaBreakR
endin

