/* santanaSample3 */


instrumentRoute "santanaSample3", "Mixer"

alwayson "santanaSample3MixerChannel"

gksantanaSample3EqBass init 1
gksantanaSample3EqMid init 1
gksantanaSample3EqHigh init 1
gksantanaSample3Fader init 1
gksantanaSample3Pan init 50

instr santanaSample3
  kamplitude = p4
  ktimewarp = (gkBPM)/112 * 2 * p6
  kresample = 1
  ibeginningTime =  p5
  ioverlap = 20
  iwindowSize = 10

  SsampleFilePath = "localSamples/santanaChosenHourVocal.wav"
  iFileNumChannels filenchnls SsampleFilePath
  isantanaSample3FileSampleRate filesr SsampleFilePath
  isantanaSample3TableLength getTableSizeFromSample SsampleFilePath

  ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
  iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  isantanaSample3Table ftgenonce 0, 0, isantanaSample3TableLength, 1, SsampleFilePath, 0, 0, 0
  isampleTable = isantanaSample3Table

  irandw = 0
  ienvelopeTable = iTable
  itimemode = 0

  if iFileNumChannels == 2 then
    asantanaSample3L, asantanaSample3R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
  elseif iFileNumChannels == 1 then
    asantanaSample3L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    asantanaSample3R = asantanaSample3L
  endif

  outleta "OutL", asantanaSample3L
  outleta "OutR", asantanaSample3R

endin

instr santanaSample3BassKnob
  gksantanaSample3EqBass linseg p4, p3, p5
endin

instr santanaSample3MidKnob
  gksantanaSample3EqMid linseg p4, p3, p5
endin

instr santanaSample3HighKnob
  gksantanaSample3EqHigh linseg p4, p3, p5
endin

instr santanaSample3Fader
  gksantanaSample3Fader linseg p4, p3, p5
endin

instr santanaSample3Pan
  gksantanaSample3Pan linseg p4, p3, p5
endin

instr santanaSample3MixerChannel
  asantanaSample3L inleta "InL"
  asantanaSample3R inleta "InR"

  ksantanaSample3Fader = gksantanaSample3Fader
  ksantanaSample3Pan = gksantanaSample3Pan
  ksantanaSample3EqBass = gksantanaSample3EqBass
  ksantanaSample3EqMid = gksantanaSample3EqMid
  ksantanaSample3EqHigh = gksantanaSample3EqHigh

  asantanaSample3L, asantanaSample3R threeBandEqStereo asantanaSample3L, asantanaSample3R, ksantanaSample3EqBass, ksantanaSample3EqMid, ksantanaSample3EqHigh

  if ksantanaSample3Pan > 100 then
    ksantanaSample3Pan = 100
  elseif ksantanaSample3Pan < 0 then
    ksantanaSample3Pan = 0
  endif

  asantanaSample3L = (asantanaSample3L * ((100 - ksantanaSample3Pan) * 2 / 100)) * ksantanaSample3Fader
  asantanaSample3R = (asantanaSample3R * (ksantanaSample3Pan * 2 / 100)) * ksantanaSample3Fader


  outleta "OutL", asantanaSample3L
  outleta "OutR", asantanaSample3R
endin

