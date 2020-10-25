instrumentRoute "EightOhEightKick", "KickMixerChannel"
alwayson "EightOhEightKickMixerChannel"

gkEightOhEightKickEqBass init 1
gkEightOhEightKickEqMid init 1
gkEightOhEightKickEqHigh init 1
gkEightOhEightKickFader init 1
gkEightOhEightKickPan init 50

gSEightOhEightKickSamplePath = "localSamples/Drums/TR-808_Kick_005.wav"
gSEightOhEightKickSamplePath = "localSamples/Drums/TR-808_Kick_41.wav"
giEightOhEightKickSample ftgen 0, 0, 0, 1, gSEightOhEightKickSamplePath, 0, 0, 0

instr EightOhEightKick
  aEightOhEightKickSampleL, aEightOhEightKickSampleR drumSample giEightOhEightKickSample, p4, p5

  outleta "OutL", aEightOhEightKickSampleL
  outleta "OutR", aEightOhEightKickSampleR
endin


instr EightOhEightKickBassKnob
  gkEightOhEightKickEqBass linseg p4, p3, p5
endin

instr EightOhEightKickMidKnob
  gkEightOhEightKickEqMid linseg p4, p3, p5
endin

instr EightOhEightKickHighKnob
  gkEightOhEightKickEqHigh linseg p4, p3, p5
endin

instr EightOhEightKickFader
  gkEightOhEightKickFader linseg p4, p3, p5
endin

instr EightOhEightKickPan
  gkEightOhEightKickPan linseg p4, p3, p5
endin

instr EightOhEightKickMixerChannel
  aEightOhEightKickL inleta "InL"
  aEightOhEightKickR inleta "InR"

  aEightOhEightKickL, aEightOhEightKickR mixerChannel aEightOhEightKickL, aEightOhEightKickR, gkEightOhEightKickFader, gkEightOhEightKickPan, gkEightOhEightKickEqBass, gkEightOhEightKickEqMid, gkEightOhEightKickEqHigh

  outleta "OutL", aEightOhEightKickL
  outleta "OutR", aEightOhEightKickR
endin
