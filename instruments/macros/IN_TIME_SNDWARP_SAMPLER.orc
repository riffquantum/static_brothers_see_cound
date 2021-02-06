#define IN_TIME_SNDWARP_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Channels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLengthInBeats = $LENGTH_SAMPLE_IN_BEATS
  gi$INSTRUMENT_NAME.SLengthOfBeat = gi$INSTRUMENT_NAME.SampleLength / gi$INSTRUMENT_NAME.SampleLengthInBeats
  gi$INSTRUMENT_NAME.BPM init 60 /gi$INSTRUMENT_NAME.SLengthOfBeat
  gi$INSTRUMENT_NAME.Factor = i(gkBPM) / gi$INSTRUMENT_NAME.BPM
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  instr $INSTRUMENT_NAME
    iAmplitude = flexibleAmplitudeInput(p4)
    kAmplitudeEnvelope = madsr(.005, .01, 1, .01) * iAmplitude
    iFrequency = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
    iGrainAmplitude = 1
    iStartTime = p6
    iTimeStretch = p7
    iTimeStretch = iTimeStretch == 0 ? 1/gi$INSTRUMENT_NAME.Factor : 1/gi$INSTRUMENT_NAME.Factor * iTimeStretch
    iWindowSize = 3000
    iWindowRandomization = iWindowSize * 2
    iOverlaps = 50
    iTimeMode = 0

    if gi$INSTRUMENT_NAME.Channels == 2 then
      aOutL, aOutR sndwarpst iGrainAmplitude, iTimeStretch, iFrequency, gi$INSTRUMENT_NAME.Sample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode
    else
      aOutL sndwarp iGrainAmplitude, iTimeStretch, iFrequency, gi$INSTRUMENT_NAME.Sample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode
      aOutR = aOutL
    endif

    aOutL = kAmplitudeEnvelope * aOutL
    aOutR = kAmplitudeEnvelope * aOutR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
