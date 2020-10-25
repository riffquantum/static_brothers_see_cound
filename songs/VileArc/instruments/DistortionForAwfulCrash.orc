bypassRoute "DistortionForAwfulCrash", "DelayForAwfulCrashInput", "DelayForAwfulCrashInput"

alwayson "DistortionForAwfulCrashInput"
alwayson "DistortionForAwfulCrash"
alwayson "DistortionForAwfulCrashMixerChannel"

gkDistortionForAwfulCrashEqBass init 1
gkDistortionForAwfulCrashEqMid init 1
gkDistortionForAwfulCrashEqHigh init 1
gkDistortionForAwfulCrashFader init .02
gkDistortionForAwfulCrashPan init 50

gkPreGain init 100
gkPostGain init 1
gkDutyCycleOffset init .01
gkSlopeOffset init .01
giDistortionForAwfulCrashMode init 5

gkDistortionForAwfulCrashWetAmount init 1
gkDistortionForAwfulCrashDryAmount init 0

instr DistortionForAwfulCrashInput
  aDistortionForAwfulCrashInL inleta "InL"
  aDistortionForAwfulCrashInR inleta "InR"

  aDistortionForAwfulCrashOutWetL, aDistortionForAwfulCrashOutWetR, aDistortionForAwfulCrashOutDryL, aDistortionForAwfulCrashOutDryR bypassSwitch aDistortionForAwfulCrashInL, aDistortionForAwfulCrashInR, gkDistortionForAwfulCrashDryAmount, gkDistortionForAwfulCrashWetAmount, "DistortionForAwfulCrash"

  outleta "OutWetL", aDistortionForAwfulCrashOutWetL
  outleta "OutWetR", aDistortionForAwfulCrashOutWetR

  outleta "OutDryL", aDistortionForAwfulCrashOutDryL
  outleta "OutDryR", aDistortionForAwfulCrashOutDryR
endin

instr DistortionForAwfulCrash
  aDistortionForAwfulCrashInL inleta "InL"
  aDistortionForAwfulCrashInR inleta "InR"

  aDistortionForAwfulCrashOutL = aDistortionForAwfulCrashInL
  aDistortionForAwfulCrashOutR = aDistortionForAwfulCrashInR

  iBalanceSignal = 0

  /* ********
      clip
     ********
  */
  if giDistortionForAwfulCrashMode == 1 then
    iMethod = 0
    iLimit = .1
    iArg = 0

    aDistortionForAwfulCrashOutL clip aDistortionForAwfulCrashInL * gkPreGain, iMethod, iLimit, iArg
    aDistortionForAwfulCrashOutR clip aDistortionForAwfulCrashInR * gkPreGain, iMethod, iLimit, iArg
  endif

  /* ********
      distort
     ********
  */
  if giDistortionForAwfulCrashMode == 2 then
    kDistortionAmount = 1
    iLowPassFilterHalfPowerPoint = 10
    iWaveShape ftgen 0,0, 257, 9, .5,1,270

    aDistortionForAwfulCrashOutL distort aDistortionForAwfulCrashInL * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    aDistortionForAwfulCrashOutR distort aDistortionForAwfulCrashInR * gkPreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
  endif


  /* ********
      distort1
     ********
  */
  if giDistortionForAwfulCrashMode == 3 then
    kWaveShape1 = 0
    kWaveShape2 = 0

    aDistortionForAwfulCrashOutL distort1 aDistortionForAwfulCrashInL, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2
    aDistortionForAwfulCrashOutR distort1 aDistortionForAwfulCrashInR, gkPreGain, gkPostGain, kWaveShape1, kWaveShape2

    iMethod = 0
    iLimit = .01
    iArg = 0

    ;aDistortionForAwfulCrashOutL clip aDistortionForAwfulCrashOutL, iMethod, iLimit, iArg
    ;aDistortionForAwfulCrashOutR clip aDistortionForAwfulCrashOutR, iMethod, iLimit, iArg
  endif

  /* ********
      pdhalf
     ********
  */
  if giDistortionForAwfulCrashMode == 4 then
    kShapeAmount = 1
    iBipolar = 0
    iFullScale = .0001

    aDistortionForAwfulCrashOutL pdhalf aDistortionForAwfulCrashOutL, kShapeAmount, iBipolar, iFullScale
    aDistortionForAwfulCrashOutR pdhalf aDistortionForAwfulCrashOutR, kShapeAmount, iBipolar, iFullScale
  endif

  /* ********
      custom hansDistortion
     ********
  */

  if giDistortionForAwfulCrashMode == 5 then
    iBalanceSignal = 0

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aDistortionForAwfulCrashOutL hansDistortion aDistortionForAwfulCrashOutL, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight
    aDistortionForAwfulCrashOutR hansDistortion aDistortionForAwfulCrashOutR, gkPreGain, gkPostGain, gkDutyCycleOffset, gkSlopeOffset, iTableLight

    aDistortionForAwfulCrashOutL butterlp aDistortionForAwfulCrashOutL, 5000
    aDistortionForAwfulCrashOutR butterlp aDistortionForAwfulCrashOutR, 5000

  endif

  if iBalanceSignal == 1 then
    aDistortionForAwfulCrashOutL balance aDistortionForAwfulCrashOutL, aDistortionForAwfulCrashInL
    aDistortionForAwfulCrashOutR balance aDistortionForAwfulCrashOutR, aDistortionForAwfulCrashInR
  endif

  outleta "OutL", aDistortionForAwfulCrashOutL
  outleta "OutR", aDistortionForAwfulCrashOutR
endin

instr DistortionForAwfulCrashPreGainKnob
  gkPreGain linseg p4, p3, p5
endin

instr DistortionForAwfulCrashPostGainKnob
  gkPostGain linseg p4, p3, p5
endin

instr DistortionForAwfulCrashDutyCycleOffsetKnob
  gkDutyCycleOffset linseg p4, p3, p5
endin

instr DistortionForAwfulCrashSlopeOffsetKnob
  gkSlopeOffset linseg p4, p3, p5
endin

instr DistortionForAwfulCrashBassKnob
  gkDistortionForAwfulCrashEqBass linseg p4, p3, p5
endin

instr DistortionForAwfulCrashMidKnob
  gkDistortionForAwfulCrashEqMid linseg p4, p3, p5
endin

instr DistortionForAwfulCrashHighKnob
  gkDistortionForAwfulCrashEqHigh linseg p4, p3, p5
endin

instr DistortionForAwfulCrashFader
  gkDistortionForAwfulCrashFader linseg p4, p3, p5
endin

instr DistortionForAwfulCrashPan
  gkDistortionForAwfulCrashPan linseg p4, p3, p5
endin

instr DistortionForAwfulCrashMixerChannel
  aDistortionForAwfulCrashL inleta "InL"
  aDistortionForAwfulCrashR inleta "InR"

  aDistortionForAwfulCrashL, aDistortionForAwfulCrashR mixerChannel aDistortionForAwfulCrashL, aDistortionForAwfulCrashR, gkDistortionForAwfulCrashFader, gkDistortionForAwfulCrashPan, gkDistortionForAwfulCrashEqBass, gkDistortionForAwfulCrashEqMid, gkDistortionForAwfulCrashEqHigh

  outleta "OutL", aDistortionForAwfulCrashL
  outleta "OutR", aDistortionForAwfulCrashR
endin
