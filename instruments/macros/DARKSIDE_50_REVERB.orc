/*
  DARKSIDE_50_REVERB
  Creates an effect instrument that applies reverb to a signal. The reverb is convolution
  based on impulse samples from inside the Darkside 50 dark matter detector at Gran Sasso.
  Sourced from this blog: http://www.rwdobson.com/sspaces/sciencespaces.html. I think they
  intended for these to be used through some kind of ambisonic process but I chose to use them
  in simple convolution.

  Global Variables:
    None

  P Fields:
    p4 - ImpulseFile - Selects the impulse file from an array, 0 - 11.
      They correspond to different mic positions inside the cylinder and
      inside the sphere.
    p5 - Release - Release time for the effect instance. Defaults to 0.1.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define DARKSIDE_50_REVERB(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    iImpulseFile = p4
    iRelease = p6 == 0 ? 0.1 : p6


    SImpulseResponseFiles[] fillarray \
      "./localSamples/darksideIRs/cylinder11A_amb.wav", \
      "./localSamples/darksideIRs/cylinder11B_amb.wav", \
      "./localSamples/darksideIRs/cylinder12A_amb.wav", \
      "./localSamples/darksideIRs/cylinder12B_amb.wav", \
      "./localSamples/darksideIRs/cylinder14A_amb.wav", \
      "./localSamples/darksideIRs/cylinder14B_amb.wav", \
      "./localSamples/darksideIRs/sphere16A_amb.wav", \
      "./localSamples/darksideIRs/sphere16B_amb.wav", \
      "./localSamples/darksideIRs/sphere17A_amb.wav", \
      "./localSamples/darksideIRs/sphere17B_amb.wav", \
      "./localSamples/darksideIRs/sphere18A_amb.wav", \
      "./localSamples/darksideIRs/sphere18B_amb.wav"

    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aEnvelope = madsr(.01, .01, 1, iRelease)

    aOutL pconvolve aInL, SImpulseResponseFiles[p4], iPartitionSize, iChannelL
    aOutR pconvolve aInR, SImpulseResponseFiles[p4], iPartitionSize, iChannelR

    aOutL *= aEnvelope
    aOutR *= aEnvelope

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
