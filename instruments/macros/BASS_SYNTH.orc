/*
  BASS_SYNTH
  An attempt at a nice, widley usable Bass Synth sound. Based on this youtube
  video: https://www.youtube.com/watch?time_continue=143&v=wul-rUHyX_E&feature=emb_title

  Global Variables:
    CenterFrequency - k - Center frequency for the filter applied to the signal.
    Bandwidth - k - Bandwidth for the filter applied to the signal.
    FilterExponent - i -  Filter is modified over note duration by the envelope
      This exponent can change the intensity of that effect.
    Wave - i - Wave form for primary signal.
    SubWave - i - Wave form for the octave down signal.
    Attack - i - Attack for note envelope.
    Decay - i - Decay for note envelope.
    Sustain - i - Sustain for note envelope.
    Release - i - Release for note envelope.
    VibratoRate - k - Rate for vibrato applied to signal.
    VibratoPitchAmount - k - Amount of pitch vibrato to apply.
    VibratoAmplitudeAmount - k - Amount of amplitude vibrato to apply.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $GLOBAL_SETTINGS - String - Optional chance to override init values for global
      variables.
*/

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
