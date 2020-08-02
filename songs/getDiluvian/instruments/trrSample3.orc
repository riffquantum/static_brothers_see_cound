/* trrSample3 */

instrumentRoute "trrSample3", "Mixer"
alwayson "trrSample3MixerChannel"

gktrrSample3EqBass init 1
gktrrSample3EqMid init 1
gktrrSample3EqHigh init 1
gktrrSample3Fader init 1
gktrrSample3Pan init 50

instr trrSample3
  kamplitude = p4
  ktimewarp = .2
  kresample = 1
  ibeginningTime =  2
  ioverlap = 20
  iwindowSize = 10

  SsampleFilePath = "localSamples/tablarasaranga1.wav"
  iFileNumChannels filenchnls SsampleFilePath
  itrrSample3FileSampleRate filesr SsampleFilePath
  itrrSample3TableLength getTableSizeFromSample SsampleFilePath
  ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
  iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  itrrSample3Table ftgenonce 0, 0, itrrSample3TableLength, 1, SsampleFilePath, 0, 0, 0
  isampleTable = itrrSample3Table

  irandw = 0
  ienvelopeTable = iTable
  itimemode = 0

  if iFileNumChannels == 2 then
    atrrSample3L, atrrSample3R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
  elseif iFileNumChannels == 1 then
    atrrSample3L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    atrrSample3R = atrrSample3L
  endif

  outleta "OutL", atrrSample3L
  outleta "OutR", atrrSample3R

endin

instr trrSample3BassKnob
  gktrrSample3EqBass linseg p4, p3, p5
endin

instr trrSample3MidKnob
  gktrrSample3EqMid linseg p4, p3, p5
endin

instr trrSample3HighKnob
  gktrrSample3EqHigh linseg p4, p3, p5
endin

instr trrSample3Fader
  gktrrSample3Fader linseg p4, p3, p5
endin

instr trrSample3Pan
  gktrrSample3Pan linseg p4, p3, p5
endin

instr trrSample3MixerChannel
  atrrSample3L inleta "InL"
  atrrSample3R inleta "InR"

  ktrrSample3Fader = gktrrSample3Fader
  ktrrSample3Pan = gktrrSample3Pan
  ktrrSample3EqBass = gktrrSample3EqBass
  ktrrSample3EqMid = gktrrSample3EqMid
  ktrrSample3EqHigh = gktrrSample3EqHigh

  atrrSample3L, atrrSample3R threeBandEqStereo atrrSample3L, atrrSample3R, ktrrSample3EqBass, ktrrSample3EqMid, ktrrSample3EqHigh

  if ktrrSample3Pan > 100 then
    ktrrSample3Pan = 100
  elseif ktrrSample3Pan < 0 then
    ktrrSample3Pan = 0
  endif

  atrrSample3L = (atrrSample3L * ((100 - ktrrSample3Pan) * 2 / 100)) * ktrrSample3Fader
  atrrSample3R = (atrrSample3R * (ktrrSample3Pan * 2 / 100)) * ktrrSample3Fader


  outleta "OutL", atrrSample3L
  outleta "OutR", atrrSample3R
endin

