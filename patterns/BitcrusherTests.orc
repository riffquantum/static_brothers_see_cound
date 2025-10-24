$TRIPLE_OSCILLATOR(Oscy'OscyBitInput)
giOscyTuningSystem init 15
giOscyDivisionsInTuningSystem init 17
giOscyWave2Shape init squareWave()
giOscyWave3Shape init triangleWave()
gkOscyWave2Ratio init .5
gkOscyWave3Ratio init 2
gkOscyWave2Amplitude init .25
giOscyAttack init .001
giOscyDecay init .25
giOscySustain init 1
giOscyRelease init .5
$BITCRUSHER(OscyBit'OscyVerbInput'OscyVerbInput)
$BITCRUSHER(HandBit'OscyVerbInput'OscyVerbInput)
$SAMPLER_PLUS(Hand'OscyBitInput'localSamples/handInTheHandBreak2.wav'8'3'1'+'0'0.005)
$FT_CONV_REVERB(OscyVerb'Mixer'Mixer'./localSamples/IMreverbs/Narrow Bumpy Space.wav)

instr BitLine
  gkOscyBitBitDepth = linseg(16, p3-.01, 1.2, .01, 16)
  gkHandBitBitDepth = gkOscyBitBitDepth
  gkHandBitAntiAlias = p4
  gkOscyBitAntiAlias = p4
endin

instr BitTests
  ; gkOscyBitSampleRate = poscil( 1000, .1, triangleWave()) + 4800
  ; gkOscyBitBitDepth = 6 + poscil(4, .1, triangleWave())
  ; gkOscyBitBitDepth = 6
  gkOscyBitSampleRate = 1200
  ; gkHandBitBitDepth = 6
  gkHandBitSampleRate = 1200

  gkOscyVerbWetAmount = .025
  _ "OscyVerb", 0, stb(p3)

  $PATTERN_LOOP(8)
    _ "OscyBit", i0+0, 4, 0, 0, iMeasureIndex % 3
    _ "HandBit", i0+4, 4, 0, 0, iMeasureIndex % 3
    _ "BitLine", i0+4, 4, iMeasureIndex % 2
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)
    _ "Hand", i0, 1.5, 100, 1, 0
    ; _ "Hand", i0+1.5, .5, 100, -1, .5
    _ "Hand", i0+2, 1.5, 100, 1, 4
    _ "Hand", i0+3.5, .5, 100, -1, 4

    _ "Hand", i0+4, 1.5, 100, 1, 0
    _ "Hand", i0+5.5, .5, 100, -1, .5
    _ "Hand", i0+6, 1.5, 100, 1, 4
    _ "Hand", i0+7.5, .5, 100, -1, 4
    ;  Maqam Rast
    ; 0 3 5 7 10 13 15 17
    ; 0 3 5 7 10 13 15 17
    ; c d e%b f g a B%b c
    _ "Oscy", i0, 8, 50, 3.00


      _ "Oscy", i0, .25, 100, 4.0
      _ "Oscy", i0+.5, .25, 100, 4.0
      _ "Oscy", i0+1, .25, 100, 4+(2/12 * .17)
      _ "Oscy", i0+1.5, .25, 100, 4.03
      _ "Oscy", i0+2, .25, 100, 4+(3.5/12 * .17)
      _ "Oscy", i0+2.5, .25, 100, 4.05
      _ "Oscy", i0+3, .25, 100, 4+(5/12 * .17)
      _ "Oscy", i0+3.5, .25, 100, 4.07
      _ "Oscy", i0+4, .25, 100, 4+(7/12 * .17)
      _ "Oscy", i0+4.5, .25, 100, 4.10
      _ "Oscy", i0+5, .25, 100, 4+(9/12 * .17)
      _ "Oscy", i0+5.5, .25, 100, 4.13
      _ "Oscy", i0+6, .25, 100, 4+(10.5/12 * .17)
      _ "Oscy", i0+6.5, .25, 100, 4.15
      _ "Oscy", i0+7, .25, 100, 5
      _ "Oscy", i0+7.5, .25, 100, 4.17







  $END_PATTERN_LOOP
endin
