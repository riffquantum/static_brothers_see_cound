<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRouting.orc"
        
        giBPM = 85

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        instr twistedTablas
            itablaFactor = 120 / 149.5 * .38

            Sdiskgrainparams sprintfk {{ "tablasitarloop1.wav" 2 %f 30 %f 20 }}, itablaFactor, 0
            Sdiskgrainparams2 sprintfk {{ "tablasitarloop1.wav" 2 %f 1 %f 20 }}, (120 / 149.5 * .38), 0.338
            
            Sdiskgrainparams3 sprintfk {{ "tablarasaranga1.wav" 2 %f 1 %f 20 }}, (.2), 2
            Sdiskgrainparams4 sprintfk {{ "tablarasaranga1.wav" 2 %f 1 %f 20 }}, (.02), 2

            Sdiskgrainparams2 = {{ "tablarasaranga1.wav" 2 .39 1 0 3 }}
            

            ;scoreline_i beatScoreline( "generalSamplerDiskgrain", 0, 8, {{ "tablasitarloop1.wav" 1 1 1 1 .004 2 }} )

            scoreline_i beatScoreline( "generalSamplerSndwarp", 1, .5, Sdiskgrainparams2 )

            ;scoreline_i beatScoreline( "generalSamplerSndwarp", 0, 2, Sdiskgrainparams )
            scoreline_i beatScoreline( "generalSamplerSndwarp", 3, 1.25, Sdiskgrainparams )

            ;scoreline_i beatScoreline( "generalSamplerSndwarp", 0, 2.75, Sdiskgrainparams2 )
            scoreline_i beatScoreline( "generalSamplerSndwarp", 3.5, 2, Sdiskgrainparams3 )
            scoreline_i beatScoreline( "generalSamplerSndwarp", 2, 2, Sdiskgrainparams4 )

            scoreline_i beatScoreline( "generalSamplerSndwarp", 2, .33, Sdiskgrainparams2 )

            ;scoreline_i beatScoreline( "generalSamplerDiskin", 0, 4, {{ "tablasitarloop1.wav" 1 0 }} )
        endin

        instr drumPattern1
            scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 2 2 0 0 0 }})    


            ;scoreline_i beatScoreline( "TR808", 1, 2, {{ "SnareDrum5" 1.2 1 0 0 0 }})
            ;scoreline_i beatScoreline( "TR808", 3, 2, {{ "SnareDrum5" 1.3 1 0 0 0 }})
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 1, .55, {{ .55 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 3, .55, {{ .55 }} )
            
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  2 }})

        endin

        instr drumPattern1__alt
            scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 2 2 0 0 0 }})    


            ;scoreline_i beatScoreline( "TR808", 1, 2, {{ "SnareDrum5" 1.2 1 0 0 0 }})
            ;scoreline_i beatScoreline( "TR808", 3, 2, {{ "SnareDrum5" 1.3 1 0 0 0 }})
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 1, .55, {{ .55 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 3, .55, {{ .55 }} )
            
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  9 }})

        endin

        instr drumPattern1__end
            scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 2 2 0 0 0 }})    


            scoreline_i beatScoreline( "TR808", 1, 2, {{ "SnareDrum5" 1.2 1 0 0 0 }})
            scoreline_i beatScoreline( "TR808", 3, 2, {{ "SnareDrum5" 1.3 1 0 0 0 }})
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 1, .55, {{ .55 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 3, .55, {{ .55 }} )
            
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  8 }})

        endin

        instr drumPattern2
            scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 1.25, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})    
            scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})    
            


            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, .75, {{  1.5 }})
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", .75, .25, {{  1.25 }})
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 1, .5, {{ 1.25 }})
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 1.5, .25, {{  1.25 }})
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 1.75, 2, {{ 1.25 }})
            scoreline_i beatScoreline("loserInTheEndBreakDiskin", 3.75, .25, {{  1.25 }})

        endin
        
    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 85 #
            
            m section1
                t 0 [$bpm]
                i "generalSamplerFader" 0 .1 .025 .025

                ;i "twistedTablas" 0 4
                ;i "twistedTablas" + 4
                ;i "twistedTablas" + 4
                ;i "twistedTablas" + 4


                /*
                i "twistedTablas" 16 2
                i "twistedTablas" 20 2
                i "twistedTablas" 24 2
                i "twistedTablas" 28 2
                i "drumPattern2" 0 4
                i "drumPattern2" + 4
                i "drumPattern2" + 4
                i "drumPattern2" + 4
                */
                i "drumPattern1" 0 4
                i "drumPattern1" 4 4
                i "drumPattern1__alt" 8 4
                i "drumPattern1__end" 12 4

                i "drumPattern1" 16 4
                i "drumPattern1" + 4
                i "drumPattern1" + 4
                i "drumPattern1__end" 28 4

                i "drumPattern1" 32 4
                i "drumPattern1" + 4
                i "drumPattern1" + 4
                i "drumPattern1__end" 44 4

                
            s
            
        
            
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
