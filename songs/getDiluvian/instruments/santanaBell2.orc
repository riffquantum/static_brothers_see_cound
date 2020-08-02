/* santanaBell2 */

instrumentRoute "santanaBell2", "Mixer"

alwayson "santanaBell2MixerChannel"

gksantanaBell2EqBass init 1
gksantanaBell2EqMid init 1
gksantanaBell2EqHigh init 1
gksantanaBell2Fader init 1
gksantanaBell2Pan init 50

instr santanaBell2
  kamplitude = p4
  ktimewarp = (gkBPM)/112 * 2 * p6
  kresample = 1
  ibeginningTime =  p5
  ioverlap = 20
  iwindowSize = 10

  SsampleFilePath = "localSamples/santanaChosenHourBell2.wav"
  iFileNumChannels filenchnls SsampleFilePath
  isantanaBell2FileSampleRate filesr SsampleFilePath
  isantanaBell2TableLength getTableSizeFromSample SsampleFilePath

  ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
  iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  isantanaBell2Table ftgenonce 0, 0, isantanaBell2TableLength, 1, SsampleFilePath, 0, 0, 0
  isampleTable = isantanaBell2Table

  irandw = 0
  ienvelopeTable = iTable
  itimemode = 0

  if iFileNumChannels == 2 then
    asantanaBell2L, asantanaBell2R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
  elseif iFileNumChannels == 1 then
    asantanaBell2L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    asantanaBell2R = asantanaBell2L
  endif

  outleta "OutL", asantanaBell2L
  outleta "OutR", asantanaBell2R

endin

instr santanaBell2BassKnob
  gksantanaBell2EqBass linseg p4, p3, p5
endin

instr santanaBell2MidKnob
  gksantanaBell2EqMid linseg p4, p3, p5
endin

instr santanaBell2HighKnob
  gksantanaBell2EqHigh linseg p4, p3, p5
endin

instr santanaBell2Fader
  gksantanaBell2Fader linseg p4, p3, p5
endin

instr santanaBell2Pan
  gksantanaBell2Pan linseg p4, p3, p5
endin

instr santanaBell2MixerChannel
  asantanaBell2L inleta "InL"
  asantanaBell2R inleta "InR"

  ksantanaBell2Fader = gksantanaBell2Fader
  ksantanaBell2Pan = gksantanaBell2Pan
  ksantanaBell2EqBass = gksantanaBell2EqBass
  ksantanaBell2EqMid = gksantanaBell2EqMid
  ksantanaBell2EqHigh = gksantanaBell2EqHigh

  asantanaBell2L, asantanaBell2R threeBandEqStereo asantanaBell2L, asantanaBell2R, ksantanaBell2EqBass, ksantanaBell2EqMid, ksantanaBell2EqHigh

  if ksantanaBell2Pan > 100 then
    ksantanaBell2Pan = 100
  elseif ksantanaBell2Pan < 0 then
    ksantanaBell2Pan = 0
  endif

  asantanaBell2L = (asantanaBell2L * ((100 - ksantanaBell2Pan) * 2 / 100)) * ksantanaBell2Fader
  asantanaBell2R = (asantanaBell2R * (ksantanaBell2Pan * 2 / 100)) * ksantanaBell2Fader


  outleta "OutL", asantanaBell2L
  outleta "OutR", asantanaBell2R
endin

