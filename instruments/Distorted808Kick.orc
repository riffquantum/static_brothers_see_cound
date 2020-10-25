instrumentRoute "Distorted808Kick", "Mixer"
alwayson "Distorted808KickMixerChannel"

gkDistorted808KickEqBass init 1
gkDistorted808KickEqMid init 1
gkDistorted808KickEqHigh init 1
gkDistorted808KickFader init 1
gkDistorted808KickPan init 50

gSDistorted808KickSamplePath = "localSamples/Drums/TR-808_Kick_005.wav"
gSDistorted808KickSamplePath = "localSamples/Drums/TR-808_Kick_41.wav"
giDistorted808KickSample ftgen 0, 0, 0, 1, gSDistorted808KickSamplePath, 0, 0, 0

gkDistorted808KickDryAmount init 0
gkDistorted808KickWetAmount init 1

gkDistorted808KickPreGain init 10
gkDistorted808KickPostGain init 1
gkDistorted808KickDutyOffset init .01
gkDistorted808KickSlopeShift init .01
giDistorted808KickStage2ClipLevel init 0dbfs/2
giDistorted808KickFinalGainAmount init .25

gkDistorted808KickPitch init 1

instr Distorted808Kick
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5 == 0 ? 1 : p5
  kPitch *= gkDistorted808KickPitch
  iReleaseTime = 0.01

  iSampleLength = nsamp(giDistorted808KickSample) / sr

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, iReleaseTime, 0

  if ftchnls(giDistorted808KickSample) == 1 then
    aDistorted808KickSampleL loscil kAmplitudeEnvelope, kPitch, giDistorted808KickSample, 1, 0
    aDistorted808KickSampleR = aDistorted808KickSampleL
  else
    aDistorted808KickSampleL, aDistorted808KickSampleR loscil kAmplitudeEnvelope, kPitch, giDistorted808KickSample, 1, 0
  endif

  iPreGainInstanceModifier = p6
  iPostGainInstanceModifier = p7
  iDutyOffsetModifier = p8
  iSlopeShiftOffsetModifier = p9
  iStage2ClipLevelInstanceModifier = p10

  aDistorted808KickOutL = aDistorted808KickSampleL
  aDistorted808KickOutR = aDistorted808KickSampleR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkDistorted808KickPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkDistorted808KickPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkDistorted808KickDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkDistorted808KickSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aDistorted808KickOutL hansDistortion aDistorted808KickSampleL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aDistorted808KickOutR hansDistortion aDistorted808KickSampleR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aDistorted808KickOutL butterlp aDistorted808KickOutL, 1000
  aDistorted808KickOutR butterlp aDistorted808KickOutR, 1000

  iStage2ClipLevel = giDistorted808KickStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aDistorted808KickOutR clip aDistorted808KickOutR, 1, iStage2ClipLevel
  aDistorted808KickOutL clip aDistorted808KickOutL, 1, iStage2ClipLevel


  aDistorted808KickOutL butterlp aDistorted808KickOutL, 5000
  aDistorted808KickOutR butterlp aDistorted808KickOutR, 5000

  aDistorted808KickOutL *= giDistorted808KickFinalGainAmount
  aDistorted808KickOutR *= giDistorted808KickFinalGainAmount

  aDistorted808KickOutL *= kDeclick
  aDistorted808KickOutR *= kDeclick


  aDistorted808KickOutL = (aDistorted808KickOutL * gkDistorted808KickWetAmount) + (aDistorted808KickSampleL * gkDistorted808KickDryAmount)
  aDistorted808KickOutR = (aDistorted808KickOutR * gkDistorted808KickWetAmount) + (aDistorted808KickSampleR * gkDistorted808KickDryAmount)


  outleta "OutL", aDistorted808KickOutL
  outleta "OutR", aDistorted808KickOutR
endin


instr Distorted808KickBassKnob
  gkDistorted808KickEqBass linseg p4, p3, p5
endin

instr Distorted808KickMidKnob
  gkDistorted808KickEqMid linseg p4, p3, p5
endin

instr Distorted808KickHighKnob
  gkDistorted808KickEqHigh linseg p4, p3, p5
endin

instr Distorted808KickFader
  gkDistorted808KickFader linseg p4, p3, p5
endin

instr Distorted808KickPan
  gkDistorted808KickPan linseg p4, p3, p5
endin

instr Distorted808KickMixerChannel
  aDistorted808KickL inleta "InL"
  aDistorted808KickR inleta "InR"

  aDistorted808KickL, aDistorted808KickR mixerChannel aDistorted808KickL, aDistorted808KickR, gkDistorted808KickFader, gkDistorted808KickPan, gkDistorted808KickEqBass, gkDistorted808KickEqMid, gkDistorted808KickEqHigh

  outleta "OutL", aDistorted808KickL
  outleta "OutR", aDistorted808KickR
endin
