gSSharpKickName = "SharpKick"
gSSharpKickRoute = "ReverbForKick"
instrumentRoute gSSharpKickName, gSSharpKickRoute

alwayson "SharpKickMixerChannel"

gkSharpKickEqBass init 1.3
gkSharpKickEqMid init 1
gkSharpKickEqHigh init 1
gkSharpKickFader init 1
gkSharpKickPan init 50

gSSharpKickSamplePath ="songs/sbDrumKit/samples/EA7614_R8_Bd.wav"
giSharpKickSampleTableLength getTableSizeFromSample gSSharpKickSamplePath
giSharpKickSample ftgen 0, 0, giSharpKickSampleTableLength, 1, gSSharpKickSamplePath, 0, 0, 0

instr SharpKick
  iAmplitude  = p4
  kPitch linseg (iAmplitude/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aSharpKickSample loscil kAmplitudeEnvelope, 1, giSharpKickSample, 1

  aSharpKick = aSharpKickSample

  outleta "OutL", aSharpKick
  outleta "OutR", aSharpKick
endin

instr SharpKickBassKnob
  gkSharpKickEqBass linseg p4, p3, p5
endin

instr SharpKickMidKnob
  gkSharpKickEqMid linseg p4, p3, p5
endin

instr SharpKickHighKnob
  gkSharpKickEqHigh linseg p4, p3, p5
endin

instr SharpKickFader
  gkSharpKickFader linseg p4, p3, p5
endin

instr SharpKickPan
  gkSharpKickPan linseg p4, p3, p5
endin

instr SharpKickMixerChannel
  aSharpKickL inleta "InL"
  aSharpKickR inleta "InR"

  kSharpKickFader = gkSharpKickFader
  kSharpKickPan = gkSharpKickPan
  kSharpKickEqBass = gkSharpKickEqBass
  kSharpKickEqMid = gkSharpKickEqMid
  kSharpKickEqHigh = gkSharpKickEqHigh

  aSharpKickL, aSharpKickR threeBandEqStereo aSharpKickL, aSharpKickR, kSharpKickEqBass, kSharpKickEqMid, kSharpKickEqHigh

  if kSharpKickPan > 100 then
      kSharpKickPan = 100
  elseif kSharpKickPan < 0 then
      kSharpKickPan = 0
  endif

  aSharpKickL = (aSharpKickL * ((100 - kSharpKickPan) * 2 / 100)) * kSharpKickFader
  aSharpKickR = (aSharpKickR * (kSharpKickPan * 2 / 100)) * kSharpKickFader

  outleta "OutL", aSharpKickL
  outleta "OutR", aSharpKickR
endin
