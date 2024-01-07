/*
  SAMPLER
  A flexibile and configurable multi-mode sampler combining all of my previous sampler
  instruments. Allows for single playback, looped playback, or manual pointer playback
  on a note-by-note basis. Can be scaled to tempo or not if a length in beats is
  provided. Accepts MIDI input.

  Global Variables:
    SamplePath - S - Path to the sample for playback.
    SampleChannels - i - Number of channels in the sample, derived from the file.
    SampleLength - i - Length of sample in seconds, derived from the file.
    SampleL - i, table - Table holding the sample's left channel.
    SampleR - i, table - Table holding the sample's right channel.
    Tuning - k - Global pitch adjustment applied to the sample by multiplication.
    Mode - i - Sets the playback mode. 0 will default to 3. The modes are as follows:
      1 - Plays once in its entirety, turning off when the table end is reached.
      2 - Plays once for p3 duration.
      3 - Looped playback of the table.
      4 - Scrub mode controlled by the global pointer variable
    Pointer - a - This is the playback pointer for mode 4. Must be controlled
      from another instrument. Allows for complex combinations of forward, backward
      and piecemeal segments of playback. One application would be to approximate
      a DJ scratching.
    NormalizePointer - i - In effect in mode 4 when no length in beats is provided.
      If value is 0, the pointer values should be in seconds. Otherwise the pointer
      value should range from zero to one.
    WrapTable - i - In effect in mode 4. If value is zero, pointer values beyond the
      ends of the table will be silent. Otherwise those values will be treated as a
      loop to the other end of the table.
    ReleaseTime - i - Sets release time for the instrument.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Pitch for the instance expressed as a factor.
    p6 - StartBeat - Number - Time to skip in the sample expressed in beats.
    p7 - Mode - Number - Changes the playback mode for the note. See above for specifics.
    p8 - ReleaseTime - Number - Sets a release time for the note.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $SAMPLE_PATH - String - Optional chance to override init values for global
      variables.
    $LENGTH_OF_SAMPLE_IN_BEATS - Number - Total length of sample in beats. Used
      to calculate the pitch factor to keep the sample in time.
    MODE
    VELOCITY_CURVE - Number >= 0 - Velocity will be adjusted along a curve.
      Use 1 for a linear result. Use a number below
      1 for a slow start and fast finish curve (droop). Use a number
      above one for a fast start and slow finish curve (hump).
    NORMALIZE_SIGN - +/- - Determiens whether or not the sample table should
      be normalized. Use '-' if you really want the drums to knock.
    PITCH_MODE - 1 or 0 - Determines if p5 should expect a simple pitch factor
      or a flexible pitch value (MIDI, pitch class, or Hz).
    RELEASE_TIME - Sets release time for the instrument.
*/

#define SAMPLER_PLUS(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS'MODE'VELOCITY_CURVE'NORMALIZE_SIGN'PITCH_MODE'RELEASE_TIME) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleChannels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath
  ga$INSTRUMENT_NAME.Tuning init 1
  gi$INSTRUMENT_NAME.Mode init $MODE
  ga$INSTRUMENT_NAME.Pointer init 0
  gi$INSTRUMENT_NAME.NormalizePointer init 0
  gi$INSTRUMENT_NAME.WrapTable init 0
  gi$INSTRUMENT_NAME.AttackTime init 0.005
  gi$INSTRUMENT_NAME.ReleaseTime init $RELEASE_TIME

  if gi$INSTRUMENT_NAME.SampleChannels = 2 then
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 1
    gi$INSTRUMENT_NAME.SampleR ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
    gi$INSTRUMENT_NAME.SampleR = 0
  endif

  instr $INSTRUMENT_NAME
    iAmplitude = flexibleAmplitudeInput(p4, $VELOCITY_CURVE)

    if $PITCH_MODE == 1 || p5 == 0 then
      iPitch = flexiblePitchInput(p5)/261.626
    else
      iPitch = p5
    endif

    kPitch = iPitch * ga$INSTRUMENT_NAME.Tuning

    iStart = $LENGTH_OF_SAMPLE_IN_BEATS > 0 ? p6/$LENGTH_OF_SAMPLE_IN_BEATS : p6/gi$INSTRUMENT_NAME.SampleLength

    /*
      Mode values are as follows:
      0 = default mode
      1 = Play once
      2 = Play once for p3
      3 = Loop
      4 = scrub
    */
    iMode = p7 == 0 ? gi$INSTRUMENT_NAME.Mode : p7

    iTurnoffThresholdBuffer = sr*.007 + ksmps
    iTableLengthInSamples = nsamp(gi$INSTRUMENT_NAME.SampleL)

    iAttackTime = p8 == 0 ? gi$INSTRUMENT_NAME.AttackTime : p8
    iReleaseTime = limit( \
      (p9 == 0 ? gi$INSTRUMENT_NAME.ReleaseTime : p9), 0, ((iTableLengthInSamples-iTurnoffThresholdBuffer)/sr)-iAttackTime \
    )
    aAmplitudeEnvelope = madsr:a(iAttackTime, 0, 1, iReleaseTime) * iAmplitude

    kTempoFactor = 1
    if $LENGTH_OF_SAMPLE_IN_BEATS > 0 then
      iLengthOfBeat = gi$INSTRUMENT_NAME.SampleLength /  $LENGTH_OF_SAMPLE_IN_BEATS
      iSampleBPM = 60 / iLengthOfBeat
      kTempoFactor = gkBPM/iSampleBPM
    endif

    if iMode == 4 then
      aPointer = ga$INSTRUMENT_NAME.Pointer * kPitch

      if gi$INSTRUMENT_NAME.NormalizePointer != 0 then
        ; If pointer is normalized then we expect a value between 0 and 1.
        aPointer = aPointer
      elseif $LENGTH_OF_SAMPLE_IN_BEATS > 0 then
        ; If a length in beats is providied, we expect a value expressed in beats.
        aPointer /= $LENGTH_OF_SAMPLE_IN_BEATS
      else
        ; Otherwise we expect a value in seconds.
        aPointer /= gi$INSTRUMENT_NAME.SampleLength
      endif

      aPointer += iStart
    else
      /*
        Every mode except for 4 user the phasor opcode. I chose this over the line code
        commented below because I could have the pitch affect it as a true speed modifier
        as ooposed to a hard multiplier of the slope which allows for a 0 tuning value to
        to pause the pointer instead of resetting it. That in turn allows for a smoother
        effect when the tuning value crosses from positive to negative. An edge case for
        sure but one I wanted to account for.

        Holding onto this code because there is some complex math here I don't want to
        forget. It does some tricky stuff to let negative values flip the value of line.
        Not quite right here but might come in handy as a note.
          aPointer = line:a(0, gi$INSTRUMENT_NAME.SampleLength, 1)
          aPitch = iPitch * kTempoFactor * ga$INSTRUMENT_NAME.Tuning
          kSign = aPitch / abs(aPitch)
          aPointer = (aPointer * aPitch) + (1 - kSign)/2 + iStart
      */
      kPointerFreq = 1/(gi$INSTRUMENT_NAME.SampleLength) * kPitch * kTempoFactor
      aPointer = phasor:a(kPointerFreq, iStart)
    endif

    ; Convert pointer to a number of samples. Better for calculating an exact turnoff
    ; threshold.
    aPointerInSamples = aPointer * iTableLengthInSamples

    if iMode == 1 || iMode == 2 then
      p3 = iMode == 1 ? 1000 : p3

      kPointer = k(aPointerInSamples)

      /*
        After some experimentation, I found this value was best for preventing
        table wrap during the release of one shots in modes 1 and 2. The problem
        was that the pointer kept going after turnoff, leading to clicks as it hit
        the beginning of the table again. I would have preffered to handle this by
        shutting down the pointer after exactly one cycle but I could not find a
        way to do so.
      */
      iThreshhold = iTableLengthInSamples - iReleaseTime*sr - iTurnoffThresholdBuffer
      iThreshhold = iThreshhold < 1 ? 1 : iThreshhold


      kFinishedF trigger kPointer, iThreshhold, 0
      kFinishedB trigger kPointer, ksmps, 1

      if (kPitch > 0 && kFinishedF == 1) || (kPitch <0 && kFinishedB == 1) then
        turnoff
      endif
    endif

    if gi$INSTRUMENT_NAME.WrapTable != 0 || iMode == 3 then
      aPointer = aPointer % iTableLengthInSamples
    else
      ; table3 is very noisy if the pointer goes beyond the table end. This protects
      ; agaisnt that.
      aPointer = limit(aPointer, 0, iTableLengthInSamples)
    endif

    if gi$INSTRUMENT_NAME.SampleR != 0 then
      aOutL table3 aPointerInSamples, gi$INSTRUMENT_NAME.SampleL, 0
      aOutR table3 aPointerInSamples, gi$INSTRUMENT_NAME.SampleR, 0
    else
      aOutL table3 aPointerInSamples, gi$INSTRUMENT_NAME.SampleL, 0
      aOutR = aOutL
    endif

    aOutL *= aAmplitudeEnvelope
    aOutR *= aAmplitudeEnvelope

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

#define SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS'MODE) #
  $SAMPLER_PLUS($INSTRUMENT_NAME'$ROUTE'$SAMPLE_PATH'$LENGTH_OF_SAMPLE_IN_BEATS'$MODE'1'+'0'.01)
#

#define BREAK_SAMPLE_N(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
  $SAMPLER_PLUS($INSTRUMENT_NAME'$ROUTE'$SAMPLE_PATH'$LENGTH_OF_SAMPLE_IN_BEATS'3'1'+'0'.01)
#

#define DRUM_SAMPLE_N(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3) #
  $SAMPLER_PLUS($INSTRUMENT_NAME'$ROUTE'$SAMPLE_PATH'0'1+$SHOULD_RESPECT_P3'1'+'0'.01)
#

#define SAMPLE_SCRUBBER_N(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
  $SAMPLER_PLUS($INSTRUMENT_NAME'$ROUTE'$SAMPLE_PATH'$LENGTH_OF_SAMPLE_IN_BEATS'4'1'+'0'.01)
#
