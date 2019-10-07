alwayson "DistortionExamples"
alwayson "DistortionExamplesMixerChannel"

gSDistortionExamplesName = "DistortionExamples"
gSDistortionExamplesRoute = "Mixer"
instrumentRoute gSDistortionExamplesName, gSDistortionExamplesRoute

gkDistortionExamplesEqBass init 1
gkDistortionExamplesEqMid init 1
gkDistortionExamplesEqHigh init 1
gkDistortionExamplesFader init 1
gkDistortionExamplesPan init 50

gkPreGain init 1
gkPostGain init 1
gkDutyCycleOffset init .1
gkSlopeOffset init .1
giDistortionExamplesMode init 3

instr DistortionExamples
  aDistortionExamplesInL inleta "DistortionExamplesInL"
  aDistortionExamplesInR inleta "DistortionExamplesInR"

  aDistortionExamplesOutL = aDistortionExamplesInL
  aDistortionExamplesOutR = aDistortionExamplesInR

  iBalanceSignal = 1

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
      custom distortion
     ********
  */

  if giDistortionExamplesMode == 5 then
    iBalanceSignal = 0
    aDistortionExamplesOutL distortion aDistortionExamplesOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset
    aDistortionExamplesOutR distortion aDistortionExamplesOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset

    aDistortionExamplesOutL butterlp aDistortionExamplesOutL, 5000
    aDistortionExamplesOutR butterlp aDistortionExamplesOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aDistortionExamplesOutL balance aDistortionExamplesOutL, aDistortionExamplesInL
    aDistortionExamplesOutR balance aDistortionExamplesOutR, aDistortionExamplesInR
  endif

  outleta "DistortionExamplesOutL", aDistortionExamplesOutL
  outleta "DistortionExamplesOutR", aDistortionExamplesOutR
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
    aDistortionExamplesL inleta "DistortionExamplesInL"
    aDistortionExamplesR inleta "DistortionExamplesInR"

    kDistortionExamplesFader = gkDistortionExamplesFader
    kDistortionExamplesPan = gkDistortionExamplesPan
    kDistortionExamplesEqBass = gkDistortionExamplesEqBass
    kDistortionExamplesEqMid = gkDistortionExamplesEqMid
    kDistortionExamplesEqHigh = gkDistortionExamplesEqHigh

    aDistortionExamplesL, aDistortionExamplesR threeBandEqStereo aDistortionExamplesL, aDistortionExamplesR, kDistortionExamplesEqBass, kDistortionExamplesEqMid, kDistortionExamplesEqHigh

    if kDistortionExamplesPan > 100 then
        kDistortionExamplesPan = 100
    elseif kDistortionExamplesPan < 0 then
        kDistortionExamplesPan = 0
    endif

    aDistortionExamplesL = (aDistortionExamplesL * ((100 - kDistortionExamplesPan) * 2 / 100)) * kDistortionExamplesFader
    aDistortionExamplesR = (aDistortionExamplesR * (kDistortionExamplesPan * 2 / 100)) * kDistortionExamplesFader

    outleta "DistortionExamplesOutL", aDistortionExamplesL
    outleta "DistortionExamplesOutR", aDistortionExamplesR
endin
