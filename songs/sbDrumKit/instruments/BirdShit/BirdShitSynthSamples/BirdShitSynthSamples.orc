alwayson "BirdShitSynthSamplesMixerChannel"

gSBirdShitSynthSamplesName = "BirdShitSynthSamples"
gSBirdShitSynthSamplesRoute = "Mixer"
instrumentRoute gSBirdShitSynthSamplesName, gSBirdShitSynthSamplesRoute
gkBirdShitSynthSamplesEqBass init 1
gkBirdShitSynthSamplesEqMid init 1
gkBirdShitSynthSamplesEqHigh init 1
gkBirdShitSynthSamplesFader init 1
gkBirdShitSynthSamplesPan init 50

gSBirdShitSynthSamplesPath1 ="localSamples/Birdshit/BirdShitSynthSample1.wav"
giBirdShitSynthSamplesTableLength1 getTableSizeFromSample gSBirdShitSynthSamplesPath1
giBirdShitSynthSamples1 ftgen 0, 0, giBirdShitSynthSamplesTableLength1, 1, gSBirdShitSynthSamplesPath1, 0, 0, 0

gSBirdShitSynthSamplesPath2 ="localSamples/Birdshit/BirdShitSynthSample2.wav"
giBirdShitSynthSamplesTableLength2 getTableSizeFromSample gSBirdShitSynthSamplesPath2
giBirdShitSynthSamples2 ftgen 0, 0, giBirdShitSynthSamplesTableLength2, 1, gSBirdShitSynthSamplesPath2, 0, 0, 0


instr BirdShitSynthSamples
  iAmplitude = flexibleAmplitudeInput(p4)
  iSampleNumber = p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 1, 0
  iSample = iSampleNumber == 1 ? giBirdShitSynthSamples1 : giBirdShitSynthSamples2

  aBirdShitSynthSample loscil kAmplitudeEnvelope, 1, iSample, 1

  outleta "OutL", aBirdShitSynthSample
  outleta "OutR", aBirdShitSynthSample
endin

instr BirdShitSynthSamplesBassKnob
  gkBirdShitSynthSamplesEqBass linseg p4, p3, p5
endin

instr BirdShitSynthSamplesMidKnob
  gkBirdShitSynthSamplesEqMid linseg p4, p3, p5
endin

instr BirdShitSynthSamplesHighKnob
  gkBirdShitSynthSamplesEqHigh linseg p4, p3, p5
endin

instr BirdShitSynthSamplesFader
  gkBirdShitSynthSamplesFader linseg p4, p3, p5
endin

instr BirdShitSynthSamplesPan
  gkBirdShitSynthSamplesPan linseg p4, p3, p5
endin

instr BirdShitSynthSamplesMixerChannel
  aBirdShitSynthSamplesL inleta "InL"
  aBirdShitSynthSamplesR inleta "InR"

  kBirdShitSynthSamplesFader = gkBirdShitSynthSamplesFader
  kBirdShitSynthSamplesPan = gkBirdShitSynthSamplesPan
  kBirdShitSynthSamplesEqBass = gkBirdShitSynthSamplesEqBass
  kBirdShitSynthSamplesEqMid = gkBirdShitSynthSamplesEqMid
  kBirdShitSynthSamplesEqHigh = gkBirdShitSynthSamplesEqHigh

  aBirdShitSynthSamplesL, aBirdShitSynthSamplesR threeBandEqStereo aBirdShitSynthSamplesL, aBirdShitSynthSamplesR, kBirdShitSynthSamplesEqBass, kBirdShitSynthSamplesEqMid, kBirdShitSynthSamplesEqHigh

  if kBirdShitSynthSamplesPan > 100 then
      kBirdShitSynthSamplesPan = 100
  elseif kBirdShitSynthSamplesPan < 0 then
      kBirdShitSynthSamplesPan = 0
  endif

  aBirdShitSynthSamplesL = (aBirdShitSynthSamplesL * ((100 - kBirdShitSynthSamplesPan) * 2 / 100)) * kBirdShitSynthSamplesFader
  aBirdShitSynthSamplesR = (aBirdShitSynthSamplesR * (kBirdShitSynthSamplesPan * 2 / 100)) * kBirdShitSynthSamplesFader

  outleta "OutL", aBirdShitSynthSamplesL
  outleta "OutR", aBirdShitSynthSamplesR
endin
