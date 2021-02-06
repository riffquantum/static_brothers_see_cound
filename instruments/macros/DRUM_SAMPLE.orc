#define DRUM_SAMPLE(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3'VELOCITY_CURVE) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gk$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    aSampleL, aSampleR drumSample gi$INSTRUMENT_NAME.Sample, p4, p5 * gk$INSTRUMENT_NAME.Tuning, $SHOULD_RESPECT_P3, $VELOCITY_CURVE

    ; outs aSampleL, aSampleR
    outleta "OutL", aSampleL
    outleta "OutR", aSampleR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

#define DRUM_SAMPLE_2(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3'VELOCITY_CURVE) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gk$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    aSampleL, aSampleR drumSample2 gi$INSTRUMENT_NAME.Sample, flexibleAmplitudeInput(p4), flexiblePitchInput(p5) * gk$INSTRUMENT_NAME.Tuning, $SHOULD_RESPECT_P3, $VELOCITY_CURVE

    ; outs aSampleL, aSampleR
    outleta "OutL", aSampleL
    outleta "OutR", aSampleR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
