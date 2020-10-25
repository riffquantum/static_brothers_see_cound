instrumentRoute "PitchedDownCrash", "GlobalReverbInput"

alwayson "PitchedDownCrashMixerChannel"

gkPitchedDownCrashEqBass init 1
gkPitchedDownCrashEqMid init 1
gkPitchedDownCrashEqHigh init 1
gkPitchedDownCrashFader init 1
gkPitchedDownCrashPan init 50

gSPitchedDownCrashSamplePath ="songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giPitchedDownCrashSample ftgen 0, 0, 0, 1, gSPitchedDownCrashSamplePath, 0, 0, 0

instr PitchedDownCrash
  iAmplitude = velocityToAmplitude(p4)
  iPitch = p4 * .5

  aPitchedDownCrashL, aPitchedDownCrashR drumSample giPitchedDownCrashSample, iAmplitude, iPitch

  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aPitchedDownCrashSample loscil kAmplitudeEnvelope, .5, giPitchedDownCrashSample, 1


  outs aPitchedDownCrashSample, aPitchedDownCrashSample

  outleta "OutL", aPitchedDownCrashL
  outleta "OutR", aPitchedDownCrashR
endin

instr PitchedDownCrashBassKnob
  gkPitchedDownCrashEqBass linseg p4, p3, p5
endin

instr PitchedDownCrashMidKnob
  gkPitchedDownCrashEqMid linseg p4, p3, p5
endin

instr PitchedDownCrashHighKnob
  gkPitchedDownCrashEqHigh linseg p4, p3, p5
endin

instr PitchedDownCrashFader
  gkPitchedDownCrashFader linseg p4, p3, p5
endin

instr PitchedDownCrashPan
  gkPitchedDownCrashPan linseg p4, p3, p5
endin

instr PitchedDownCrashMixerChannel
  aPitchedDownCrashL inleta "InL"
  aPitchedDownCrashR inleta "InR"

  aPitchedDownCrashL, aPitchedDownCrashR mixerChannel aPitchedDownCrashL, aPitchedDownCrashR, gkPitchedDownCrashFader, gkPitchedDownCrashPan, gkPitchedDownCrashEqBass, gkPitchedDownCrashEqMid, gkPitchedDownCrashEqHigh

  outleta "OutL", aPitchedDownCrashL
  outleta "OutR", aPitchedDownCrashR
endin
