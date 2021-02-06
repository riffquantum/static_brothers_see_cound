#define DISTORTED_808_KICK(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH" ;"localSamples/Drums/TR-808_Kick_41.wav"
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0

  gk$INSTRUMENT_NAME.DryAmount init 0
  gk$INSTRUMENT_NAME.WetAmount init 1

  gk$INSTRUMENT_NAME.PreGain init 10
  gk$INSTRUMENT_NAME.PostGain init 1
  gk$INSTRUMENT_NAME.DutyOffset init .01
  gk$INSTRUMENT_NAME.SlopeShift init .01
  gi$INSTRUMENT_NAME.Stage2ClipLevel init 0dbfs/2
  gi$INSTRUMENT_NAME.FinalGainAmount init .25

  gk$INSTRUMENT_NAME.Pitch init 1

  instr $INSTRUMENT_NAME
    iAmplitude = velocityToAmplitude(p4)
    kPitch = p5 == 0 ? 1 : p5
    kPitch *= gk$INSTRUMENT_NAME.Pitch
    iReleaseTime = 0.01

    iSampleLength = nsamp(gi$INSTRUMENT_NAME.Sample) / sr

    kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, iReleaseTime, 0

    if ftchnls(gi$INSTRUMENT_NAME.Sample) == 1 then
      aSampleSignalL loscil kAmplitudeEnvelope, kPitch, gi$INSTRUMENT_NAME.Sample, 1, 0
      aSampleSignalR = aSampleSignalL
    else
      aSampleSignalL, aSampleSignalR loscil kAmplitudeEnvelope, kPitch, gi$INSTRUMENT_NAME.Sample, 1, 0
    endif

    iPreGainInstanceModifier = p6
    iPostGainInstanceModifier = p7
    iDutyOffsetModifier = p8
    iSlopeShiftOffsetModifier = p9
    iStage2ClipLevelInstanceModifier = p10

    aSignalOutL = aSampleSignalL
    aSignalOutR = aSampleSignalR

    iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    kPreGain = (gk$INSTRUMENT_NAME.PreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
    kPostGain = gk$INSTRUMENT_NAME.PostGain + iPostGainInstanceModifier
    kDutyOffset = (gk$INSTRUMENT_NAME.DutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
    kSlopeShift = (gk$INSTRUMENT_NAME.SlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

    kDeclick madsr .005, .01, 1, .01

    aSignalOutL hansDistortion aSampleSignalL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
    aSignalOutR hansDistortion aSampleSignalR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

    aSignalOutL butterlp aSignalOutL, 1000
    aSignalOutR butterlp aSignalOutR, 1000

    iStage2ClipLevel = gi$INSTRUMENT_NAME.Stage2ClipLevel + iStage2ClipLevelInstanceModifier

    aSignalOutR clip aSignalOutR, 1, iStage2ClipLevel
    aSignalOutL clip aSignalOutL, 1, iStage2ClipLevel


    aSignalOutL butterlp aSignalOutL, 5000
    aSignalOutR butterlp aSignalOutR, 5000

    aSignalOutL *= gi$INSTRUMENT_NAME.FinalGainAmount
    aSignalOutR *= gi$INSTRUMENT_NAME.FinalGainAmount

    aSignalOutL *= kDeclick
    aSignalOutR *= kDeclick


    aSignalOutL = (aSignalOutL * gk$INSTRUMENT_NAME.WetAmount) + (aSampleSignalL * gk$INSTRUMENT_NAME.DryAmount)
    aSignalOutR = (aSignalOutR * gk$INSTRUMENT_NAME.WetAmount) + (aSampleSignalR * gk$INSTRUMENT_NAME.DryAmount)


    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
