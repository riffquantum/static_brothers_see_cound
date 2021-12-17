/*
  MULTI_MODE_REVERB
  Creates an effect instrument that applies reverb to a signal. This isn't great and was really
  just for trying out different reverb opcodes to see the differences.

  Global Variables:
    Mode - i - 1-9, Selects from 9 different reverb opcodes
      1.alpass
      3. reverb
      3. reverbsc
      4. freeverb
      5. pconvolve
      6. convolve
      7. ftconv
      8. nreverb
      9. babo

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
    $MODE - Starting mode setting for reverb.
*/

#define MULTI_MODE_REVERB(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'MODE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'0.3)

  gi$INSTRUMENT_NAME.Mode init $MODE

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalWetL = aSignalInL
    aSignalWetR = aSignalInR

    /* ********
        homemade schroeder
      ********

      to do
    */

    /* ********
        alpass
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 1 then
      iReverbTime = 3
      iLoopTime  = .05
      iSkip = 0
      iDelayAmountInSamples = 0

      aSignalWetL alpass aSignalInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
      aSignalWetR alpass aSignalInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    endif
    /* ********
        reverb
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 2 then
      kReverbTime = 3
      iSkip = 0

      aSignalWetL reverb aSignalInL, kReverbTime, iSkip
      aSignalWetR reverb aSignalInR, kReverbTime, iSkip
    endif

    /* ********
        reverbsc
      ********
    */
    ; if gi$INSTRUMENT_NAME.Mode == 3 then
      kFeedbackLevel = 0.95
      iSampleRate = sr
      kCutoffFrequency = iSampleRate/4 - 1
      iPitchVariation = 1
      iSkip = 0
      aSignalWetL, aSignalWetR reverbsc aSignalInL, aSignalInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
    ; endif

    /* ********
        freeverb
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 4 then
      kRoomSize = 0.9
      kHighFrequencyDampening = 1
      iSampleRate = sr
      iSkip = 0

      aSignalWetL, aSignalWetR freeverb aSignalInL, aSignalInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
    endif

    /* ********
        pconvolve
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 5 then
      SImpulseResponseFile = "./localsamples/stairwell.wav"
      iPartitionSize = 1024
      iChannelL = 1
      iChannelR = 2

      aSignalWetL pconvolve aSignalInL, SImpulseResponseFile, iPartitionSize, iChannelL
      aSignalWetR pconvolve aSignalInR, SImpulseResponseFile, iPartitionSize, iChannelR
    endif

    /* ********
        convolve - wow that's terrible!
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 6 then
      SImpulseResponseFile = "./localsamples/stairwell.cv"
      iChannelL = 1
      iChannelR = 2

      aSignalWetL convolve aSignalInL, SImpulseResponseFile, iChannelL
      aSignalWetR convolve aSignalInR, SImpulseResponseFile, iChannelR
    endif

    /* ********
        ftconv
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 7 then
      iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
      iPartitionSize = 64
      iSkipSamples = 0
      iImpulseResponseLength = 0
      iSkipInit = 0

      aSignalWetL ftconv aSignalInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
      aSignalWetR ftconv aSignalInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    endif

    /* ********
        hrtfreverb
      ********

      to do: https://csound.com/docs/manual/hrtfearly.html
    */

    /* ********
        nreverb
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 8 then
      kReverbTime = 3
      kHighFrequencyDiffusion = .75
      iSkip = 0
      iNumberOfCombConstants = 8
      iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
      iNumberOfAlpassConstants = 4
      iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

      aSignalWetL nreverb aSignalInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

      aSignalWetR nreverb aSignalInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
    endif

    /* ********
        babo
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 9 then
      iXLength = 14.39
      iYLength = 11.86
      iZLength = 10
      kXSourcePosition = 4
      kYSourcePosition = 6
      kZSourcePosition = 4

      iDiffusion = 1

      iDecay = .99
      iHighFrequencyDecay = 0.95
      iXReceiverPosition = 0
      iYReceiverPosition = 0
      iZReceiverPosition = 0
      iReceiverStereoDistance = 0.3
      iDirectSignalAttenuation = 0.9
      iEarlyAttenuation = 0.9

      iReverbParams ftgenonce 1001, 0, 0, -2, iDecay, iHighFrequencyDecay, iXReceiverPosition, iYReceiverPosition, iZReceiverPosition, iReceiverStereoDistance, iDirectSignalAttenuation, iEarlyAttenuation

      aSignalWetLL, aSignalWetLR babo aSignalInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

      aSignalWetRL, aSignalWetRR babo aSignalInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

      aSignalWetL = aSignalWetLL + aSignalWetRL
      aSignalWetR = aSignalWetLR + aSignalWetRR
    endif

    aSignalOutL = aSignalWetL * madsr(0.01, 0.01, 1, .5)
    aSignalOutR = aSignalWetR * madsr(0.01, 0.01, 1, .5)

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
