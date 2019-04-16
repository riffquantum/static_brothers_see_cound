gSMidiNoteSampleList[giHatPedalNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatPedalNote] filelen gSMidiNoteSampleList[giHatPedalNote]
giMidiNoteInterruptList[giHatPedalNote] ftgen 0, 0, 0, -2, giHatOpenNote

connect "2056", "HatPedalOutL", "HatPedalMixerChannel", "HatPedalInL"
connect "2056", "HatPedalOutR", "HatPedalMixerChannel", "HatPedalInR"

alwayson "HatPedalMixerChannel"

gkHatPedalEqBass init 1
gkHatPedalEqMid init 1
gkHatPedalEqHigh init .1
gkHatPedalFader init 1
gkHatPedalPan init 50

gSHatPedalSample1Path = "songs/sbDrumKit/samples/VA2105_hh.wav"
giHatPedalSample1TableLength getTableSizeFromSample gSHatPedalSample1Path
giHatPedalSample1 ftgen 0, 0, giHatPedalSample1TableLength, 1, gSHatPedalSample1Path, 0, 0, 0

instr 2056 ;HatPedal, PadB9,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aHatPedal loscil kAmplitudeEnvelope, kPitch, giHatPedalSample1, 1

  outleta "HatPedalOutL", aHatPedal
  outleta "HatPedalOutR", aHatPedal
endin

instr HatPedalBassKnob
  gkHatPedalEqBass linseg p4, p3, p5
endin

instr HatPedalMidKnob
  gkHatPedalEqMid linseg p4, p3, p5
endin

instr HatPedalHighKnob
  gkHatPedalEqHigh linseg p4, p3, p5
endin

instr HatPedalFader
  gkHatPedalFader linseg p4, p3, p5
endin

instr HatPedalPan
  gkHatPedalPan linseg p4, p3, p5
endin

instr HatPedalMixerChannel
  aHatPedalL inleta "HatPedalInL"
  aHatPedalR inleta "HatPedalInR"

  kHatPedalFader = gkHatPedalFader
  kHatPedalPan = gkHatPedalPan
  kHatPedalEqBass = gkHatPedalEqBass
  kHatPedalEqMid = gkHatPedalEqMid
  kHatPedalEqHigh = gkHatPedalEqHigh

  aHatPedalL, aHatPedalR threeBandEqStereo aHatPedalL, aHatPedalR, kHatPedalEqBass, kHatPedalEqMid, kHatPedalEqHigh

  if kHatPedalPan > 100 then
      kHatPedalPan = 100
  elseif kHatPedalPan < 0 then
      kHatPedalPan = 0
  endif

  aHatPedalL = (aHatPedalL * ((100 - kHatPedalPan) * 2 / 100)) * kHatPedalFader
  aHatPedalR = (aHatPedalR * (kHatPedalPan * 2 / 100)) * kHatPedalFader

  outleta "HatPedalOutL", aHatPedalL
  outleta "HatPedalOutR", aHatPedalR

endin
