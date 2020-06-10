gSAmenBreakName = "AmenBreak"
gSAmenBreakRoute = "Mixer"
instrumentRoute gSAmenBreakName, gSAmenBreakRoute

alwayson "AmenBreakMixerChannel"

gkAmenBreakEqBass init 1
gkAmenBreakEqMid init 1
gkAmenBreakEqHigh init 1
gkAmenBreakFader init 1
gkAmenBreakPan init 50


instr AmenBreak
  kpitchFactor = p5
  iSkipTimeInBeats = p4

  SAmenBreakFilePath init "songs/untitledJungleTrack/instruments/AmenBreak/amen-break.wav"
  aAmenBreakL, aAmenBreakR breakSamplerDiskin SAmenBreakFilePath, 16, iSkipTimeInBeats, kpitchFactor

  aAmenBreak = aAmenBreakL

  outleta "OutL", aAmenBreakL
  outleta "OutR", aAmenBreakR
endin

instr AmenBreakBassKnob
  gkAmenBreakEqBass linseg p4, p3, p5
endin

instr AmenBreakMidKnob
  gkAmenBreakEqMid linseg p4, p3, p5
endin

instr AmenBreakHighKnob
  gkAmenBreakEqHigh linseg p4, p3, p5
endin

instr AmenBreakFader
  gkAmenBreakFader linseg p4, p3, p5
endin

instr AmenBreakPan
  gkAmenBreakPan linseg p4, p3, p5
endin

instr AmenBreakMixerChannel
  aAmenBreakL inleta "InL"
  aAmenBreakR inleta "InR"

  kAmenBreakFader = gkAmenBreakFader
  kAmenBreakPan = gkAmenBreakPan
  kAmenBreakEqBass = gkAmenBreakEqBass
  kAmenBreakEqMid = gkAmenBreakEqMid
  kAmenBreakEqHigh = gkAmenBreakEqHigh

  aAmenBreakL, aAmenBreakR threeBandEqStereo aAmenBreakL, aAmenBreakR, kAmenBreakEqBass, kAmenBreakEqMid, kAmenBreakEqHigh

  if kAmenBreakPan > 100 then
      kAmenBreakPan = 100
  elseif kAmenBreakPan < 0 then
      kAmenBreakPan = 0
  endif

  aAmenBreakL = (aAmenBreakL * ((100 - kAmenBreakPan) * 2 / 100)) * kAmenBreakFader
  aAmenBreakR = (aAmenBreakR * (kAmenBreakPan * 2 / 100)) * kAmenBreakFader

  outleta "OutL", aAmenBreakL
  outleta "OutR", aAmenBreakR
endin

