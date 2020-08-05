bypassRoute "DefaultEffectChainDistortion", "DefaultEffectChainMultiStageDistortionInput", "DefaultEffectChainMultiStageDistortionInput"

alwayson "DefaultEffectChainDistortionInput"
alwayson "DefaultEffectChainDistortionMixerChannel"

gkDefaultEffectChainDistortionEqBass init 1
gkDefaultEffectChainDistortionEqMid init 1
gkDefaultEffectChainDistortionEqHigh init 1
gkDefaultEffectChainDistortionFader init 1
gkDefaultEffectChainDistortionPan init 50

gkPreGain init 10
gkPostGain init 1
gkDutyCycleOffset init .01
gkSlopeOffset init .01
giDefaultEffectChainDistortionMode init 5

gkDefaultEffectChainDistortionWetAmmount init 1
gkDefaultEffectChainDistortionDryAmmount init 0

instr DefaultEffectChainDistortionInput
  aDefaultEffectChainDistortionInL inleta "InL"
  aDefaultEffectChainDistortionInR inleta "InR"

  aDefaultEffectChainDistortionOutWetL, aDefaultEffectChainDistortionOutWetR, aDefaultEffectChainDistortionOutDryL, aDefaultEffectChainDistortionOutDryR bypassSwitch aDefaultEffectChainDistortionInL, aDefaultEffectChainDistortionInR, gkDefaultEffectChainDistortionDryAmmount, gkDefaultEffectChainDistortionWetAmmount, "DefaultEffectChainDistortion"

  outleta "OutWetL", aDefaultEffectChainDistortionOutWetL
  outleta "OutWetR", aDefaultEffectChainDistortionOutWetR

  outleta "OutDryL", aDefaultEffectChainDistortionOutDryL
  outleta "OutDryR", aDefaultEffectChainDistortionOutDryR
endin

instr DefaultEffectChainDistortion
  aDefaultEffectChainDistortionInL inleta "InL"
  aDefaultEffectChainDistortionInR inleta "InR"

  aDefaultEffectChainDistortionOutL = aDefaultEffectChainDistortionInL
  aDefaultEffectChainDistortionOutR = aDefaultEffectChainDistortionInR

  iBalanceSignal = 0

  /* ********
      clip
     ********
  */
  if giDefaultEffectChainDistortionMode == 1 then
    iMethod = 0
    iLimit = .1
    iArg = 0

    aDefaultEffectChainDistortionOutL clip aDefaultEffectChainDistortionInL * gkPreGain, iMethod, iLimit, iArg
    aDefaultEffectChainDistortionOutR clip aDefaultEffectChainDistortionInR * gkPreGain, iMethod, iLimit, iArg
  endif

  /* ********
      distort
     ********
  */
  if giDefaultEffectChainDistortionMode == 2 then
    kDistortionAmount = 1
    iLowPassFilterHalfPowerPoint = 10
    iWaveShape ftgen 0,0, 257, 9, .5,1,270

    aDefaultEffectChainDistortionOutL distort aDefaultEffectChainDistortionInL * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    aDefaultEffectChainDistortionOutR distort aDefaultEffectChainDistortionInR * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
  endif


  /* ********
      distort1
     ********
  */
  if giDefaultEffectChainDistortionMode == 3 then
    kWaveShape1 = 0
    kWaveShape2 = 0

    aDefaultEffectChainDistortionOutL distort1 aDefaultEffectChainDistortionInL, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2
    aDefaultEffectChainDistortionOutR distort1 aDefaultEffectChainDistortionInR, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2

    iMethod = 0
    iLimit = .01
    iArg = 0

    ;aDefaultEffectChainDistortionOutL clip aDefaultEffectChainDistortionOutL, iMethod, iLimit, iArg
    ;aDefaultEffectChainDistortionOutR clip aDefaultEffectChainDistortionOutR, iMethod, iLimit, iArg
  endif

  /* ********
      pdhalf
     ********
  */
  if giDefaultEffectChainDistortionMode == 4 then
    kShapeAmount = 1
    iBipolar = 0
    iFullScale = .0001

    aDefaultEffectChainDistortionOutL pdhalf aDefaultEffectChainDistortionOutL, kShapeAmount, iBipolar, iFullScale
    aDefaultEffectChainDistortionOutR pdhalf aDefaultEffectChainDistortionOutR, kShapeAmount, iBipolar, iFullScale
  endif

  /* ********
      custom hansDistortion
     ********
  */

  if giDefaultEffectChainDistortionMode == 5 then
    iBalanceSignal = 0

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aDefaultEffectChainDistortionOutL hansDistortion aDefaultEffectChainDistortionOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight
    aDefaultEffectChainDistortionOutR hansDistortion aDefaultEffectChainDistortionOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight

    aDefaultEffectChainDistortionOutL butterlp aDefaultEffectChainDistortionOutL, 5000
    aDefaultEffectChainDistortionOutR butterlp aDefaultEffectChainDistortionOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aDefaultEffectChainDistortionOutL balance aDefaultEffectChainDistortionOutL, aDefaultEffectChainDistortionInL
    aDefaultEffectChainDistortionOutR balance aDefaultEffectChainDistortionOutR, aDefaultEffectChainDistortionInR
  endif

  outleta "OutL", aDefaultEffectChainDistortionOutL
  outleta "OutR", aDefaultEffectChainDistortionOutR
endin

instr DefaultEffectChainDistortionPreGainKnob
  gkPreGain linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionPostGainKnob
  gkPostGain linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionDutyCycleOffsetKnob
  gkDutyCycleOffset linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionSlopeOffsetKnob
  gkSlopeOffset linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionBassKnob
  gkDefaultEffectChainDistortionEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionMidKnob
  gkDefaultEffectChainDistortionEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionHighKnob
  gkDefaultEffectChainDistortionEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionFader
  gkDefaultEffectChainDistortionFader linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionPan
  gkDefaultEffectChainDistortionPan linseg p4, p3, p5
endin

instr DefaultEffectChainDistortionMixerChannel
  aDefaultEffectChainDistortionL inleta "InL"
  aDefaultEffectChainDistortionR inleta "InR"

  aDefaultEffectChainDistortionL, aDefaultEffectChainDistortionR mixerChannel aDefaultEffectChainDistortionL, aDefaultEffectChainDistortionR, gkDefaultEffectChainDistortionFader, gkDefaultEffectChainDistortionPan, gkDefaultEffectChainDistortionEqBass, gkDefaultEffectChainDistortionEqMid, gkDefaultEffectChainDistortionEqHigh

  outleta "OutL", aDefaultEffectChainDistortionL
  outleta "OutR", aDefaultEffectChainDistortionR
endin
