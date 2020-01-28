<CsoundSynthesizer>

    <CsOptions>
        -odac -m0 -t1200
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 1200

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "songs/basketballBeatsEnnui/instruments/HiHat.orc"
        #include "songs/basketballBeatsEnnui/instruments/Kick.orc"
        #include "songs/basketballBeatsEnnui/instruments/Snare.orc"
        #include "songs/basketballBeatsEnnui/instruments/OpenHat.orc"
        #include "songs/basketballBeatsEnnui/instruments/Crash.orc"
        #include "songs/basketballBeatsEnnui/instruments/Ride.orc"
        #include "songs/basketballBeatsEnnui/instruments/TomMid.orc"
        #include "songs/basketballBeatsEnnui/instruments/TomHigh.orc"
        #include "songs/basketballBeatsEnnui/instruments/TomLow.orc"

        #include "songs/basketballBeatsEnnui/instruments/plucker.orc"
        #include "songs/basketballBeatsEnnui/instruments/bigSynth.orc"


        #include "patterns/sixteenthHats606.orc"
        #include "songs/basketballBeatsEnnui/patterns/pattern1.orc"
        #include "songs/basketballBeatsEnnui/patterns/dBeat.orc"
        #include "songs/basketballBeatsEnnui/patterns/dBeatFill1.orc"
        #include "songs/basketballBeatsEnnui/patterns/weirdBigCymbalPattern.orc"


    

    </CsInstruments>

    <CsScore>
        m section1
          i "dBeat" 0 128
        s


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>

