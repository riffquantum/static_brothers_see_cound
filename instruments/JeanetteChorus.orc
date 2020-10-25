alwayson "JeanetteChorusInput"
alwayson "JeanetteChorusMixerChannel"

bypassRoute "JeanetteChorus", "Mixer", "Mixer"

gkJeanetteChorusEqBass init 1
gkJeanetteChorusEqMid init 1
gkJeanetteChorusEqHigh init 1
gkJeanetteChorusFader init 1
gkJeanetteChorusPan init 50

gkJeanetteChorusDryAmount init 0
gkJeanetteChorusWetAmount init 1
gkJeanetteChorusAmount init 1
gkJeanetteChorusDryWet init 1
giJeanetteChorusStereoRecombinationMode = 0

instr JeanetteChorusInput
  aJeanetteChorusInL inleta "InL"
  aJeanetteChorusInR inleta "InR"

  aJeanetteChorusOutWetL, aJeanetteChorusOutWetR, aJeanetteChorusOutDryL, aJeanetteChorusOutDryR bypassSwitch aJeanetteChorusInL, aJeanetteChorusInR, gkJeanetteChorusDryAmount, gkJeanetteChorusWetAmount, "JeanetteChorus"

  outleta "OutWetL", aJeanetteChorusOutWetL
  outleta "OutWetR", aJeanetteChorusOutWetR

  outleta "OutDryL", aJeanetteChorusOutDryL
  outleta "OutDryR", aJeanetteChorusOutDryR
endin

instr JeanetteChorus
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"


  kChorusAmount = gkJeanetteChorusAmount * (p4 == 0 ? 1 : p4)
  kDryWet = gkJeanetteChorusDryWet * (p5 == 0 ? 1 : p5)

  aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
  aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

  if giJeanetteChorusStereoRecombinationMode == 0 then
    aSignalOutL = aSignalOutLL
    aSignalOutR = aSignalOutRR
  else
    aSignalOutL = aSignalOutLL + aSignalOutRL
    aSignalOutR = aSignalOutLR + aSignalOutRR
  endif

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr JeanetteChorusAmountKnob
  gkJeanetteChorusAmount linseg p4, p3, p5
endin

instr JeanetteChorusBassKnob
  gkJeanetteChorusEqBass linseg p4, p3, p5
endin

instr JeanetteChorusMidKnob
  gkJeanetteChorusEqMid linseg p4, p3, p5
endin

instr JeanetteChorusHighKnob
  gkJeanetteChorusEqHigh linseg p4, p3, p5
endin

instr JeanetteChorusFader
  gkJeanetteChorusFader linseg p4, p3, p5
endin

instr JeanetteChorusPan
  gkJeanetteChorusPan linseg p4, p3, p5
endin

instr JeanetteChorusMixerChannel
  aJeanetteChorusL inleta "InL"
  aJeanetteChorusR inleta "InR"

  aJeanetteChorusL, aJeanetteChorusR mixerChannel aJeanetteChorusL, aJeanetteChorusR, gkJeanetteChorusFader, gkJeanetteChorusPan, gkJeanetteChorusEqBass, gkJeanetteChorusEqMid, gkJeanetteChorusEqHigh

  outleta "OutL", aJeanetteChorusL
  outleta "OutR", aJeanetteChorusR
endin
