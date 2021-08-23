; https://www.youtube.com/watch?v=zuvbfYvwca4

#define PIANO_SYNTH(INSTRUMENT_NAME'ROUTE'GLOBAL_SETTINGS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"
  $MIXER_CHANNEL($INSTRUMENT_NAME)

  gk$INSTRUMENT_NAME.CenterFrequency init 500
  gk$INSTRUMENT_NAME.Q init 10
  gi$INSTRUMENT_NAME.Wave init sawtoothWaveUpAndDown()
  gi$INSTRUMENT_NAME.Attack init .5
  gi$INSTRUMENT_NAME.Decay init 0.3
  gi$INSTRUMENT_NAME.Sustain init 0.8
  gi$INSTRUMENT_NAME.Release init 1.5
  gi$INSTRUMENT_NAME.FilterExponent init 1
  gk$INSTRUMENT_NAME.VibratoRate init 1
  gk$INSTRUMENT_NAME.VibratoPitchAmount init 0.005
  gk$INSTRUMENT_NAME.VibratoAmplitudeAmount init 0
  gi$INSTRUMENT_NAME.NumberOfVoices init 7

  $GLOBAL_SETTINGS

  instr $INSTRUMENT_NAME.
    iAmplitude flexibleAmplitudeInput p4
    iPitch flexiblePitchInput p5

    kPitchBend = 0
    midipitchbend kPitchBend, 0, 15
    kPitch = iPitch * (1 + kPitchBend)

    kEnvelope = madsr(gi$INSTRUMENT_NAME.Attack, gi$INSTRUMENT_NAME.Decay, gi$INSTRUMENT_NAME.Sustain, gi$INSTRUMENT_NAME.Release)
    kAmplitude = kEnvelope * iAmplitude
    kCenterFrequency = gk$INSTRUMENT_NAME.CenterFrequency ;* (kEnvelope^gi$INSTRUMENT_NAME.FilterExponent)
    kBandwidth = gk$INSTRUMENT_NAME.Q ;* (kEnvelope^gi$INSTRUMENT_NAME.FilterExponent)

    aVibrato = oscil(1, gk$INSTRUMENT_NAME.VibratoRate) * kEnvelope
    kPitch += kPitch * ((aVibrato + 1) * gk$INSTRUMENT_NAME.VibratoPitchAmount)
    kAmplitude *= 1 - ((aVibrato/2 + .5) * gk$INSTRUMENT_NAME.VibratoAmplitudeAmount)

    kDetuneFactor = .005 ;/ random(1, 4)

    aFirstVoice = poscil3(kAmplitude, kPitch, gi$INSTRUMENT_NAME.Wave)
    aSignal = aFirstVoice

    if gi$INSTRUMENT_NAME.NumberOfVoices > 1 then
      aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*2), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif
    if gi$INSTRUMENT_NAME.NumberOfVoices > 2 then
      aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*2), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif
    if gi$INSTRUMENT_NAME.NumberOfVoices > 3 then
      aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*3), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif
    if gi$INSTRUMENT_NAME.NumberOfVoices > 4 then
      aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*3), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif
    if gi$INSTRUMENT_NAME.NumberOfVoices > 5 then
      aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*4), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif
    if gi$INSTRUMENT_NAME.NumberOfVoices > 6 then
      aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*4), gi$INSTRUMENT_NAME.Wave, random(0, 1))
    endif


    aFilteredSignal = butterlp( aSignal, kCenterFrequency)
    aFilteredSignal = lowpass2( aSignal, kCenterFrequency, kBandwidth)
    aFilteredSignal = moogladder( aSignal, kCenterFrequency, .1)
    aFilteredSignal = tone( aSignal, kCenterFrequency)
    ; aFilteredSignal = clfilt(aFilteredSignal, 20, 1, 6, 1, 3)

    aSignal = balance(aFilteredSignal, aFirstVoice)

    outleta "OutL", aSignal
    outleta "OutR", aSignal
  endin
#
