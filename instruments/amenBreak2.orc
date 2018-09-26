; Amen Break

connect "AmenBreak2", "AmenBreak2Out", "AmenBreak2MixerChannel", "AmenBreak2In"
connect "AmenBreak2MixerChannel", "AmenBreak2OutL", "Mixer", "MixerInL"
connect "AmenBreak2MixerChannel", "AmenBreak2OutR", "Mixer", "MixerInR"
alwayson "AmenBreak2MixerChannel"

gkAmenBreak2Fader init 1
gkAmenBreak2Pan init 50

instr AmenBreak2

    ;This block of code is handy for finding the nearest power of two
    ; from a file's length in samples. Necessary for working with opcodes
    ; that require that kind of BS
    SAmenFilePath init "instruments/amen-break.wav"
    iAmenFileSampleRate filesr SAmenFilePath
    
    iAmenTableLength getTableSizeFromSample SAmenFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iAmen2Table ftgenonce 0, 0, iAmenTableLength, 1, "instruments/amen-break.wav", 0, 0, 0

    kxpitch = iAmenFileSampleRate / iAmenFileSampleRate
    ;aAmen2 grain 0.1,   kxpitch,     10,     10,       10,         .010, iAmen2Table, iTable,    0.01,      1
    
    ;sndwarp arguments
    kamplitude = 1
    ktimewarp = 0.9
    kresample linseg 1, p4, 1000
    isampleTable = iAmen2Table
    ibeginningTime = 0
    iwindowSize = 5
    irandw = 0
    ioverlap = 1
    ienvelopeTable = iTable
    itimemode = 0
    aAmen2 sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "AmenBreak2Out", aAmen2

endin

instr AmenBreak2Fader
    gkAmenBreak2Fader linseg p4, p3, p5
endin

instr AmenBreak2Pan
    gkAmenBreak2Pan linseg p4, p3, p5
endin

instr AmenBreak2MixerChannel
    aAmenBreak2L inleta "AmenBreak2In"
    aAmenBreak2R inleta "AmenBreak2In"

    kAmenBreak2Fader = gkAmenBreak2Fader
    kAmenBreak2Pan = gkAmenBreak2Pan

    if kAmenBreak2Pan > 100 then
        kAmenBreak2Pan = 100
    elseif kAmenBreak2Pan < 0 then
        kAmenBreak2Pan = 0
    endif

    aAmenBreak2L = (aAmenBreak2L * ((100 - kAmenBreak2Pan) * 2 / 100)) * kAmenBreak2Fader
    aAmenBreak2R = (aAmenBreak2R * (kAmenBreak2Pan * 2 / 100)) * kAmenBreak2Fader

    outleta "AmenBreak2OutL", aAmenBreak2L
    outleta "AmenBreak2OutR", aAmenBreak2R
endin

