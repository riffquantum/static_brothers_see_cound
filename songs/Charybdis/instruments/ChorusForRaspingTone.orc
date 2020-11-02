alwayson "ChorusForRaspingToneInput"
alwayson "ChorusForRaspingToneMixerChannel"

bypassRoute "ChorusForRaspingTone", "Mixer", "Mixer"

gkChorusForRaspingToneEqBass init 1
gkChorusForRaspingToneEqMid init 1
gkChorusForRaspingToneEqHigh init 1
gkChorusForRaspingToneFader init 1
gkChorusForRaspingTonePan init 50

gkChorusForRaspingToneDryAmount init 1
gkChorusForRaspingToneWetAmount init .3
gkChorusForRaspingToneAmount init 5
gkChorusForRaspingToneDryWet init 1
giChorusForRaspingToneStereoRecombinationMode = 0

instr ChorusForRaspingToneInput
  aChorusForRaspingToneInL inleta "InL"
  aChorusForRaspingToneInR inleta "InR"

  aChorusForRaspingToneOutWetL, aChorusForRaspingToneOutWetR, aChorusForRaspingToneOutDryL, aChorusForRaspingToneOutDryR bypassSwitch aChorusForRaspingToneInL, aChorusForRaspingToneInR, gkChorusForRaspingToneDryAmount, gkChorusForRaspingToneWetAmount, "ChorusForRaspingTone"

  outleta "OutWetL", aChorusForRaspingToneOutWetL
  outleta "OutWetR", aChorusForRaspingToneOutWetR

  outleta "OutDryL", aChorusForRaspingToneOutDryL
  outleta "OutDryR", aChorusForRaspingToneOutDryR
endin

instr ChorusForRaspingTone
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"


  kChorusAmount = gkChorusForRaspingToneAmount * (p4 == 0 ? 1 : p4)
  kDryWet = gkChorusForRaspingToneDryWet * (p5 == 0 ? 1 : p5)

  aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
  aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

  if giChorusForRaspingToneStereoRecombinationMode == 0 then
    aSignalOutL = aSignalOutLL
    aSignalOutR = aSignalOutRR
  else
    aSignalOutL = aSignalOutLL + aSignalOutRL
    aSignalOutR = aSignalOutLR + aSignalOutRR
  endif

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr ChorusForRaspingToneAmountKnob
  gkChorusForRaspingToneAmount linseg p4, p3, p5
endin

instr ChorusForRaspingToneBassKnob
  gkChorusForRaspingToneEqBass linseg p4, p3, p5
endin

instr ChorusForRaspingToneMidKnob
  gkChorusForRaspingToneEqMid linseg p4, p3, p5
endin

instr ChorusForRaspingToneHighKnob
  gkChorusForRaspingToneEqHigh linseg p4, p3, p5
endin

instr ChorusForRaspingToneFader
  gkChorusForRaspingToneFader linseg p4, p3, p5
endin

instr ChorusForRaspingTonePan
  gkChorusForRaspingTonePan linseg p4, p3, p5
endin

instr ChorusForRaspingToneMixerChannel
  aChorusForRaspingToneL inleta "InL"
  aChorusForRaspingToneR inleta "InR"

  aChorusForRaspingToneL, aChorusForRaspingToneR mixerChannel aChorusForRaspingToneL, aChorusForRaspingToneR, gkChorusForRaspingToneFader, gkChorusForRaspingTonePan, gkChorusForRaspingToneEqBass, gkChorusForRaspingToneEqMid, gkChorusForRaspingToneEqHigh

  outleta "OutL", aChorusForRaspingToneL
  outleta "OutR", aChorusForRaspingToneR
endin
