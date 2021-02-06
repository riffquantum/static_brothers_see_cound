#define DARKSIDE_50_REVERB(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    ; http://www.rwdobson.com/sspaces/sciencespaces.html
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

    aOutL pconvolve aInL, SImpulseResponseFiles[p4], iPartitionSize, iChannelL
    aOutR pconvolve aInR, SImpulseResponseFiles[p4], iPartitionSize, iChannelR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
