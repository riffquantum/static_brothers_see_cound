; Inspired by: https://www.musicradar.com/how-to/the-art-of-synth-soloing-how-to-get-lyle-mays-signature-synth-sound

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

  instr $INSTRUMENT_NAME.
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
