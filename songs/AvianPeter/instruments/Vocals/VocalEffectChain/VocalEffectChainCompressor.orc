alwayson "VocalEffectChainCompressorInput"
alwayson "VocalEffectChainCompressorMixerChannel"

bypassRoute "VocalEffectChainCompressor", "VocalEffectChainPitchShifterInput", "VocalEffectChainPitchShifterInput"

gkVocalEffectChainCompressorEqBass init 1
gkVocalEffectChainCompressorEqMid init 1
gkVocalEffectChainCompressorEqHigh init 1
gkVocalEffectChainCompressorFader init 1
gkVocalEffectChainCompressorPan init 50

gkVocalEffectChainCompressorDryAmount init 0
gkVocalEffectChainCompressorWetAmount init 1
giVocalEffectChainCompressorMode init 0

gkVocalEffectChainCompressorThreshold init 0
gkVocalEffectChainCompressorLowKnee init 40
gkVocalEffectChainCompressorHighKnee init 60
gkVocalEffectChainCompressorRatio init .5
gkVocalEffectChainCompressorAttack init .1
gkVocalEffectChainCompressorRelease init .5
giVocalEffectChainCompressorLookahead init .02

instr VocalEffectChainCompressorInput
  aVocalEffectChainCompressorInL inleta "InL"
  aVocalEffectChainCompressorInR inleta "InR"

  aVocalEffectChainCompressorOutWetL, aVocalEffectChainCompressorOutWetR, aVocalEffectChainCompressorOutDryL, aVocalEffectChainCompressorOutDryR bypassSwitch aVocalEffectChainCompressorInL, aVocalEffectChainCompressorInR, gkVocalEffectChainCompressorDryAmount, gkVocalEffectChainCompressorWetAmount, "VocalEffectChainCompressor"

  outleta "OutWetL", aVocalEffectChainCompressorOutWetL
  outleta "OutWetR", aVocalEffectChainCompressorOutWetR

  outleta "OutDryL", aVocalEffectChainCompressorOutDryL
  outleta "OutDryR", aVocalEffectChainCompressorOutDryR
endin

instr VocalEffectChainCompressor
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"

  aSignalOutL = aSignalInL
  aSignalOutR = aSignalInR

    if giVocalEffectChainCompressorMode == 0 then
        aSignalOutL compress aSignalInL, aSignalInL, gkVocalEffectChainCompressorThreshold, gkVocalEffectChainCompressorLowKnee, gkVocalEffectChainCompressorHighKnee, gkVocalEffectChainCompressorRatio, gkVocalEffectChainCompressorAttack, gkVocalEffectChainCompressorRelease, giVocalEffectChainCompressorLookahead
        aSignalOutR compress aSignalInR, aSignalInR, gkVocalEffectChainCompressorThreshold, gkVocalEffectChainCompressorLowKnee, gkVocalEffectChainCompressorHighKnee, gkVocalEffectChainCompressorRatio, gkVocalEffectChainCompressorAttack, gkVocalEffectChainCompressorRelease, giVocalEffectChainCompressorLookahead
    else
        aSignalOutL compress2 aSignalInL, aSignalInL, gkVocalEffectChainCompressorThreshold, gkVocalEffectChainCompressorLowKnee, gkVocalEffectChainCompressorHighKnee, gkVocalEffectChainCompressorRatio, gkVocalEffectChainCompressorAttack, gkVocalEffectChainCompressorRelease, giVocalEffectChainCompressorLookahead
        aSignalOutR compress2 aSignalInR, aSignalInR, gkVocalEffectChainCompressorThreshold, gkVocalEffectChainCompressorLowKnee, gkVocalEffectChainCompressorHighKnee, gkVocalEffectChainCompressorRatio, gkVocalEffectChainCompressorAttack, gkVocalEffectChainCompressorRelease, giVocalEffectChainCompressorLookahead
    endif

  aSignalOutL *= gkVocalEffectChainCompressorRatio^2
  aSignalOutR *= gkVocalEffectChainCompressorRatio^2

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr VocalEffectChainCompressorAmountKnob
  gkVocalEffectChainCompressorAmount linseg p4, p3, p5
endin

instr VocalEffectChainCompressorBassKnob
  gkVocalEffectChainCompressorEqBass linseg p4, p3, p5
endin

instr VocalEffectChainCompressorMidKnob
  gkVocalEffectChainCompressorEqMid linseg p4, p3, p5
endin

instr VocalEffectChainCompressorHighKnob
  gkVocalEffectChainCompressorEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainCompressorFader
  gkVocalEffectChainCompressorFader linseg p4, p3, p5
endin

instr VocalEffectChainCompressorPan
  gkVocalEffectChainCompressorPan linseg p4, p3, p5
endin

instr VocalEffectChainCompressorMixerChannel
  aVocalEffectChainCompressorL inleta "InL"
  aVocalEffectChainCompressorR inleta "InR"

  aVocalEffectChainCompressorL, aVocalEffectChainCompressorR mixerChannel aVocalEffectChainCompressorL, aVocalEffectChainCompressorR, gkVocalEffectChainCompressorFader, gkVocalEffectChainCompressorPan, gkVocalEffectChainCompressorEqBass, gkVocalEffectChainCompressorEqMid, gkVocalEffectChainCompressorEqHigh

  outleta "OutL", aVocalEffectChainCompressorL
  outleta "OutR", aVocalEffectChainCompressorR
endin
