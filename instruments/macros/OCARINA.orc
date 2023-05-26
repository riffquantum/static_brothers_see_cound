/*
  OCARINA
  Creates an instrument that synthesizes an ocarina like sound. Based on this
  blog article about the guy from the Pat Metheny Group:
  https://www.musicradar.com/how-to/the-art-of-synth-soloing-how-to-get-lyle-mays-signature-synth-sound

  Global Variables:
    Attack - i - Attack for note envelope.
    Decay - i - Decay for note envelope.
    Sustain - i - Sustain for note envelope.
    Release - i - Release for note envelope.
    VibratoRate - k - Rate for vibrato applied to signal.
    VibratoAttack - i - Attack time for application of vibrato.
    VibratoAmount - k - Amplitude of vibrato wave.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $GLOBAL_SETTINGS - String - Optional chance to override init values for global
      variables.
*/

#define OCARINA(INSTRUMENT_NAME'ROUTE'GLOBAL_SETTINGS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"
  $MIXER_CHANNEL($INSTRUMENT_NAME)

  gi$INSTRUMENT_NAME.Attack init 0.1
  gi$INSTRUMENT_NAME.Decay init 0.1
  gi$INSTRUMENT_NAME.Sustain init 0.5
  gi$INSTRUMENT_NAME.Release init 0.5
  gk$INSTRUMENT_NAME.VibratoRate init 4
  gi$INSTRUMENT_NAME.VibratoAttack init 1
  gk$INSTRUMENT_NAME.VibratoAmount init 0.01

  $GLOBAL_SETTINGS

  instr $INSTRUMENT_NAME
    iAmplitude flexibleAmplitudeInput p4
    iPitch flexiblePitchInput p5

    iWaveTable = squareWave()

    kAmplitudeEnvelope = madsr(gi$INSTRUMENT_NAME.Attack, gi$INSTRUMENT_NAME.Decay, gi$INSTRUMENT_NAME.Sustain, gi$INSTRUMENT_NAME.Release) * iAmplitude

    kPitch = linseg(iPitch*.95, gi$INSTRUMENT_NAME.Attack, iPitch*1.05, gi$INSTRUMENT_NAME.Decay, iPitch)
    kPitchBend = 0
    midipitchbend kPitchBend, 0, 15
    kPitch = kPitch * (1 + kPitchBend)

    kVibrato = 1 + oscil(linseg(0, gi$INSTRUMENT_NAME.Attack+gi$INSTRUMENT_NAME.Decay, 0, gi$INSTRUMENT_NAME.VibratoAttack, 1) * gk$INSTRUMENT_NAME.VibratoAmount, gk$INSTRUMENT_NAME.VibratoRate)
    kPitch *= kVibrato

    aSignal oscil kAmplitudeEnvelope, kPitch, iWaveTable
    aSignal *= (261.1/iPitch)^.25

    aFilteredSignal = moogladder( aSignal, 625, .5)
    aSignal = balance(aFilteredSignal, aSignal)

    outleta "OutL", aSignal
    outleta "OutR", aSignal
  endin
#
