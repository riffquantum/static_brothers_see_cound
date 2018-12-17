<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"

        giBPM = 100
        kr = 44100
        ksmps = 1

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 100 #

        m section0
          t 0 [$bpm]

          f1 0 8192 10 1; sine wave
          f3  0 8193   8  0 512 1 1024 1 512 .5 2048 .2 4096  0; accent curve

          f4  0  16  -2  12 24 12 14 15 12 0 12 12 24 12 14 15 6 13 16 ; sequencer (pitches are 6.00 + p/100)
          f5  0  32  -2   0  1  0  0  0  0 0  0  0  1  0  1  1 1  0  0 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1; accent sequence
          f6  0  16  -2   2     1  1  2    1  1  1  2     1  1 3       1 4 0 0 0; fill with zeroes till next power of 2
          ;f6 = durations of events, 1 = note per note, 2 = two tied notes... .
          ;note: f4-f5-f6 don´t need to be syncronized... like here (16-32-21)
          f7  0  8  -2   10 0 12 0 7 10 12 7; sequencer (pitches are 6.00 + p/100)
          f8  0  16  -2   1 0  0 0 0  0  0 0 0 0 0 0 0 0 0 0; accent sequence
          f9  0  2  -2   16 0; fill with zeroes till next power of 2

          f10  0  8  -2   0 12 0 0 12 0 0 12; sequencer (pitches are 6.00 + p/100)
          f11  0  8  -2   1  1 1 1  1 1 1  1; accent sequence
          f12  0  8  -2   1  1 1 1  1 1 1  1; fill with zeroes till next power of 2

          ;------------------------KNOB POSITION : INITIAL AND FINAL VALUES FROM 0 TO 1--------------------------------------------------------
          ;    cutoff freq  resonance envelope mod. decay       accent     bpm  transpose ft seq   ft acc     ft dur   maxamp
          ;      0   -   1    0 ~ 1   ~ .1 - 1    0 - 1       0 - 1   40-300  (octaves)(pitches)(accents)(durations)
          ;        start    end   st  end   st   end    st  end     st  end

          i "TB303"   0 20    .1     .3        .2  .2        .1   .4         .05 .8      0   0      120     2         7        8       9        4.57
          i "TB303"   0 20  0      1         .5  1         .1   .4         1   1       1   1      120     0         4        5       6         1.52
          i "TB303"  20 40  .2     1         .5  1         .1   .1         .5  1       .5  1      120     2         7        8       9        4.57
          i "TB303"  40 20    .5     1         .95 1         1    .9         1   .1      .5  1      120     0         4        5       6         1.52
          i "TB303"  30 30    .5     1         .5  .5        .5   .5         .5  .5      0   0      120     0        10       11      12        3.05

          ;------------------------------------------END OF SCORE------------------------------------------------------------------------------
          e



        s

    </CsScore>
</CsoundSynthesizer>
