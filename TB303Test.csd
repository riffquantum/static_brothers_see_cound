<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"
        /*
      */
        giBPM = 60
        ;seems like this instrument needs a ksmps of 1 to sound decent.
        ; Noticable degradation when ksmps = 10. Maybe we can imrpove
        ; performance at more typical ksmps values by changing some of
        ; the k rate variables to a rate.
        kr = 44100
        ksmps = 1

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"


        giTB303PitchTable ftgenonce 7 , 0, -5,  -2, 440, 550, 880, 1000, 1140

        giTB303AccentsTable ftgenonce 8 , 0, -5,  -2, 1, 0, 1, 0, 0

        giTB303DurationsTable ftgenonce 9 , 0, -5,  -2, .5, .5, .5, .5, .5

        giTB303SlidesTable ftgenonce 0, 0, -5,  -2, 1, 0, 0, 0, 0

        instr TB303pattern1
          ibpm = 60
          itranspose = 2
          iPitchSequenceTable = giTB303PitchTable
          iAccentsTable = giTB303AccentsTable
          iDurationsTable = giTB303DurationsTable
          iSlidesTable = giTB303SlidesTable
          imaxamp = 4.57

          STB303params sprintfk {{%i %i %i %i %i %i %f}}, ibpm, itranspose, iPitchSequenceTable, iAccentsTable, iDurationsTable, iSlidesTable, imaxamp

          scoreline_i beatScoreline("TB303CutOffFreqKnob", 0, 6, ".1 .3")
          scoreline_i beatScoreline("TB303ResonanceKnob", 0, 6, ".2 .2")
          scoreline_i beatScoreline("TB303EnvModKnob", 0, 6, ".1 .4")
          scoreline_i beatScoreline("TB303DecayKnob", 0, 6, ".05 .8")
          scoreline_i beatScoreline("TB303AccentKnob", 0, 6, "0 0")
          scoreline_i beatScoreline("TB303Sequencer", 0, 6, STB303params)
        endin
    </CsInstruments>

    <CsScore>
        #define bpm # 60 #
        m section0
          t 0 [$bpm]

          i "TB303pattern1" 0 2.5
          ;i "TB303pattern1" .5 2.5

        s




    </CsScore>
</CsoundSynthesizer>
