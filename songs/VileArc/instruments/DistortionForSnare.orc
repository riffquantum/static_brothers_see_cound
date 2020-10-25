bypassRoute "DistortionForSnare", "FlangeDelayForSnareInput", "FlangeDelayForSnareInput"

alwayson "DistortionForSnareInput"
alwayson "DistortionForSnareMixerChannel"

gkDistortionForSnareEqBass init 1
gkDistortionForSnareEqMid init 1
gkDistortionForSnareEqHigh init 1
gkDistortionForSnareFader init 1
gkDistortionForSnarePan init 50

gkPreGain init 1000
gkPostGain init 1
gkDutyCycleOffset init .01
gkSlopeOffset init .01
giDistortionForSnareMode init 2

gkDistortionForSnareWetAmount init 1
gkDistortionForSnareDryAmount init 0

instr DistortionForSnareInput
  aDistortionForSnareInL inleta "InL"
  aDistortionForSnareInR inleta "InR"

  aDistortionForSnareOutWetL, aDistortionForSnareOutWetR, aDistortionForSnareOutDryL, aDistortionForSnareOutDryR bypassSwitch aDistortionForSnareInL, aDistortionForSnareInR, gkDistortionForSnareDryAmount, gkDistortionForSnareWetAmount, "DistortionForSnare"

  outleta "OutWetL", aDistortionForSnareOutWetL
  outleta "OutWetR", aDistortionForSnareOutWetR

  outleta "OutDryL", aDistortionForSnareOutDryL
  outleta "OutDryR", aDistortionForSnareOutDryR
endin

instr DistortionForSnare
  aDistortionForSnareInL inleta "InL"
  aDistortionForSnareInR inleta "InR"

  aDistortionForSnareOutL = aDistortionForSnareInL
  aDistortionForSnareOutR = aDistortionForSnareInR

  iBalanceSignal = 0

  /* ********
      clip
     ********
  */
  if giDistortionForSnareMode == 1 then
    iMethod = 0
    iLimit = .1
    iArg = 0

    aDistortionForSnareOutL clip aDistortionForSnareInL * gkPreGain, iMethod, iLimit, iArg
    aDistortionForSnareOutR clip aDistortionForSnareInR * gkPreGain, iMethod, iLimit, iArg
  endif

  /* ********
      distort
     ********
  */
  if giDistortionForSnareMode == 2 then
    kDistortionAmount = 1
    iLowPassFilterHalfPowerPoint = 10
    iWaveShape ftgen 0,0, 257, 9, .5,1,270

    aDistortionForSnareOutL distort aDistortionForSnareInL * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    aDistortionForSnareOutR distort aDistortionForSnareInR * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
  endif


  /* ********
      distort1
     ********
  */
  if giDistortionForSnareMode == 3 then
    kWaveShape1 = 0
    kWaveShape2 = 0

    aDistortionForSnareOutL distort1 aDistortionForSnareInL, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2
    aDistortionForSnareOutR distort1 aDistortionForSnareInR, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2

    iMethod = 0
    iLimit = .01
    iArg = 0

    ;aDistortionForSnareOutL clip aDistortionForSnareOutL, iMethod, iLimit, iArg
    ;aDistortionForSnareOutR clip aDistortionForSnareOutR, iMethod, iLimit, iArg
  endif

  /* ********
      pdhalf
     ********
  */
  if giDistortionForSnareMode == 4 then
    kShapeAmount = 1
    iBipolar = 0
    iFullScale = .0001

    aDistortionForSnareOutL pdhalf aDistortionForSnareOutL, kShapeAmount, iBipolar, iFullScale
    aDistortionForSnareOutR pdhalf aDistortionForSnareOutR, kShapeAmount, iBipolar, iFullScale
  endif

  /* ********
      custom hansDistortion
     ********
  */

  if giDistortionForSnareMode == 5 then
    iBalanceSignal = 0

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aDistortionForSnareOutL hansDistortion aDistortionForSnareOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight
    aDistortionForSnareOutR hansDistortion aDistortionForSnareOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight

    aDistortionForSnareOutL butterlp aDistortionForSnareOutL, 5000
    aDistortionForSnareOutR butterlp aDistortionForSnareOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aDistortionForSnareOutL balance aDistortionForSnareOutL, aDistortionForSnareInL
    aDistortionForSnareOutR balance aDistortionForSnareOutR, aDistortionForSnareInR
  endif

  outleta "OutL", aDistortionForSnareOutL
  outleta "OutR", aDistortionForSnareOutR
endin

instr DistortionForSnarePreGainKnob
  gkPreGain linseg p4, p3, p5
endin

instr DistortionForSnarePostGainKnob
  gkPostGain linseg p4, p3, p5
endin

instr DistortionForSnareDutyCycleOffsetKnob
  gkDutyCycleOffset linseg p4, p3, p5
endin

instr DistortionForSnareSlopeOffsetKnob
  gkSlopeOffset linseg p4, p3, p5
endin

instr DistortionForSnareBassKnob
  gkDistortionForSnareEqBass linseg p4, p3, p5
endin

instr DistortionForSnareMidKnob
  gkDistortionForSnareEqMid linseg p4, p3, p5
endin

instr DistortionForSnareHighKnob
  gkDistortionForSnareEqHigh linseg p4, p3, p5
endin

instr DistortionForSnareFader
  gkDistortionForSnareFader linseg p4, p3, p5
endin

instr DistortionForSnarePan
  gkDistortionForSnarePan linseg p4, p3, p5
endin

instr DistortionForSnareMixerChannel
  aDistortionForSnareL inleta "InL"
  aDistortionForSnareR inleta "InR"

  aDistortionForSnareL, aDistortionForSnareR mixerChannel aDistortionForSnareL, aDistortionForSnareR, gkDistortionForSnareFader, gkDistortionForSnarePan, gkDistortionForSnareEqBass, gkDistortionForSnareEqMid, gkDistortionForSnareEqHigh

  outleta "OutL", aDistortionForSnareL
  outleta "OutR", aDistortionForSnareR
endin
