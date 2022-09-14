instrumentRoute "ThinkBreak", "FreezerInput"
alwayson "ThinkBreakMixerChannel"

gkThinkBreakEqBass init 1
gkThinkBreakEqMid init 1
gkThinkBreakEqHigh init 1
gkThinkBreakFader init 1
gkThinkBreakPan init 50

gSThinkBreakSamplePath = "localSamples/thinkBreak0.wav"
giThinkBreakSampleChannels filenchnls gSThinkBreakSamplePath
giThinkBreakSampleLength filelen gSThinkBreakSamplePath

if giThinkBreakSampleChannels = 2 then
  giThinkBreakSampleL ftgen 0, 0, 0, 1, gSThinkBreakSamplePath, 0, 0, 1
  giThinkBreakSampleR ftgen 0, 0, 0, 1, gSThinkBreakSamplePath, 0, 0, 2
else
  giThinkBreakSampleL ftgen 0, 0, 0, 1, gSThinkBreakSamplePath, 0, 0, 0
  giThinkBreakSampleR = 0
endif

instr ThinkBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 4

  aThinkBreakL, aThinkBreakR breakSampler iAmplitude, kPitch, iStartBeat, giThinkBreakSampleLength, iSampleLengthInBeats, giThinkBreakSampleL, giThinkBreakSampleR

  outleta "OutL", aThinkBreakL
  outleta "OutR", aThinkBreakR
endin

instr ThinkBreakBassKnob
  gkThinkBreakEqBass linseg p4, p3, p5
endin

instr ThinkBreakMidKnob
  gkThinkBreakEqMid linseg p4, p3, p5
endin

instr ThinkBreakHighKnob
  gkThinkBreakEqHigh linseg p4, p3, p5
endin

instr ThinkBreakFader
  gkThinkBreakFader linseg p4, p3, p5
endin

instr ThinkBreakPan
  gkThinkBreakPan linseg p4, p3, p5
endin

instr ThinkBreakMixerChannel
  aThinkBreakL inleta "InL"
  aThinkBreakR inleta "InR"

  aThinkBreakL, aThinkBreakR mixerChannel aThinkBreakL, aThinkBreakR, gkThinkBreakFader, gkThinkBreakPan, gkThinkBreakEqBass, gkThinkBreakEqMid, gkThinkBreakEqHigh

  outleta "OutL", aThinkBreakL
  outleta "OutR", aThinkBreakR
endin

