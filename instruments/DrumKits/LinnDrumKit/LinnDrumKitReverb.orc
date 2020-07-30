alwayson "LinnDrumKitReverb"
alwayson "LinnDrumKitReverbMixerChannel"

giLinnDrumKitReverbBufferLength init 5
gaLinnDrumKitReverbTime init .3
gkLinnDrumKitReverbFeedbackAmmount init 0.8
gkLinnDrumKitReverbLevel init .2
gkStereoOffset init 0.1

gkLinnDrumKitReverbEqBass init 1
gkLinnDrumKitReverbEqMid init 1
gkLinnDrumKitReverbEqHigh init 1
gkLinnDrumKitReverbFader init 1
gkLinnDrumKitReverbPan init 50
instrumentRoute "LinnDrumKitReverb", "Mixer"

gkLinnDrumKitReverbWet init 0.0075
gkLinnDrumKitReverbDry init 0

instr LinnDrumKitReverb
  aLinnDrumKitReverbInL inleta "InL"
  aLinnDrumKitReverbInR inleta "InR"

  SImpulsePath = "./localSamples/IMreverbs/Narrow Bumpy Space.wav"

  iImpulseTable ftgen 0, 0, 0, 1, SImpulsePath, 0, 0, 0
  iPartitionSize = 64
  iSkipSamples = 0
  iImpulseResponseLength = 0
  iSkipInit = 0

  aLinnDrumKitReverbWetL ftconv aLinnDrumKitReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
  aLinnDrumKitReverbWetR ftconv aLinnDrumKitReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit

  aLinnDrumKitReverbOutL = (aLinnDrumKitReverbWetL * gkLinnDrumKitReverbWet) + (aLinnDrumKitReverbInL * gkLinnDrumKitReverbDry)
  aLinnDrumKitReverbOutR = (aLinnDrumKitReverbWetR * gkLinnDrumKitReverbWet) + (aLinnDrumKitReverbInR * gkLinnDrumKitReverbDry)

  outleta "OutL", aLinnDrumKitReverbOutL
  outleta "OutR", aLinnDrumKitReverbOutR
endin

instr LinnDrumKitReverbBassKnob
  gkLinnDrumKitReverbEqBass linseg p4, p3, p5
endin

instr LinnDrumKitReverbMidKnob
  gkLinnDrumKitReverbEqMid linseg p4, p3, p5
endin

instr LinnDrumKitReverbHighKnob
  gkLinnDrumKitReverbEqHigh linseg p4, p3, p5
endin

instr LinnDrumKitReverbFader
  gkLinnDrumKitReverbFader linseg p4, p3, p5
endin

instr LinnDrumKitReverbPan
  gkLinnDrumKitReverbPan linseg p4, p3, p5
endin

instr LinnDrumKitReverbMixerChannel
  aLinnDrumKitReverbL inleta "InL"
  aLinnDrumKitReverbR inleta "InR"

  aLinnDrumKitReverbL, aLinnDrumKitReverbR mixerChannel aLinnDrumKitReverbL, aLinnDrumKitReverbR, gkLinnDrumKitReverbFader, gkLinnDrumKitReverbPan, gkLinnDrumKitReverbEqBass, gkLinnDrumKitReverbEqMid, gkLinnDrumKitReverbEqHigh

  outleta "OutL", aLinnDrumKitReverbL
  outleta "OutR", aLinnDrumKitReverbR
endin
