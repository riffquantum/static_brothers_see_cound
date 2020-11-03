bypassRoute "Darkside50Reverb", "DefaultEffectChain", "DefaultEffectChain"

alwayson "Darkside50ReverbInput"
alwayson "Darkside50ReverbMixerChannel"
alwayson "Darkside50Reverb"

gkDarkside50ReverbEqBass init 1
gkDarkside50ReverbEqMid init 1
gkDarkside50ReverbEqHigh init 1
gkDarkside50ReverbFader init 1
gkDarkside50ReverbPan init 50

gkDarkside50ReverbDryAmount init 0
gkDarkside50ReverbWetAmount init 1

gkDarkside50ReverbRate init 20
gkDarkside50ReverbDepth init 1

instr Darkside50ReverbInput
  aInL inleta "InL"
  aInR inleta "InR"

  aOutWetL, aOutWetR, aOutDryL, aOutDryR bypassSwitch aInL, aInR, gkDarkside50ReverbDryAmount, gkDarkside50ReverbWetAmount, "Darkside50Reverb"

  outleta "OutWetL", aOutWetL
  outleta "OutWetR", aOutWetR

  outleta "OutDryL", aOutDryL
  outleta "OutDryR", aOutDryR
endin

instr Darkside50Reverb
  aInL inleta "InL"
  aInR inleta "InR"

  ; http://www.rwdobson.com/sspaces/sciencespaces.html
  SImpulseResponseFiles[] fillarray "darksideIRs/cylinder11A_amb.wav","darksideIRs/cylinder11B_amb.wav", "darksideIRs/cylinder12A_amb.wav", "darksideIRs/cylinder12B_amb.wav", "darksideIRs/cylinder14A_amb.wav","darksideIRs/cylinder14B_amb.wav", "darksideIRs/sphere16A_amb.wav", "darksideIRs/sphere16B_amb.wav", "darksideIRs/sphere17A_amb.wav", "darksideIRs/sphere17B_amb.wav", "darksideIRs/sphere18A_amb.wav", "darksideIRs/sphere18B_amb.wav"

  iPartitionSize = 1024
  iChannelL = 1
  iChannelR = 2

  aOutL pconvolve aInL, SImpulseResponseFile[p4], iPartitionSize, iChannelL
  aOutR pconvolve aInR, SImpulseResponseFile[p4], iPartitionSize, iChannelR

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr Darkside50ReverbBassKnob
  gkDarkside50ReverbEqBass linseg p4, p3, p5
endin

instr Darkside50ReverbMidKnob
  gkDarkside50ReverbEqMid linseg p4, p3, p5
endin

instr Darkside50ReverbHighKnob
  gkDarkside50ReverbEqHigh linseg p4, p3, p5
endin

instr Darkside50ReverbFader
  gkDarkside50ReverbFader linseg p4, p3, p5
endin

instr Darkside50ReverbPan
  gkDarkside50ReverbPan linseg p4, p3, p5
endin

instr Darkside50ReverbMixerChannel
  aL inleta "InL"
  aR inleta "InR"

  aL, aR mixerChannel aL, aR, gkDarkside50ReverbFader, gkDarkside50ReverbPan, gkDarkside50ReverbEqBass, gkDarkside50ReverbEqMid, gkDarkside50ReverbEqHigh

  outleta "OutL", aL
  outleta "OutR", aR
endin
