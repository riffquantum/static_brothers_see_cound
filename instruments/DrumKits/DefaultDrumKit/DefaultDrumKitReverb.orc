alwayson "DefaultDrumKitReverb"
alwayson "DefaultDrumKitReverbMixerChannel"

giDefaultDrumKitReverbBufferLength init 5
gaDefaultDrumKitReverbTime init .3
gkDefaultDrumKitReverbFeedbackAmount init 0.8
gkDefaultDrumKitReverbLevel init .2

gkDefaultDrumKitReverbEqBass init 1
gkDefaultDrumKitReverbEqMid init 1
gkDefaultDrumKitReverbEqHigh init 1
gkDefaultDrumKitReverbFader init 1
gkDefaultDrumKitReverbPan init 50
effectRoute "DefaultDrumKitReverb", "Mixer", "Mixer"

gkDefaultDrumKitReverbWet init 0.0075
gkDefaultDrumKitReverbDry init 1

instr DefaultDrumKitReverb
  aDefaultDrumKitReverbInL inleta "InL"
  aDefaultDrumKitReverbInR inleta "InR"

  SImpulsePath = "./localSamples/IMreverbs/Narrow Bumpy Space.wav"

  iImpulseTable ftgen 0, 0, 0, 1, SImpulsePath, 0, 0, 0
  iPartitionSize = 64
  iSkipSamples = 0
  iImpulseResponseLength = 0
  iSkipInit = 0

  aDefaultDrumKitReverbWetL ftconv aDefaultDrumKitReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
  aDefaultDrumKitReverbWetR ftconv aDefaultDrumKitReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit

  aDefaultDrumKitReverbOutDryL = aDefaultDrumKitReverbInL * gkDefaultDrumKitReverbDry
  aDefaultDrumKitReverbOutDryR = aDefaultDrumKitReverbInR * gkDefaultDrumKitReverbDry

  aDefaultDrumKitReverbOutWetL = aDefaultDrumKitReverbWetL * gkDefaultDrumKitReverbWet
  aDefaultDrumKitReverbOutWetR = aDefaultDrumKitReverbWetR * gkDefaultDrumKitReverbWet

  outleta "OutDryL", aDefaultDrumKitReverbOutDryL
  outleta "OutDryR", aDefaultDrumKitReverbOutDryR

  outleta "OutWetL", aDefaultDrumKitReverbOutWetL
  outleta "OutWetR", aDefaultDrumKitReverbOutWetR
endin

instr DefaultDrumKitReverbBassKnob
  gkDefaultDrumKitReverbEqBass linseg p4, p3, p5
endin

instr DefaultDrumKitReverbMidKnob
  gkDefaultDrumKitReverbEqMid linseg p4, p3, p5
endin

instr DefaultDrumKitReverbHighKnob
  gkDefaultDrumKitReverbEqHigh linseg p4, p3, p5
endin

instr DefaultDrumKitReverbFader
  gkDefaultDrumKitReverbFader linseg p4, p3, p5
endin

instr DefaultDrumKitReverbPan
  gkDefaultDrumKitReverbPan linseg p4, p3, p5
endin

instr DefaultDrumKitReverbMixerChannel
  aDefaultDrumKitReverbL inleta "InL"
  aDefaultDrumKitReverbR inleta "InR"

  aDefaultDrumKitReverbL, aDefaultDrumKitReverbR mixerChannel aDefaultDrumKitReverbL, aDefaultDrumKitReverbR, gkDefaultDrumKitReverbFader, gkDefaultDrumKitReverbPan, gkDefaultDrumKitReverbEqBass, gkDefaultDrumKitReverbEqMid, gkDefaultDrumKitReverbEqHigh

  outleta "OutL", aDefaultDrumKitReverbL
  outleta "OutR", aDefaultDrumKitReverbR
endin
