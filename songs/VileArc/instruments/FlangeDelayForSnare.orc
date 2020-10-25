alwayson "FlangeDelayForSnareInput"
alwayson "FlangeDelayForSnareMixerChannel"

giFlangeDelayForSnareBufferLength init 5
gaFlangeDelayForSnareTime init 0.0025
gkFlangeDelayForSnareFeedbackAmount init 0.95
gkFlangeDelayForSnareLevel init 1
gkFlangeDelayForSnareStereoOffset init 0.0
giFlangeDelayForSnareReleaseTime init .1

gkFlangeDelayForSnareEqBass init 1
gkFlangeDelayForSnareEqMid init 1
gkFlangeDelayForSnareEqHigh init 1
gkFlangeDelayForSnareFader init 1
gkFlangeDelayForSnarePan init 50

gkFlangeDelayForSnareWetAmount init .25
gkFlangeDelayForSnareDryAmount init 1.25

bypassRoute "FlangeDelayForSnare", "DelayForSnareInput", "DelayForSnareInput"

instr FlangeDelayForSnareInput
  aFlangeDelayForSnareInL inleta "InL"
  aFlangeDelayForSnareInR inleta "InR"

  aFlangeDelayForSnareOutWetL, aFlangeDelayForSnareOutWetR, aFlangeDelayForSnareOutDryL, aFlangeDelayForSnareOutDryR bypassSwitch aFlangeDelayForSnareInL, aFlangeDelayForSnareInR, gkFlangeDelayForSnareDryAmount, gkFlangeDelayForSnareWetAmount, "FlangeDelayForSnare"

  outleta "OutWetL", aFlangeDelayForSnareOutWetL
  outleta "OutWetR", aFlangeDelayForSnareOutWetR

  outleta "OutDryL", aFlangeDelayForSnareOutDryL
  outleta "OutDryR", aFlangeDelayForSnareOutDryR
endin

instr FlangeDelayForSnareTimeKnob
  gaFlangeDelayForSnareTime linseg p4, p3, p5
endin

instr FlangeDelayForSnareFeedbackAmountKnob
  gkFlangeDelayForSnareFeedbackAmount linseg p4, p3, p5
endin

instr FlangeDelayForSnareLevelKnob
  gkFlangeDelayForSnareLevel linseg p4, p3, p5
endin

instr FlangeDelayForSnareStereoOffsetKnob
  gkFlangeDelayForSnareStereoOffset linseg p4, p3, p5
endin


instr FlangeDelayForSnare
  aFlangeDelayForSnareInL inleta "InL"
  aFlangeDelayForSnareInR inleta "InR"

  aFlangeDelayForSnareTimeL = gaFlangeDelayForSnareTime + gkFlangeDelayForSnareStereoOffset
  aFlangeDelayForSnareTimeR = gaFlangeDelayForSnareTime - gkFlangeDelayForSnareStereoOffset

  aFlangeDelayForSnareAudioL delayBuffer aFlangeDelayForSnareInL, gkFlangeDelayForSnareFeedbackAmount, giFlangeDelayForSnareBufferLength, aFlangeDelayForSnareTimeL, gkFlangeDelayForSnareLevel
  aFlangeDelayForSnareAudioR delayBuffer aFlangeDelayForSnareInR, gkFlangeDelayForSnareFeedbackAmount, giFlangeDelayForSnareBufferLength, aFlangeDelayForSnareTimeR, gkFlangeDelayForSnareLevel

  aFlangeDelayForSnareOutL = aFlangeDelayForSnareAudioL * madsr(.01, .01, 1, giFlangeDelayForSnareReleaseTime)
  aFlangeDelayForSnareOutR = aFlangeDelayForSnareAudioR * madsr(.01, .01, 1, giFlangeDelayForSnareReleaseTime)

  outleta "OutL", aFlangeDelayForSnareOutL
  outleta "OutR", aFlangeDelayForSnareOutR
endin

instr FlangeDelayForSnareBassKnob
  gkFlangeDelayForSnareEqBass linseg p4, p3, p5
endin

instr FlangeDelayForSnareMidKnob
  gkFlangeDelayForSnareEqMid linseg p4, p3, p5
endin

instr FlangeDelayForSnareHighKnob
  gkFlangeDelayForSnareEqHigh linseg p4, p3, p5
endin

instr FlangeDelayForSnareFader
  gkFlangeDelayForSnareFader linseg p4, p3, p5
endin

instr FlangeDelayForSnarePan
  gkFlangeDelayForSnarePan linseg p4, p3, p5
endin

instr FlangeDelayForSnareMixerChannel
  aFlangeDelayForSnareL inleta "InL"
  aFlangeDelayForSnareR inleta "InR"

  aFlangeDelayForSnareL, aFlangeDelayForSnareR mixerChannel aFlangeDelayForSnareL, aFlangeDelayForSnareR, gkFlangeDelayForSnareFader, gkFlangeDelayForSnarePan, gkFlangeDelayForSnareEqBass, gkFlangeDelayForSnareEqMid, gkFlangeDelayForSnareEqHigh

  outleta "OutL", aFlangeDelayForSnareL
  outleta "OutR", aFlangeDelayForSnareR
endin
