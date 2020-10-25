alwayson "DrumKitChorusInput"
alwayson "DrumKitChorusMixerChannel"

bypassRoute "DrumKitChorus", "DrumKitReverbInput", "DrumKitReverbInput"

gkDrumKitChorusEqBass init 1
gkDrumKitChorusEqMid init 1
gkDrumKitChorusEqHigh init 1
gkDrumKitChorusFader init 1
gkDrumKitChorusPan init 50

gkDrumKitChorusDryAmount init 1
gkDrumKitChorusWetAmount init 1
gkDrumKitChorusAmount init 1
gkDrumKitChorusDryWet init 1
giDrumKitChorusStereoRecombinationMode = 0

instr DrumKitChorusInput
  aDrumKitChorusInL inleta "InL"
  aDrumKitChorusInR inleta "InR"

  aDrumKitChorusOutWetL, aDrumKitChorusOutWetR, aDrumKitChorusOutDryL, aDrumKitChorusOutDryR bypassSwitch aDrumKitChorusInL, aDrumKitChorusInR, gkDrumKitChorusDryAmount, gkDrumKitChorusWetAmount, "DrumKitChorus"

  outleta "OutWetL", aDrumKitChorusOutWetL
  outleta "OutWetR", aDrumKitChorusOutWetR

  outleta "OutDryL", aDrumKitChorusOutDryL
  outleta "OutDryR", aDrumKitChorusOutDryR
endin

instr DrumKitChorus
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"


  kChorusAmount = gkDrumKitChorusAmount * (p4 == 0 ? 1 : p4)
  kDryWet = gkDrumKitChorusDryWet * (p5 == 0 ? 1 : p5)

  aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
  aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

  if giDrumKitChorusStereoRecombinationMode == 0 then
    aSignalOutL = aSignalOutLL
    aSignalOutR = aSignalOutRR
  else
    aSignalOutL = aSignalOutLL + aSignalOutRL
    aSignalOutR = aSignalOutLR + aSignalOutRR
  endif

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr DrumKitChorusAmountKnob
  gkDrumKitChorusAmount linseg p4, p3, p5
endin

instr DrumKitChorusBassKnob
  gkDrumKitChorusEqBass linseg p4, p3, p5
endin

instr DrumKitChorusMidKnob
  gkDrumKitChorusEqMid linseg p4, p3, p5
endin

instr DrumKitChorusHighKnob
  gkDrumKitChorusEqHigh linseg p4, p3, p5
endin

instr DrumKitChorusFader
  gkDrumKitChorusFader linseg p4, p3, p5
endin

instr DrumKitChorusPan
  gkDrumKitChorusPan linseg p4, p3, p5
endin

instr DrumKitChorusMixerChannel
  aDrumKitChorusL inleta "InL"
  aDrumKitChorusR inleta "InR"

  aDrumKitChorusL, aDrumKitChorusR mixerChannel aDrumKitChorusL, aDrumKitChorusR, gkDrumKitChorusFader, gkDrumKitChorusPan, gkDrumKitChorusEqBass, gkDrumKitChorusEqMid, gkDrumKitChorusEqHigh

  outleta "OutL", aDrumKitChorusL
  outleta "OutR", aDrumKitChorusR
endin
