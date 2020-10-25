instrumentRoute "AwfulCrash", "DistortionForAwfulCrashInput"

alwayson "AwfulCrashMixerChannel"

gkAwfulCrashEqBass init 1
gkAwfulCrashEqMid init 1
gkAwfulCrashEqHigh init 1
gkAwfulCrashFader init 1
gkAwfulCrashPan init 60

gSAwfulCrashSamplePath = "localSamples/Drums/XTortion_Crash_OA47.wav"
gSAwfulCrashSamplePath = "localSamples/Drums/Linn-Drum_Crash_1.wav"
gSAwfulCrashSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giAwfulCrashSample ftgen 0, 0, 0, 1, gSAwfulCrashSamplePath, 0, 0, 0

instr AwfulCrash
  iDelayTimeStart = p6 == 0 ? 0.00095 : p6
  iDelayTimeEnd = p7 == 0 ? 0.00075 : p7

  aAwfulCrashL, aAwfulCrashR drumSample giAwfulCrashSample, p4, p5

  ; gaDelayForAwfulCrashTime linseg iDelayTimeStart, 1, iDelayTimeEnd

  outleta "OutL", aAwfulCrashL
  outleta "OutR", aAwfulCrashR
endin

instr AwfulCrashBassKnob
  gkAwfulCrashEqBass linseg p4, p3, p5
endin

instr AwfulCrashMidKnob
  gkAwfulCrashEqMid linseg p4, p3, p5
endin

instr AwfulCrashHighKnob
  gkAwfulCrashEqHigh linseg p4, p3, p5
endin

instr AwfulCrashFader
  gkAwfulCrashFader linseg p4, p3, p5
endin

instr AwfulCrashPan
  gkAwfulCrashPan linseg p4, p3, p5
endin

instr AwfulCrashMixerChannel
  aAwfulCrashL inleta "InL"
  aAwfulCrashR inleta "InR"

  aAwfulCrashL, aAwfulCrashR mixerChannel aAwfulCrashL, aAwfulCrashR, gkAwfulCrashFader, gkAwfulCrashPan, gkAwfulCrashEqBass, gkAwfulCrashEqMid, gkAwfulCrashEqHigh

  outleta "OutL", aAwfulCrashL
  outleta "OutR", aAwfulCrashR
endin
