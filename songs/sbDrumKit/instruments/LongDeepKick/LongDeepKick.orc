gSLongDeepKickName = "LongDeepKick"
gSLongDeepKickRoute = "Mixer"
instrumentRoute gSLongDeepKickName, gSLongDeepKickRoute


alwayson "LongDeepKickMixerChannel"

gkLongDeepKickEqBass init 1
gkLongDeepKickEqMid init 1
gkLongDeepKickEqHigh init 1
gkLongDeepKickFader init 1
gkLongDeepKickPan init 50

gSLongDeepKickSamplePath ="songs/sbDrumKit/samples/EA7604_R8_Bd.wav"
giLongDeepKickSampleTableLength getTableSizeFromSample gSLongDeepKickSamplePath
giLongDeepKickSample ftgen 0, 0, giLongDeepKickSampleTableLength, 1, gSLongDeepKickSamplePath, 0, 0, 0

instr LongDeepKick
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aLongDeepKickSample loscil kAmplitudeEnvelope, 1, giLongDeepKickSample, 1


  aLongDeepKick = aLongDeepKickSample

  outleta "LongDeepKickOutL", aLongDeepKick
  outleta "LongDeepKickOutR", aLongDeepKick
endin

instr LongDeepKickBassKnob
  gkLongDeepKickEqBass linseg p4, p3, p5
endin

instr LongDeepKickMidKnob
  gkLongDeepKickEqMid linseg p4, p3, p5
endin

instr LongDeepKickHighKnob
  gkLongDeepKickEqHigh linseg p4, p3, p5
endin

instr LongDeepKickFader
  gkLongDeepKickFader linseg p4, p3, p5
endin

instr LongDeepKickPan
  gkLongDeepKickPan linseg p4, p3, p5
endin

instr LongDeepKickMixerChannel
  aLongDeepKickL inleta "LongDeepKickInL"
  aLongDeepKickR inleta "LongDeepKickInR"

  kLongDeepKickFader = gkLongDeepKickFader
  kLongDeepKickPan = gkLongDeepKickPan
  kLongDeepKickEqBass = gkLongDeepKickEqBass
  kLongDeepKickEqMid = gkLongDeepKickEqMid
  kLongDeepKickEqHigh = gkLongDeepKickEqHigh

  aLongDeepKickL, aLongDeepKickR threeBandEqStereo aLongDeepKickL, aLongDeepKickR, kLongDeepKickEqBass, kLongDeepKickEqMid, kLongDeepKickEqHigh

  if kLongDeepKickPan > 100 then
      kLongDeepKickPan = 100
  elseif kLongDeepKickPan < 0 then
      kLongDeepKickPan = 0
  endif

  aLongDeepKickL = (aLongDeepKickL * ((100 - kLongDeepKickPan) * 2 / 100)) * kLongDeepKickFader
  aLongDeepKickR = (aLongDeepKickR * (kLongDeepKickPan * 2 / 100)) * kLongDeepKickFader

  outleta "LongDeepKickOutL", aLongDeepKickL
  outleta "LongDeepKickOutR", aLongDeepKickR
endin
