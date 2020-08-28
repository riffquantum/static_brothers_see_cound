alwayson "TR606KitReverb"
alwayson "TR606KitReverbMixerChannel"

giTR606KitReverbBufferLength init 5
gaTR606KitReverbTime init .3
gkTR606KitReverbFeedbackAmmount init 0.8
gkTR606KitReverbLevel init .2

gkTR606KitReverbEqBass init 1
gkTR606KitReverbEqMid init 1
gkTR606KitReverbEqHigh init 1
gkTR606KitReverbFader init 1
gkTR606KitReverbPan init 50
instrumentRoute "TR606KitReverb", "Mixer"

gkTR606KitReverbWet init 0.0075
gkTR606KitReverbDry init 0

instr TR606KitReverb
  aTR606KitReverbInL inleta "InL"
  aTR606KitReverbInR inleta "InR"

  SImpulsePath = "./localSamples/IMreverbs/Narrow Bumpy Space.wav"

  iImpulseTable ftgen 0, 0, 0, 1, SImpulsePath, 0, 0, 0
  iPartitionSize = 64
  iSkipSamples = 0
  iImpulseResponseLength = 0
  iSkipInit = 0

  aTR606KitReverbWetL ftconv aTR606KitReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
  aTR606KitReverbWetR ftconv aTR606KitReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit

  aTR606KitReverbOutL = (aTR606KitReverbWetL * gkTR606KitReverbWet) + (aTR606KitReverbInL * gkTR606KitReverbDry)
  aTR606KitReverbOutR = (aTR606KitReverbWetR * gkTR606KitReverbWet) + (aTR606KitReverbInR * gkTR606KitReverbDry)

  outleta "OutL", aTR606KitReverbOutL
  outleta "OutR", aTR606KitReverbOutR
endin

instr TR606KitReverbBassKnob
  gkTR606KitReverbEqBass linseg p4, p3, p5
endin

instr TR606KitReverbMidKnob
  gkTR606KitReverbEqMid linseg p4, p3, p5
endin

instr TR606KitReverbHighKnob
  gkTR606KitReverbEqHigh linseg p4, p3, p5
endin

instr TR606KitReverbFader
  gkTR606KitReverbFader linseg p4, p3, p5
endin

instr TR606KitReverbPan
  gkTR606KitReverbPan linseg p4, p3, p5
endin

instr TR606KitReverbMixerChannel
  aTR606KitReverbL inleta "InL"
  aTR606KitReverbR inleta "InR"

  aTR606KitReverbL, aTR606KitReverbR mixerChannel aTR606KitReverbL, aTR606KitReverbR, gkTR606KitReverbFader, gkTR606KitReverbPan, gkTR606KitReverbEqBass, gkTR606KitReverbEqMid, gkTR606KitReverbEqHigh

  outleta "OutL", aTR606KitReverbL
  outleta "OutR", aTR606KitReverbR
endin
