; An attempt at a nice, widley usable Bass Synth sound
; based on this youtube video: https://www.youtube.com/watch?time_continue=143&v=wul-rUHyX_E&feature=emb_title

#define BASS_SYNTH(INSTRUMENT_NAME'ROUTE'GLOBAL_SETTINGS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"
  $MIXER_CHANNEL($INSTRUMENT_NAME)

  gk$INSTRUMENT_NAME.CenterFrequency init 250
  gk$INSTRUMENT_NAME.Bandwidth init 50
  gi$INSTRUMENT_NAME.Wave init sawtoothWaveUpAndDown()
  gi$INSTRUMENT_NAME.SubWave init triangleWave()
  gi$INSTRUMENT_NAME.Attack init 0.01
  gi$INSTRUMENT_NAME.Decay init 0.3
  gi$INSTRUMENT_NAME.Sustain init 0.8
  gi$INSTRUMENT_NAME.Release init 0.1
  gi$INSTRUMENT_NAME.FilterExponent init 1
  gk$INSTRUMENT_NAME.VibratoRate init 4
  gk$INSTRUMENT_NAME.VibratoPitchAmount init 0
  gk$INSTRUMENT_NAME.VibratoAmplitudeAmount init 0

  $GLOBAL_SETTINGS

  instr $INSTRUMENT_NAME
    iAmplitude flexibleAmplitudeInput p4
    iPitch flexiblePitchInput p5

    kPitchBend = 0
    midipitchbend kPitchBend, 0, 15
    kPitch = iPitch * (1 + kPitchBend)

    kEnvelope = madsr(gi$INSTRUMENT_NAME.Attack, gi$INSTRUMENT_NAME.Decay, gi$INSTRUMENT_NAME.Sustain, gi$INSTRUMENT_NAME.Release)
    kDeclickEnvelope = linsegr(1, gi$INSTRUMENT_NAME.Release + .2, 0)
    kAmplitude = kEnvelope * iAmplitude
    kCenterFrequency = gk$INSTRUMENT_NAME.CenterFrequency * (kEnvelope^gi$INSTRUMENT_NAME.FilterExponent)
    kBandwidth = gk$INSTRUMENT_NAME.Bandwidth * (kEnvelope^gi$INSTRUMENT_NAME.FilterExponent)

    aVibrato = oscil(1, gk$INSTRUMENT_NAME.VibratoRate)
    kPitch += kPitch * ((aVibrato + 1) * gk$INSTRUMENT_NAME.VibratoPitchAmount)
    kAmplitude *= 1 - ((aVibrato/2 + .5) * gk$INSTRUMENT_NAME.VibratoAmplitudeAmount)

    aSignal init 0
    aSignal = poscil3(kAmplitude, kPitch, gi$INSTRUMENT_NAME.Wave)
    aFilteredSignal = reson( aSignal, kCenterFrequency, kBandwidth)
    aFilteredSignal += poscil3(kAmplitude, kPitch/2, gi$INSTRUMENT_NAME.SubWave)
    aSignal = balance(aFilteredSignal, aSignal)

    outleta "OutL", aSignal
    outleta "OutR", aSignal
  endin
#
