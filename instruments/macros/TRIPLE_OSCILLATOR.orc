# define TRIPLE_OSCILLATOR(INSTRUMENT_NAME'ROUTE) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gi$INSTRUMENT_NAME.Wave1Shape init sineWave()
  gi$INSTRUMENT_NAME.Wave2Shape init sineWave()
  gi$INSTRUMENT_NAME.Wave3Shape init sineWave()

  gk$INSTRUMENT_NAME.Wave1Ratio init 1
  gk$INSTRUMENT_NAME.Wave2Ratio init 1
  gk$INSTRUMENT_NAME.Wave3Ratio init 1

  ; Try to keep the sum of these <= 1
  gk$INSTRUMENT_NAME.Wave1Amplitude init .5
  gk$INSTRUMENT_NAME.Wave2Amplitude init .25
  gk$INSTRUMENT_NAME.Wave3Amplitude init .25

  gi$INSTRUMENT_NAME.Wave1PhaseOffset init 0
  gi$INSTRUMENT_NAME.Wave2PhaseOffset init 0
  gi$INSTRUMENT_NAME.Wave3PhaseOffset init 0

  gi$INSTRUMENT_NAME.Release init .005
  gi$INSTRUMENT_NAME.Decay init 0
  gi$INSTRUMENT_NAME.Sustain init 1
  gi$INSTRUMENT_NAME.Release init .05

  gi$INSTRUMENT_NAME.TuningSystem init 1
  gi$INSTRUMENT_NAME.DivisionsInTuningSystem init 12

  gk$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    iAmplitude flexibleAmplitudeInput p4
    aAmplitudeEnvelope = madsr:a(gi$INSTRUMENT_NAME.Release, gi$INSTRUMENT_NAME.Decay, gi$INSTRUMENT_NAME.Sustain, gi$INSTRUMENT_NAME.Release, 0) * iAmplitude

    iPitch flexiblePitchInput p5, gi$INSTRUMENT_NAME.TuningSystem, gi$INSTRUMENT_NAME.DivisionsInTuningSystem
    kPitch = gk$INSTRUMENT_NAME.Tuning * iPitch


    aOutL  = poscil:a(gk$INSTRUMENT_NAME.Wave1Amplitude, kPitch * gk$INSTRUMENT_NAME.Wave1Ratio, gi$INSTRUMENT_NAME.Wave1Shape, gi$INSTRUMENT_NAME.Wave1PhaseOffset)
    aOutL += poscil:a(gk$INSTRUMENT_NAME.Wave2Amplitude, kPitch * gk$INSTRUMENT_NAME.Wave2Ratio, gi$INSTRUMENT_NAME.Wave2Shape, gi$INSTRUMENT_NAME.Wave2PhaseOffset)
    aOutL += poscil:a(gk$INSTRUMENT_NAME.Wave3Amplitude, kPitch * gk$INSTRUMENT_NAME.Wave3Ratio, gi$INSTRUMENT_NAME.Wave3Shape, gi$INSTRUMENT_NAME.Wave3PhaseOffset)
    aOutL *= aAmplitudeEnvelope

    aOutR = aOutL

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
