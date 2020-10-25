alwayson "DelayForSnareInput"
alwayson "DelayForSnareMixerChannel"

giDelayForSnareBufferLength init 5
gaDelayForSnareTime init 0.2
gkDelayForSnareFeedbackAmount init 0.85
gkDelayForSnareLevel init 1
gkDelayForSnareStereoOffset init 0.00
giDelayForSnareReleaseTime init 2

gkDelayForSnareEqBass init 1
gkDelayForSnareEqMid init 1
gkDelayForSnareEqHigh init 1
gkDelayForSnareFader init 1
gkDelayForSnarePan init 50

gkDelayForSnareWetAmount init 1
gkDelayForSnareDryAmount init 1

bypassRoute "DelayForSnare", "ReverbForSnareInput", "ReverbForSnareInput"

instr DelayForSnareInput
  aDelayForSnareInL inleta "InL"
  aDelayForSnareInR inleta "InR"

  aDelayForSnareOutWetL, aDelayForSnareOutWetR, aDelayForSnareOutDryL, aDelayForSnareOutDryR bypassSwitch aDelayForSnareInL, aDelayForSnareInR, gkDelayForSnareDryAmount, gkDelayForSnareWetAmount, "DelayForSnare"

  outleta "OutWetL", aDelayForSnareOutWetL
  outleta "OutWetR", aDelayForSnareOutWetR

  outleta "OutDryL", aDelayForSnareOutDryL
  outleta "OutDryR", aDelayForSnareOutDryR
endin

instr DelayForSnareTimeKnob
  gaDelayForSnareTime linseg p4, p3, p5
endin

instr DelayForSnareFeedbackAmountKnob
  gkDelayForSnareFeedbackAmount linseg p4, p3, p5
endin

instr DelayForSnareLevelKnob
  gkDelayForSnareLevel linseg p4, p3, p5
endin

instr DelayForSnareStereoOffsetKnob
  gkDelayForSnareStereoOffset linseg p4, p3, p5
endin


instr DelayForSnare
  aDelayForSnareInL inleta "InL"
  aDelayForSnareInR inleta "InR"

  aDelayForSnareTimeL = gaDelayForSnareTime + gkDelayForSnareStereoOffset
  aDelayForSnareTimeR = gaDelayForSnareTime - gkDelayForSnareStereoOffset

  aDelayForSnareAudioL delayBuffer aDelayForSnareInL, gkDelayForSnareFeedbackAmount, giDelayForSnareBufferLength, aDelayForSnareTimeL, gkDelayForSnareLevel
  aDelayForSnareAudioR delayBuffer aDelayForSnareInR, gkDelayForSnareFeedbackAmount, giDelayForSnareBufferLength, aDelayForSnareTimeR, gkDelayForSnareLevel

  aDelayForSnareOutL = aDelayForSnareAudioL * madsr(.01, .01, 1, giDelayForSnareReleaseTime)
  aDelayForSnareOutR = aDelayForSnareAudioR * madsr(.01, .01, 1, giDelayForSnareReleaseTime)

  outleta "OutL", aDelayForSnareOutL
  outleta "OutR", aDelayForSnareOutR
endin

instr DelayForSnareBassKnob
  gkDelayForSnareEqBass linseg p4, p3, p5
endin

instr DelayForSnareMidKnob
  gkDelayForSnareEqMid linseg p4, p3, p5
endin

instr DelayForSnareHighKnob
  gkDelayForSnareEqHigh linseg p4, p3, p5
endin

instr DelayForSnareFader
  gkDelayForSnareFader linseg p4, p3, p5
endin

instr DelayForSnarePan
  gkDelayForSnarePan linseg p4, p3, p5
endin

instr DelayForSnareMixerChannel
  aDelayForSnareL inleta "InL"
  aDelayForSnareR inleta "InR"

  aDelayForSnareL, aDelayForSnareR mixerChannel aDelayForSnareL, aDelayForSnareR, gkDelayForSnareFader, gkDelayForSnarePan, gkDelayForSnareEqBass, gkDelayForSnareEqMid, gkDelayForSnareEqHigh

  outleta "OutL", aDelayForSnareL
  outleta "OutR", aDelayForSnareR
endin
