bypassRoute "DistortionExamples", "Mixer", "Mixer"

alwayson "DistortionExamplesInput"
alwayson "DistortionExamplesMixerChannel"

gkDistortionExamplesEqBass init 1
gkDistortionExamplesEqMid init 1
gkDistortionExamplesEqHigh init 1
gkDistortionExamplesFader init 1
gkDistortionExamplesPan init 50

gkPreGain init 10
gkPostGain init 1
gkDutyCycleOffset init .01
gkSlopeOffset init .01
giDistortionExamplesMode init 5

gkDistortionExamplesWetAmmount init 1
gkDistortionExamplesDryAmmount init 0

instr DistortionExamplesInput
  aDistortionExamplesInL inleta "InL"
  aDistortionExamplesInR inleta "InR"

  aDistortionExamplesOutWetL, aDistortionExamplesOutWetR, aDistortionExamplesOutDryL, aDistortionExamplesOutDryR bypassSwitch aDistortionExamplesInL, aDistortionExamplesInR, gkDistortionExamplesDryAmmount, gkDistortionExamplesWetAmmount, "DistortionExamples"

  outleta "OutWetL", aDistortionExamplesOutWetL
  outleta "OutWetR", aDistortionExamplesOutWetR

  outleta "OutDryL", aDistortionExamplesOutDryL
  outleta "OutDryR", aDistortionExamplesOutDryR
endin

instr DistortionExamples
  aDistortionExamplesInL inleta "InL"
  aDistortionExamplesInR inleta "InR"

  aDistortionExamplesOutL = aDistortionExamplesInL
  aDistortionExamplesOutR = aDistortionExamplesInR

  iBalanceSignal = 0

  /* ********
      clip
     ********
  */
  if giDistortionExamplesMode == 1 then
    iMethod = 0
    iLimit = .1
    iArg = 0

    aDistortionExamplesOutL clip aDistortionExamplesInL * gkPreGain, iMethod, iLimit, iArg
    aDistortionExamplesOutR clip aDistortionExamplesInR * gkPreGain, iMethod, iLimit, iArg
  endif

  /* ********
      distort
     ********
  */
  if giDistortionExamplesMode == 2 then
    kDistortionAmount = 1
    iLowPassFilterHalfPowerPoint = 10
    iWaveShape ftgen 0,0, 257, 9, .5,1,270

    aDistortionExamplesOutL distort aDistortionExamplesInL * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    aDistortionExamplesOutR distort aDistortionExamplesInR * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
  endif


  /* ********
      distort1
     ********
  */
  if giDistortionExamplesMode == 3 then
    kWaveShape1 = 0
    kWaveShape2 = 0

    aDistortionExamplesOutL distort1 aDistortionExamplesInL, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2
    aDistortionExamplesOutR distort1 aDistortionExamplesInR, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2

    iMethod = 0
    iLimit = .01
    iArg = 0

    ;aDistortionExamplesOutL clip aDistortionExamplesOutL, iMethod, iLimit, iArg
    ;aDistortionExamplesOutR clip aDistortionExamplesOutR, iMethod, iLimit, iArg
  endif

  /* ********
      pdhalf
     ********
  */
  if giDistortionExamplesMode == 4 then
    kShapeAmount = 1
    iBipolar = 0
    iFullScale = .0001

    aDistortionExamplesOutL pdhalf aDistortionExamplesOutL, kShapeAmount, iBipolar, iFullScale
    aDistortionExamplesOutR pdhalf aDistortionExamplesOutR, kShapeAmount, iBipolar, iFullScale
  endif

  /* ********
      custom hansDistortion
     ********
  */

  if giDistortionExamplesMode == 5 then
    iBalanceSignal = 0

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aDistortionExamplesOutL hansDistortion aDistortionExamplesOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight
    aDistortionExamplesOutR hansDistortion aDistortionExamplesOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight

    aDistortionExamplesOutL butterlp aDistortionExamplesOutL, 5000
    aDistortionExamplesOutR butterlp aDistortionExamplesOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aDistortionExamplesOutL balance aDistortionExamplesOutL, aDistortionExamplesInL
    aDistortionExamplesOutR balance aDistortionExamplesOutR, aDistortionExamplesInR
  endif

  outleta "OutL", aDistortionExamplesOutL
  outleta "OutR", aDistortionExamplesOutR
endin

instr DistortionExamplesPreGainKnob
  gkPreGain linseg p4, p3, p5
endin

instr DistortionExamplesPostGainKnob
  gkPostGain linseg p4, p3, p5
endin

instr DistortionExamplesDutyCycleOffsetKnob
  gkDutyCycleOffset linseg p4, p3, p5
endin

instr DistortionExamplesSlopeOffsetKnob
  gkSlopeOffset linseg p4, p3, p5
endin

instr DistortionExamplesBassKnob
  gkDistortionExamplesEqBass linseg p4, p3, p5
endin

instr DistortionExamplesMidKnob
  gkDistortionExamplesEqMid linseg p4, p3, p5
endin

instr DistortionExamplesHighKnob
  gkDistortionExamplesEqHigh linseg p4, p3, p5
endin

instr DistortionExamplesFader
  gkDistortionExamplesFader linseg p4, p3, p5
endin

instr DistortionExamplesPan
  gkDistortionExamplesPan linseg p4, p3, p5
endin

instr DistortionExamplesMixerChannel
  aDistortionExamplesL inleta "InL"
  aDistortionExamplesR inleta "InR"

  aDistortionExamplesL, aDistortionExamplesR mixerChannel aDistortionExamplesL, aDistortionExamplesR, gkDistortionExamplesFader, gkDistortionExamplesPan, gkDistortionExamplesEqBass, gkDistortionExamplesEqMid, gkDistortionExamplesEqHigh

  outleta "OutL", aDistortionExamplesL
  outleta "OutR", aDistortionExamplesR
endin
