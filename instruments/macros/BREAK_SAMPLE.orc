#define BREAK_SAMPLE(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleChannels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath

  if gi$INSTRUMENT_NAME.SampleChannels = 2 then
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 1
    gi$INSTRUMENT_NAME.SampleR ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
    gi$INSTRUMENT_NAME.SampleR = 0
  endif

  instr $INSTRUMENT_NAME
    iAmplitude = velocityToAmplitude(p4)
    kPitch = p5
    iStartBeat = p6

    aOutL, aOutR breakSampler iAmplitude, kPitch, iStartBeat, gi$INSTRUMENT_NAME.SampleLength, $LENGTH_OF_SAMPLE_IN_BEATS, gi$INSTRUMENT_NAME.SampleL, gi$INSTRUMENT_NAME.SampleR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
