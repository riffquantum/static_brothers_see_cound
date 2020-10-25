/* trrSample2 */
instrumentRoute "trrSample2", "Mixer"
alwayson "trrSample2MixerChannel"

gktrrSample2EqBass init 1
gktrrSample2EqMid init 1
gktrrSample2EqHigh init 1
gktrrSample2Fader init 1
gktrrSample2Pan init 50

instr trrSample2
  kamplitude = p4
  ktimewarp = 120 / 149.5 * .38
  kresample = 1
  ibeginningTime =  0.338
  ioverlap = 20
  iwindowSize = 10

  SsampleFilePath = "localSamples/Ravi Shankar - Tabla Rassa Ranga/tablasitarloop1.wav"
  iFileNumChannels filenchnls SsampleFilePath
  itrrSample2FileSampleRate filesr SsampleFilePath
  itrrSample2TableLength getTableSizeFromSample SsampleFilePath
  ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
  iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  itrrSample2Table ftgenonce 0, 0, itrrSample2TableLength, 1, SsampleFilePath, 0, 0, 0
  isampleTable = itrrSample2Table

  irandw = 0
  ienvelopeTable = iTable
  itimemode = 0

  if iFileNumChannels == 2 then
    atrrSample2L, atrrSample2R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
  elseif iFileNumChannels == 1 then
    atrrSample2L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    atrrSample2R = atrrSample2L
  endif

  outleta "OutL", atrrSample2L
  outleta "OutR", atrrSample2R

endin

instr trrSample2BassKnob
  gktrrSample2EqBass linseg p4, p3, p5
endin

instr trrSample2MidKnob
  gktrrSample2EqMid linseg p4, p3, p5
endin

instr trrSample2HighKnob
  gktrrSample2EqHigh linseg p4, p3, p5
endin

instr trrSample2Fader
  gktrrSample2Fader linseg p4, p3, p5
endin

instr trrSample2Pan
  gktrrSample2Pan linseg p4, p3, p5
endin

instr trrSample2MixerChannel
  atrrSample2L inleta "InL"
  atrrSample2R inleta "InR"

  ktrrSample2Fader = gktrrSample2Fader
  ktrrSample2Pan = gktrrSample2Pan
  ktrrSample2EqBass = gktrrSample2EqBass
  ktrrSample2EqMid = gktrrSample2EqMid
  ktrrSample2EqHigh = gktrrSample2EqHigh

  atrrSample2L, atrrSample2R threeBandEqStereo atrrSample2L, atrrSample2R, ktrrSample2EqBass, ktrrSample2EqMid, ktrrSample2EqHigh

  if ktrrSample2Pan > 100 then
    ktrrSample2Pan = 100
  elseif ktrrSample2Pan < 0 then
    ktrrSample2Pan = 0
  endif

  atrrSample2L = (atrrSample2L * ((100 - ktrrSample2Pan) * 2 / 100)) * ktrrSample2Fader
  atrrSample2R = (atrrSample2R * (ktrrSample2Pan * 2 / 100)) * ktrrSample2Fader


  outleta "OutL", atrrSample2L
  outleta "OutR", atrrSample2R
endin

