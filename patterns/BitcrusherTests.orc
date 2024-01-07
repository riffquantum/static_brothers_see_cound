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
endin

instr BitTests
  ; gkOscyBitSampleRate = poscil( 1000, .1, triangleWave()) + 4800
  ; gkOscyBitBitDepth = 6 + poscil(4, .1, triangleWave())
  ; gkOscyBitBitDepth = 6
  gkOscyBitSampleRate = 2400
  ; gkHandBitBitDepth = 6
  gkHandBitSampleRate = 2400

  gkOscyVerbWetAmount = .025
  _ "OscyVerb", 0, stb(p3)

  $PATTERN_LOOP(8)
    _ "OscyBit", i0+4, 4, 0, 0, iMeasureIndex % 3
    _ "HandBit", i0+4, 4, 0, 0, iMeasureIndex % 3
    _ "BitLine", i0+4, 4
  $END_PATTERN_LOOP

  $PATTERN_LOOP(4)
    _ "Hand", i0, 1.5, 100, 1, 0
    _ "Hand", i0+2, 1.5, 100, 1, 4
    _ "Hand", i0+3.5, .5, 100, -1, 4
    ;  Maqam Rast
    ; 0 3 5 7 10 13 15 17
    _ "Oscy", i0, 4, 50, 3.00
    _ "Oscy", i0, .25, 100, 4.17
    _ "Oscy", i0+1, .25, 100, 4.03
    _ "Oscy", i0+2, .25, 100, 4.15
    _ "Oscy", i0+3, .25, 100, 4.07
    _ "Oscy", i0+3.5, .2, 100, 4.10
    _ "Oscy", i0+3.75, .2, 100, 4.05
  $END_PATTERN_LOOP
endin
