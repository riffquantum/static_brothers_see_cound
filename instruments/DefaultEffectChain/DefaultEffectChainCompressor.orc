alwayson "DefaultEffectChainCompressorInput"
alwayson "DefaultEffectChainCompressorMixerChannel"

bypassRoute "DefaultEffectChainCompressor", "DefaultEffectChainPitchShifterInput", "DefaultEffectChainPitchShifterInput"

gkDefaultEffectChainCompressorEqBass init 1
gkDefaultEffectChainCompressorEqMid init 1
gkDefaultEffectChainCompressorEqHigh init 1
gkDefaultEffectChainCompressorFader init 1
gkDefaultEffectChainCompressorPan init 50

gkDefaultEffectChainCompressorDryAmount init 0
gkDefaultEffectChainCompressorWetAmount init 1
giDefaultEffectChainCompressorMode init 0

gkDefaultEffectChainCompressorThreshold init 0
gkDefaultEffectChainCompressorLowKnee init 40
gkDefaultEffectChainCompressorHighKnee init 60
gkDefaultEffectChainCompressorRatio init .5
gkDefaultEffectChainCompressorAttack init .1
gkDefaultEffectChainCompressorRelease init .5
giDefaultEffectChainCompressorLookahead init .02

instr DefaultEffectChainCompressorInput
  aDefaultEffectChainCompressorInL inleta "InL"
  aDefaultEffectChainCompressorInR inleta "InR"

  aDefaultEffectChainCompressorOutWetL, aDefaultEffectChainCompressorOutWetR, aDefaultEffectChainCompressorOutDryL, aDefaultEffectChainCompressorOutDryR bypassSwitch aDefaultEffectChainCompressorInL, aDefaultEffectChainCompressorInR, gkDefaultEffectChainCompressorDryAmount, gkDefaultEffectChainCompressorWetAmount, "DefaultEffectChainCompressor"

  outleta "OutWetL", aDefaultEffectChainCompressorOutWetL
  outleta "OutWetR", aDefaultEffectChainCompressorOutWetR

  outleta "OutDryL", aDefaultEffectChainCompressorOutDryL
  outleta "OutDryR", aDefaultEffectChainCompressorOutDryR
endin

instr DefaultEffectChainCompressor
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"

  aSignalOutL = aSignalInL
  aSignalOutR = aSignalInR

    if giDefaultEffectChainCompressorMode == 0 then
        aSignalOutL compress aSignalInL, aSignalInL, gkDefaultEffectChainCompressorThreshold, gkDefaultEffectChainCompressorLowKnee, gkDefaultEffectChainCompressorHighKnee, gkDefaultEffectChainCompressorRatio, gkDefaultEffectChainCompressorAttack, gkDefaultEffectChainCompressorRelease, giDefaultEffectChainCompressorLookahead
        aSignalOutR compress aSignalInR, aSignalInR, gkDefaultEffectChainCompressorThreshold, gkDefaultEffectChainCompressorLowKnee, gkDefaultEffectChainCompressorHighKnee, gkDefaultEffectChainCompressorRatio, gkDefaultEffectChainCompressorAttack, gkDefaultEffectChainCompressorRelease, giDefaultEffectChainCompressorLookahead
    else
        aSignalOutL compress2 aSignalInL, aSignalInL, gkDefaultEffectChainCompressorThreshold, gkDefaultEffectChainCompressorLowKnee, gkDefaultEffectChainCompressorHighKnee, gkDefaultEffectChainCompressorRatio, gkDefaultEffectChainCompressorAttack, gkDefaultEffectChainCompressorRelease, giDefaultEffectChainCompressorLookahead
        aSignalOutR compress2 aSignalInR, aSignalInR, gkDefaultEffectChainCompressorThreshold, gkDefaultEffectChainCompressorLowKnee, gkDefaultEffectChainCompressorHighKnee, gkDefaultEffectChainCompressorRatio, gkDefaultEffectChainCompressorAttack, gkDefaultEffectChainCompressorRelease, giDefaultEffectChainCompressorLookahead
    endif

  aSignalOutL *= gkDefaultEffectChainCompressorRatio^2
  aSignalOutR *= gkDefaultEffectChainCompressorRatio^2

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr DefaultEffectChainCompressorAmountKnob
  gkDefaultEffectChainCompressorAmount linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorBassKnob
  gkDefaultEffectChainCompressorEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorMidKnob
  gkDefaultEffectChainCompressorEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorHighKnob
  gkDefaultEffectChainCompressorEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorFader
  gkDefaultEffectChainCompressorFader linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorPan
  gkDefaultEffectChainCompressorPan linseg p4, p3, p5
endin

instr DefaultEffectChainCompressorMixerChannel
  aDefaultEffectChainCompressorL inleta "InL"
  aDefaultEffectChainCompressorR inleta "InR"

  aDefaultEffectChainCompressorL, aDefaultEffectChainCompressorR mixerChannel aDefaultEffectChainCompressorL, aDefaultEffectChainCompressorR, gkDefaultEffectChainCompressorFader, gkDefaultEffectChainCompressorPan, gkDefaultEffectChainCompressorEqBass, gkDefaultEffectChainCompressorEqMid, gkDefaultEffectChainCompressorEqHigh

  outleta "OutL", aDefaultEffectChainCompressorL
  outleta "OutR", aDefaultEffectChainCompressorR
endin
