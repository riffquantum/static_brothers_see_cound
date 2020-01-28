/* santanaSample1 */


connect "santanaSample1Sndwarp", "santanaSample1OutL", "santanaSample1Reverb", "santanaSample1InL"
connect "santanaSample1Sndwarp", "santanaSample1OutR", "santanaSample1Reverb", "santanaSample1InR"

connect "santanaSample1Reverb", "santanaSample1OutL", "santanaSample1MixerChannel", "santanaSample1InL"
connect "santanaSample1Reverb", "santanaSample1OutR", "santanaSample1MixerChannel", "santanaSample1InR"

connect "santanaSample1MixerChannel", "santanaSample1OutL", "Mixer", "MixerInL"
connect "santanaSample1MixerChannel", "santanaSample1OutR", "Mixer", "MixerInR"

alwayson "santanaSample1MixerChannel"
alwayson "santanaSample1Reverb"

gksantanaSample1EqBass init 1
gksantanaSample1EqMid init 1
gksantanaSample1EqHigh init 1
gksantanaSample1Fader init 1
gksantanaSample1Pan init 50

instr santanaSample1Sndwarp
    kamplitude = p4
    ktimewarp = (gkBPM)/111.5 * 2
    kresample = 1
    ibeginningTime =  2.75
    ioverlap = 20
    iwindowSize = 10


    SsampleFilePath = "samples/santana-repetitive-riff.wav"
    iFileNumChannels filenchnls SsampleFilePath
    isantanaSample1FileSampleRate filesr SsampleFilePath
    isantanaSample1TableLength getTableSizeFromSample SsampleFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

    isantanaSample1Table ftgenonce 0, 0, isantanaSample1TableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = isantanaSample1Table

    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iFileNumChannels == 2 then
        asantanaSample1L, asantanaSample1R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        asantanaSample1L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        asantanaSample1R = asantanaSample1L
    endif


    outleta "santanaSample1OutL", asantanaSample1L
    outleta "santanaSample1OutR", asantanaSample1R

endin

instr santanaSample1Reverb
  asantanaSample1L inleta "santanaSample1InL"
  asantanaSample1R inleta "santanaSample1InR"

  kReverb1Wet init 1
  kReverb1Dry init 1

  kReverb1Delay init .8
  kReverb1Cutoff init 1200

  asantanaSample1WetL, asantanaSample1WetR reverbsc asantanaSample1L, asantanaSample1R, kReverb1Delay, kReverb1Cutoff

  asantanaSample1L = (asantanaSample1WetL * kReverb1Wet) + (asantanaSample1L * kReverb1Dry)
  asantanaSample1R = (asantanaSample1WetR * kReverb1Wet) + (asantanaSample1R * kReverb1Dry)

  outleta "santanaSample1OutL", asantanaSample1L
  outleta "santanaSample1OutR", asantanaSample1R
endin

instr santanaSample1BassKnob
    gksantanaSample1EqBass linseg p4, p3, p5
endin

instr santanaSample1MidKnob
    gksantanaSample1EqMid linseg p4, p3, p5
endin

instr santanaSample1HighKnob
    gksantanaSample1EqHigh linseg p4, p3, p5
endin

instr santanaSample1Fader
    gksantanaSample1Fader linseg p4, p3, p5
endin

instr santanaSample1Pan
    gksantanaSample1Pan linseg p4, p3, p5
endin

instr santanaSample1MixerChannel
    asantanaSample1L inleta "santanaSample1InL"
    asantanaSample1R inleta "santanaSample1InR"

    ksantanaSample1Fader = gksantanaSample1Fader
    ksantanaSample1Pan = gksantanaSample1Pan
    ksantanaSample1EqBass = gksantanaSample1EqBass
    ksantanaSample1EqMid = gksantanaSample1EqMid
    ksantanaSample1EqHigh = gksantanaSample1EqHigh

    asantanaSample1L, asantanaSample1R threeBandEqStereo asantanaSample1L, asantanaSample1R, ksantanaSample1EqBass, ksantanaSample1EqMid, ksantanaSample1EqHigh

    if ksantanaSample1Pan > 100 then
        ksantanaSample1Pan = 100
    elseif ksantanaSample1Pan < 0 then
        ksantanaSample1Pan = 0
    endif

    asantanaSample1L = (asantanaSample1L * ((100 - ksantanaSample1Pan) * 2 / 100)) * ksantanaSample1Fader
    asantanaSample1R = (asantanaSample1R * (ksantanaSample1Pan * 2 / 100)) * ksantanaSample1Fader


    outleta "santanaSample1OutL", asantanaSample1L
    outleta "santanaSample1OutR", asantanaSample1R
endin

