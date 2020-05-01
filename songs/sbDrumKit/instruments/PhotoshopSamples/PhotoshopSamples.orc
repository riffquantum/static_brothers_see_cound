alwayson "PhotoshopSamplesMixerChannel"

gSPhotoshopSamplesName = "PhotoshopSamples"
gSPhotoshopSamplesRoute = "Mixer"
instrumentRoute gSPhotoshopSamplesName, gSPhotoshopSamplesRoute
gkPhotoshopSamplesEqBass init 1
gkPhotoshopSamplesEqMid init 1
gkPhotoshopSamplesEqHigh init 1
gkPhotoshopSamplesFader init 1
gkPhotoshopSamplesPan init 50

giPhotoshopSampleTables[] init 128

gSPhotoshopSampleClosedHatPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleClosedHat.wav"
giPhotoshopSampleClosedHatTableLength getTableSizeFromSample gSPhotoshopSampleClosedHatPath
giPhotoshopSampleTables[giHatClosedNote] ftgen 0, 0, giPhotoshopSampleClosedHatTableLength, 1, gSPhotoshopSampleClosedHatPath, 0, 0, 0

gSPhotoshopSampleCrashPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleCrash.wav"
giPhotoshopSampleCrashTableLength getTableSizeFromSample gSPhotoshopSampleCrashPath
giPhotoshopSampleTables[giCrashNote] ftgen 0, 0, giPhotoshopSampleCrashTableLength, 1, gSPhotoshopSampleCrashPath, 0, 0, 0

gSPhotoshopSampleGreenPadPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleGreenPad.wav"
giPhotoshopSampleGreenPadTableLength getTableSizeFromSample gSPhotoshopSampleGreenPadPath
giPhotoshopSampleTables[giGreenPadNote] ftgen 0, 0, giPhotoshopSampleGreenPadTableLength, 1, gSPhotoshopSampleGreenPadPath, 0, 0, 0

gSPhotoshopSampleHatPedalPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleHatPedal.wav"
giPhotoshopSampleHatPedalTableLength getTableSizeFromSample gSPhotoshopSampleHatPedalPath
giPhotoshopSampleTables[giHatPedalNote] ftgen 0, 0, giPhotoshopSampleHatPedalTableLength, 1, gSPhotoshopSampleHatPedalPath, 0, 0, 0

gSPhotoshopSampleKickPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleKick.wav"
giPhotoshopSampleKickTableLength getTableSizeFromSample gSPhotoshopSampleKickPath
giPhotoshopSampleTables[giKickNote] ftgen 0, 0, giPhotoshopSampleKickTableLength, 1, gSPhotoshopSampleKickPath, 0, 0, 0

gSPhotoshopSampleOpenHatPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleOpenHat.wav"
giPhotoshopSampleOpenHatTableLength getTableSizeFromSample gSPhotoshopSampleOpenHatPath
giPhotoshopSampleTables[giHatOpenNote] ftgen 0, 0, giPhotoshopSampleOpenHatTableLength, 1, gSPhotoshopSampleOpenHatPath, 0, 0, 0

gSPhotoshopSampleRedPadPath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleRedPad.wav"
giPhotoshopSampleRedPadTableLength getTableSizeFromSample gSPhotoshopSampleRedPadPath
giPhotoshopSampleTables[giRedPadNote] ftgen 0, 0, giPhotoshopSampleRedPadTableLength, 1, gSPhotoshopSampleRedPadPath, 0, 0, 0

gSPhotoshopSampleRidePath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleRide.wav"
giPhotoshopSampleRideTableLength getTableSizeFromSample gSPhotoshopSampleRidePath
giPhotoshopSampleTables[giRideNote] ftgen 0, 0, giPhotoshopSampleRideTableLength, 1, gSPhotoshopSampleRidePath, 0, 0, 0

gSPhotoshopSampleSnarePath = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleSnare.wav"
giPhotoshopSampleSnareTableLength getTableSizeFromSample gSPhotoshopSampleSnarePath
giPhotoshopSampleTables[giSnareNote] ftgen 0, 0, giPhotoshopSampleSnareTableLength, 1, gSPhotoshopSampleSnarePath, 0, 0, 0

gSPhotoshopSampleTom1Path = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleTom1.wav"
giPhotoshopSampleTom1TableLength getTableSizeFromSample gSPhotoshopSampleTom1Path
giPhotoshopSampleTables[giTom1Note] ftgen 0, 0, giPhotoshopSampleTom1TableLength, 1, gSPhotoshopSampleTom1Path, 0, 0, 0

gSPhotoshopSampleTom2Path = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleTom2.wav"
giPhotoshopSampleTom2TableLength getTableSizeFromSample gSPhotoshopSampleTom2Path
giPhotoshopSampleTables[giTom2Note] ftgen 0, 0, giPhotoshopSampleTom2TableLength, 1, gSPhotoshopSampleTom2Path, 0, 0, 0

gSPhotoshopSampleTomPad1Path = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleTomPad1.wav"
giPhotoshopSampleTomPad1TableLength getTableSizeFromSample gSPhotoshopSampleTomPad1Path
giPhotoshopSampleTables[giTomPad1Note] ftgen 0, 0, giPhotoshopSampleTomPad1TableLength, 1, gSPhotoshopSampleTomPad1Path, 0, 0, 0

gSPhotoshopSampleTomPad2Path = "songs/sbDrumKit/instruments/PhotoshopSamples/PhotoshopSampleTomPad2.wav"
giPhotoshopSampleTomPad2TableLength getTableSizeFromSample gSPhotoshopSampleTomPad2Path
giPhotoshopSampleTables[giTomPad2Note] ftgen 0, 0, giPhotoshopSampleTomPad2TableLength, 1, gSPhotoshopSampleTomPad2Path, 0, 0, 0

instr PhotoshopSamples
  iAmplitude = p4
  iSampleNumber = p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0
  iSample = giPhotoshopSampleTables[iSampleNumber]

  aPhotoshopSample loscil kAmplitudeEnvelope, 1, iSample, 1

  outleta "PhotoshopSamplesOutL", aPhotoshopSample
  outleta "PhotoshopSamplesOutR", aPhotoshopSample
endin

instr PhotoshopSamplesBassKnob
    gkPhotoshopSamplesEqBass linseg p4, p3, p5
endin

instr PhotoshopSamplesMidKnob
    gkPhotoshopSamplesEqMid linseg p4, p3, p5
endin

instr PhotoshopSamplesHighKnob
    gkPhotoshopSamplesEqHigh linseg p4, p3, p5
endin

instr PhotoshopSamplesFader
    gkPhotoshopSamplesFader linseg p4, p3, p5
endin

instr PhotoshopSamplesPan
    gkPhotoshopSamplesPan linseg p4, p3, p5
endin

instr PhotoshopSamplesMixerChannel
    aPhotoshopSamplesL inleta "PhotoshopSamplesInL"
    aPhotoshopSamplesR inleta "PhotoshopSamplesInR"

    kPhotoshopSamplesFader = gkPhotoshopSamplesFader
    kPhotoshopSamplesPan = gkPhotoshopSamplesPan
    kPhotoshopSamplesEqBass = gkPhotoshopSamplesEqBass
    kPhotoshopSamplesEqMid = gkPhotoshopSamplesEqMid
    kPhotoshopSamplesEqHigh = gkPhotoshopSamplesEqHigh

    aPhotoshopSamplesL, aPhotoshopSamplesR threeBandEqStereo aPhotoshopSamplesL, aPhotoshopSamplesR, kPhotoshopSamplesEqBass, kPhotoshopSamplesEqMid, kPhotoshopSamplesEqHigh

    if kPhotoshopSamplesPan > 100 then
        kPhotoshopSamplesPan = 100
    elseif kPhotoshopSamplesPan < 0 then
        kPhotoshopSamplesPan = 0
    endif

    aPhotoshopSamplesL = (aPhotoshopSamplesL * ((100 - kPhotoshopSamplesPan) * 2 / 100)) * kPhotoshopSamplesFader
    aPhotoshopSamplesR = (aPhotoshopSamplesR * (kPhotoshopSamplesPan * 2 / 100)) * kPhotoshopSamplesFader

    outleta "PhotoshopSamplesOutL", aPhotoshopSamplesL
    outleta "PhotoshopSamplesOutR", aPhotoshopSamplesR
endin
