bypassRoute "VocalEffectChainDistortion", "VocalEffectChainMultiStageDistortionInput", "VocalEffectChainMultiStageDistortionInput"

alwayson "VocalEffectChainDistortionInput"
alwayson "VocalEffectChainDistortionMixerChannel"

gkVocalEffectChainDistortionEqBass init 1
gkVocalEffectChainDistortionEqMid init 1
gkVocalEffectChainDistortionEqHigh init 1
gkVocalEffectChainDistortionFader init 1
gkVocalEffectChainDistortionPan init 50

gkPreGain init 10
gkPostGain init 1
gkDutyCycleOffset init .01
gkSlopeOffset init .01
giVocalEffectChainDistortionMode init 5

gkVocalEffectChainDistortionWetAmount init 1
gkVocalEffectChainDistortionDryAmount init 0

instr VocalEffectChainDistortionInput
  aVocalEffectChainDistortionInL inleta "InL"
  aVocalEffectChainDistortionInR inleta "InR"

  aVocalEffectChainDistortionOutWetL, aVocalEffectChainDistortionOutWetR, aVocalEffectChainDistortionOutDryL, aVocalEffectChainDistortionOutDryR bypassSwitch aVocalEffectChainDistortionInL, aVocalEffectChainDistortionInR, gkVocalEffectChainDistortionDryAmount, gkVocalEffectChainDistortionWetAmount, "VocalEffectChainDistortion"

  outleta "OutWetL", aVocalEffectChainDistortionOutWetL
  outleta "OutWetR", aVocalEffectChainDistortionOutWetR

  outleta "OutDryL", aVocalEffectChainDistortionOutDryL
  outleta "OutDryR", aVocalEffectChainDistortionOutDryR
endin

instr VocalEffectChainDistortion
  aVocalEffectChainDistortionInL inleta "InL"
  aVocalEffectChainDistortionInR inleta "InR"

  aVocalEffectChainDistortionOutL = aVocalEffectChainDistortionInL
  aVocalEffectChainDistortionOutR = aVocalEffectChainDistortionInR

  iBalanceSignal = 0

  /* ********
      clip
     ********
  */
  if giVocalEffectChainDistortionMode == 1 then
    iMethod = 0
    iLimit = .1
    iArg = 0

    aVocalEffectChainDistortionOutL clip aVocalEffectChainDistortionInL * gkPreGain, iMethod, iLimit, iArg
    aVocalEffectChainDistortionOutR clip aVocalEffectChainDistortionInR * gkPreGain, iMethod, iLimit, iArg
  endif

  /* ********
      distort
     ********
  */
  if giVocalEffectChainDistortionMode == 2 then
    kDistortionAmount = 1
    iLowPassFilterHalfPowerPoint = 10
    iWaveShape ftgen 0,0, 257, 9, .5,1,270

    aVocalEffectChainDistortionOutL distort aVocalEffectChainDistortionInL * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    aVocalEffectChainDistortionOutR distort aVocalEffectChainDistortionInR * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
  endif


  /* ********
      distort1
     ********
  */
  if giVocalEffectChainDistortionMode == 3 then
    kWaveShape1 = 0
    kWaveShape2 = 0

    aVocalEffectChainDistortionOutL distort1 aVocalEffectChainDistortionInL, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2
    aVocalEffectChainDistortionOutR distort1 aVocalEffectChainDistortionInR, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2

    iMethod = 0
    iLimit = .01
    iArg = 0

    ;aVocalEffectChainDistortionOutL clip aVocalEffectChainDistortionOutL, iMethod, iLimit, iArg
    ;aVocalEffectChainDistortionOutR clip aVocalEffectChainDistortionOutR, iMethod, iLimit, iArg
  endif

  /* ********
      pdhalf
     ********
  */
  if giVocalEffectChainDistortionMode == 4 then
    kShapeAmount = 1
    iBipolar = 0
    iFullScale = .0001

    aVocalEffectChainDistortionOutL pdhalf aVocalEffectChainDistortionOutL, kShapeAmount, iBipolar, iFullScale
    aVocalEffectChainDistortionOutR pdhalf aVocalEffectChainDistortionOutR, kShapeAmount, iBipolar, iFullScale
  endif

  /* ********
      custom hansDistortion
     ********
  */

  if giVocalEffectChainDistortionMode == 5 then
    iBalanceSignal = 0

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aVocalEffectChainDistortionOutL hansDistortion aVocalEffectChainDistortionOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight
    aVocalEffectChainDistortionOutR hansDistortion aVocalEffectChainDistortionOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight

    aVocalEffectChainDistortionOutL butterlp aVocalEffectChainDistortionOutL, 5000
    aVocalEffectChainDistortionOutR butterlp aVocalEffectChainDistortionOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aVocalEffectChainDistortionOutL balance aVocalEffectChainDistortionOutL, aVocalEffectChainDistortionInL
    aVocalEffectChainDistortionOutR balance aVocalEffectChainDistortionOutR, aVocalEffectChainDistortionInR
  endif

  outleta "OutL", aVocalEffectChainDistortionOutL
  outleta "OutR", aVocalEffectChainDistortionOutR
endin

instr VocalEffectChainDistortionPreGainKnob
  gkPreGain linseg p4, p3, p5
endin

instr VocalEffectChainDistortionPostGainKnob
  gkPostGain linseg p4, p3, p5
endin

instr VocalEffectChainDistortionDutyCycleOffsetKnob
  gkDutyCycleOffset linseg p4, p3, p5
endin

instr VocalEffectChainDistortionSlopeOffsetKnob
  gkSlopeOffset linseg p4, p3, p5
endin

instr VocalEffectChainDistortionBassKnob
  gkVocalEffectChainDistortionEqBass linseg p4, p3, p5
endin

instr VocalEffectChainDistortionMidKnob
  gkVocalEffectChainDistortionEqMid linseg p4, p3, p5
endin

instr VocalEffectChainDistortionHighKnob
  gkVocalEffectChainDistortionEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainDistortionFader
  gkVocalEffectChainDistortionFader linseg p4, p3, p5
endin

instr VocalEffectChainDistortionPan
  gkVocalEffectChainDistortionPan linseg p4, p3, p5
endin

instr VocalEffectChainDistortionMixerChannel
  aVocalEffectChainDistortionL inleta "InL"
  aVocalEffectChainDistortionR inleta "InR"

  aVocalEffectChainDistortionL, aVocalEffectChainDistortionR mixerChannel aVocalEffectChainDistortionL, aVocalEffectChainDistortionR, gkVocalEffectChainDistortionFader, gkVocalEffectChainDistortionPan, gkVocalEffectChainDistortionEqBass, gkVocalEffectChainDistortionEqMid, gkVocalEffectChainDistortionEqHigh

  outleta "OutL", aVocalEffectChainDistortionL
  outleta "OutR", aVocalEffectChainDistortionR
endin
