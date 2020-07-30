alwayson "PhotoshopSamplesMixerChannel"

instrumentRoute "PhotoshopSamples", "Mixer"
gkPhotoshopSamplesEqBass init 1
gkPhotoshopSamplesEqMid init 1
gkPhotoshopSamplesEqHigh init 1
gkPhotoshopSamplesFader init 1
gkPhotoshopSamplesPan init 50

giPhotoshopSampleTables[] init 128

gSPhotoshopSampleClosedHatPath = "localSamples/PhotoshopSamples/PhotoshopSampleClosedHat.wav"
giPhotoshopSampleClosedHatTableLength getTableSizeFromSample gSPhotoshopSampleClosedHatPath
giPhotoshopSampleTables[0] ftgen 0, 0, giPhotoshopSampleClosedHatTableLength, 1, gSPhotoshopSampleClosedHatPath, 0, 0, 0

gSPhotoshopSampleCrashPath = "localSamples/PhotoshopSamples/PhotoshopSampleCrash.wav"
giPhotoshopSampleCrashTableLength getTableSizeFromSample gSPhotoshopSampleCrashPath
giPhotoshopSampleTables[1] ftgen 0, 0, giPhotoshopSampleCrashTableLength, 1, gSPhotoshopSampleCrashPath, 0, 0, 0

gSPhotoshopSampleGreenPadPath = "localSamples/PhotoshopSamples/PhotoshopSampleGreenPad.wav"
giPhotoshopSampleGreenPadTableLength getTableSizeFromSample gSPhotoshopSampleGreenPadPath
giPhotoshopSampleTables[2] ftgen 0, 0, giPhotoshopSampleGreenPadTableLength, 1, gSPhotoshopSampleGreenPadPath, 0, 0, 0

gSPhotoshopSampleHatPedalPath = "localSamples/PhotoshopSamples/PhotoshopSampleHatPedal.wav"
giPhotoshopSampleHatPedalTableLength getTableSizeFromSample gSPhotoshopSampleHatPedalPath
giPhotoshopSampleTables[3] ftgen 0, 0, giPhotoshopSampleHatPedalTableLength, 1, gSPhotoshopSampleHatPedalPath, 0, 0, 0

gSPhotoshopSampleKickPath = "localSamples/PhotoshopSamples/PhotoshopSampleKick.wav"
giPhotoshopSampleKickTableLength getTableSizeFromSample gSPhotoshopSampleKickPath
giPhotoshopSampleTables[4] ftgen 0, 0, giPhotoshopSampleKickTableLength, 1, gSPhotoshopSampleKickPath, 0, 0, 0

gSPhotoshopSampleOpenHatPath = "localSamples/PhotoshopSamples/PhotoshopSampleOpenHat.wav"
giPhotoshopSampleOpenHatTableLength getTableSizeFromSample gSPhotoshopSampleOpenHatPath
giPhotoshopSampleTables[5] ftgen 0, 0, giPhotoshopSampleOpenHatTableLength, 1, gSPhotoshopSampleOpenHatPath, 0, 0, 0

gSPhotoshopSampleRedPadPath = "localSamples/PhotoshopSamples/PhotoshopSampleRedPad.wav"
giPhotoshopSampleRedPadTableLength getTableSizeFromSample gSPhotoshopSampleRedPadPath
giPhotoshopSampleTables[6] ftgen 0, 0, giPhotoshopSampleRedPadTableLength, 1, gSPhotoshopSampleRedPadPath, 0, 0, 0

gSPhotoshopSampleRidePath = "localSamples/PhotoshopSamples/PhotoshopSampleRide.wav"
giPhotoshopSampleRideTableLength getTableSizeFromSample gSPhotoshopSampleRidePath
giPhotoshopSampleTables[7] ftgen 0, 0, giPhotoshopSampleRideTableLength, 1, gSPhotoshopSampleRidePath, 0, 0, 0

gSPhotoshopSampleSnarePath = "localSamples/PhotoshopSamples/PhotoshopSampleSnare.wav"
giPhotoshopSampleSnareTableLength getTableSizeFromSample gSPhotoshopSampleSnarePath
giPhotoshopSampleTables[8] ftgen 0, 0, giPhotoshopSampleSnareTableLength, 1, gSPhotoshopSampleSnarePath, 0, 0, 0

gSPhotoshopSampleTom1Path = "localSamples/PhotoshopSamples/PhotoshopSampleTom1.wav"
giPhotoshopSampleTom1TableLength getTableSizeFromSample gSPhotoshopSampleTom1Path
giPhotoshopSampleTables[9] ftgen 0, 0, giPhotoshopSampleTom1TableLength, 1, gSPhotoshopSampleTom1Path, 0, 0, 0

gSPhotoshopSampleTom2Path = "localSamples/PhotoshopSamples/PhotoshopSampleTom2.wav"
giPhotoshopSampleTom2TableLength getTableSizeFromSample gSPhotoshopSampleTom2Path
giPhotoshopSampleTables[10] ftgen 0, 0, giPhotoshopSampleTom2TableLength, 1, gSPhotoshopSampleTom2Path, 0, 0, 0

gSPhotoshopSampleTomPad1Path = "localSamples/PhotoshopSamples/PhotoshopSampleTomPad1.wav"
giPhotoshopSampleTomPad1TableLength getTableSizeFromSample gSPhotoshopSampleTomPad1Path
giPhotoshopSampleTables[11] ftgen 0, 0, giPhotoshopSampleTomPad1TableLength, 1, gSPhotoshopSampleTomPad1Path, 0, 0, 0

gSPhotoshopSampleTomPad2Path = "localSamples/PhotoshopSamples/PhotoshopSampleTomPad2.wav"
giPhotoshopSampleTomPad2TableLength getTableSizeFromSample gSPhotoshopSampleTomPad2Path
giPhotoshopSampleTables[12] ftgen 0, 0, giPhotoshopSampleTomPad2TableLength, 1, gSPhotoshopSampleTomPad2Path, 0, 0, 0

instr PhotoshopSamples
  iAmplitude velocityToAmplitude p4
  iSampleNumber = p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0
  iSample = giPhotoshopSampleTables[iSampleNumber]

  aPhotoshopSample loscil kAmplitudeEnvelope, 1, iSample, 1

  outleta "OutL", aPhotoshopSample
  outleta "OutR", aPhotoshopSample
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
    aPhotoshopSamplesL inleta "InL"
    aPhotoshopSamplesR inleta "InR"

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

    outleta "OutL", aPhotoshopSamplesL
    outleta "OutR", aPhotoshopSamplesR
endin
