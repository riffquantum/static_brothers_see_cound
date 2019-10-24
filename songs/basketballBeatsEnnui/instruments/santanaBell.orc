/* santanaBell */

connect "santanaBellSndwarp", "santanaBellOutL", "santanaBellMixerChannel", "santanaBellInL"
connect "santanaBellSndwarp", "santanaBellOutR", "santanaBellMixerChannel", "santanaBellInR"

connect "santanaBellSndwarpMixerChannel", "santanaBellSndwarpOutL", "Mixer", "MixerInL"
connect "santanaBellSndwarpMixerChannel", "santanaBellSndwarpOutR", "Mixer", "MixerInR"

alwayson "santanaBellMixerChannel"

gksantanaBellEqBass init 1
gksantanaBellEqMid init 1
gksantanaBellEqHigh init 1
gksantanaBellFader init 1
gksantanaBellPan init 50

instr santanaBellSndwarp
    kamplitude = p4
    iGrainMode = p7


    SsampleFilePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"
    iFileNumChannels filenchnls SsampleFilePath
    isantanaBellFileSampleRate filesr SsampleFilePath
    isantanaBellTableLength getTableSizeFromSample SsampleFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

    isantanaBellTable ftgenonce 0, 0, isantanaBellTableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = isantanaBellTable

    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iGrainMode == 0 then
      ; ares grain xamp, xpitch, xdens, kampoff, kpitchoff, kgdur, igfn, iwfn, imgdur [, igrnd]
      kpitch = 44100 / ftlen(isantanaBellTable)
      iGrainOffsetRandomness = 1
      kDensity = 10
      kAmplitudeOffset = 5
      kPitchOffset = 50
      kGrainDuration = 10
      iMaxGrainDuration = .1

      asantanaBellL grain kamplitude, kpitch, kDensity, kAmplitudeOffset, kPitchOffset, kGrainDuration, isantanaBellTable, ienvelopeTable, iMaxGrainDuration , iGrainOffsetRandomness

      asantanaBellR = asantanaBellL

    elseif iGrainMode == 1 then
      ; ares grain2 kcps, kfmd, kgdur, iovrlp, kfn, iwfn [, irpow] [, iseed] [, imode]

      kGrainFrequency = 44100 / ftlen(isantanaBellTable)
      kRandomFrequencyVariation = 0
      kGrainDuration = .01
      iOverlap = 200
      iMode = 10
      iFrequencyRandomnessDistribution = 0
      iRandomnessSeed = 0

      asantanaBellL grain2 kGrainFrequency, kRandomFrequencyVariation, kGrainDuration, iOverlap, isantanaBellTable, ienvelopeTable, iFrequencyRandomnessDistribution, iRandomnessSeed, iMode

      asantanaBellR = asantanaBellL

    elseif iGrainMode == 2 then
      ; ares grain3 kcps, kphs, kfmd, kpmd, kgdur, kdens, imaxovr, kfn, iwfn, kfrpow, kprpow [, iseed] [, imode]

      kGrainFrequency = 44100 / ftlen(isantanaBellTable)
      kGrainPhase = .01
      kRandomFrequencyVariation = 0
      kRandomPhaseVariation = 0
      kGrainDuration = .01
      kGrainsPerSecond = 100
      iMaxOverlaps = 200
      kFrequencyRandomnessDistribution = 0
      kPhaseRandomnessDistribution = 0
      iRandomnessSeed = 0
      iMode = 10

      asantanaBellL grain3 kGrainFrequency, kGrainPhase, kRandomFrequencyVariation, kRandomPhaseVariation, kGrainDuration, kGrainsPerSecond, iMaxOverlaps, isantanaBellTable, ienvelopeTable, kFrequencyRandomnessDistribution, kPhaseRandomnessDistribution, iRandomnessSeed, iMode

      asantanaBellR = asantanaBellL
    elseif iGrainMode == 3 then
      ; asig syncgrain kamp, kfreq, kpitch, kgrsize, kprate, ifun1, ifun2, iolaps

      kGrainDensity = 200
      kPitch = 1
      kGrainSize = 0.01
      kPointerRate = 1
      iMaximumOverlaps = 200


      asantanaBellL syncgrain kamplitude, kGrainDensity, kPitch, kGrainSize, kPointerRate, isantanaBellTable, ienvelopeTable, iMaximumOverlaps

      asantanaBellR = asantanaBellL
    elseif iGrainMode == 4 then
      ; ares [, ac] sndwarp xamp, xtimewarp, xresample, ifn1, ibeg, iwsize, irandw, ioverlap, ifn2, itimemode


      ibeginningTime =  p5
      iWarpStart = (giBPM)/112 * 2 * p6

      ktimewarp linseg ((giBPM)/112 * 2 * p6), p3/2, ((giBPM)/112 * 3 * p6), p3/2, ((giBPM)/112 * .2 * p6)
      kresample = 1
      ioverlap = 20
      iwindowSize = 10

      asantanaBellL, asantanaBellR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iGrainMode == 5 then
      ; ares fog xamp, xdens, xtrans, aspd, koct, kband, kris, kdur, kdec, iolaps, ifna, ifnb, itotdur [, iphs] [, itmode] [, iskip]

      kGrainDensity = 200
      kTranspose = 1
      aStartingPointerIndex = 0
      kOctaiviantIndex = 0

      kGrainEnvelopeBand = 0
      kGrainEnvelopeRise = 0.01
      kGrainEnvelopeDuration = 0.5
      kGrainEnvelopeDecay = 0.01

      iOverlaps = 200
      iTotalDuration = p3

      iTable ftgenonce 2, 0, 1024, 19, .5, .5, 270, .5
      ienvelopeTable = iTable
      iInitialPhase = 0
      iTranspositionMode= 1
      iSkipTime = 0

      asantanaBellL fog kamplitude, kGrainDensity, kTranspose, aStartingPointerIndex, kOctaiviantIndex, kGrainEnvelopeBand, kGrainEnvelopeRise, kGrainEnvelopeDuration, kGrainEnvelopeDecay, iOverlaps, isampleTable, ienvelopeTable, iTotalDuration, iInitialPhase, iTranspositionMode, iSkipTime
      asantanaBellR = asantanaBellL

    elseif iGrainMode ==6 then
      ; ares granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, \
      ; igskip_os, ilength, kgap, igap_os, kgsize, igsize_os, iatt, idec \
      ; [, iseed] [, ipitch1] [, ipitch2] [, ipitch3] [, ipitch4] [, ifnenv]

      iNumberOfVoices = 4
      iSpeedRatio = 1
      iPointerMode = 1
      iThreshhold = 0
      iNumberOfPitchShifts = 4
      iSkipTime = 0
      iSkipTimeRandomOffset = 0
      iTableLengthAfterSkipTime = isantanaBellTableLength - (isantanaBellFileSampleRate * iSkipTime)
      kGapBetweenGrains = 0
      iGapRandomOffset = 0
      kGrainSize = .01
      iGrainSizeRandomOffset = 0
      iGrainEnvelopeAttackInPercent = 3
      iGrainEnvelopeDecayInPercent = 3
      iRandomSeed = 0
      ipitch1 = 1
      ipitch2 = 1
      ipitch3 = 1
      ipitch4 = 1


      asantanaBellL granule kamplitude, iNumberOfVoices, iSpeedRatio, iPointerMode, iThreshhold, isampleTable, iNumberOfPitchShifts, iSkipTime, iSkipTimeRandomOffset, iTableLengthAfterSkipTime, kGapBetweenGrains, iGapRandomOffset, kGrainSize, iGrainSizeRandomOffset, iGrainEnvelopeAttackInPercent, iGrainEnvelopeDecayInPercent, iRandomSeed, ipitch1, ipitch2, ipitch3, ipitch4, ienvelopeTable

      asantanaBellR = asantanaBellL

    elseif iGrainMode ==6 then
      ; a1 [, a2, a3, a4, a5, a6, a7, a8] partikkel agrainfreq, \
      ;kdistribution, idisttab, async, kenv2amt, ienv2tab, ienv_attack, \
      ;ienv_decay, ksustain_amount, ka_d_ratio, kduration, kamp, igainmasks, \
      ;kwavfreq, ksweepshape, iwavfreqstarttab, iwavfreqendtab, awavfm, \
      ;ifmamptab, kfmenv, icosine, ktraincps, knumpartials, kchroma, \
      ;ichannelmasks, krandommask, kwaveform1, kwaveform2, kwaveform3, \
      ;kwaveform4, iwaveamptab, asamplepos1, asamplepos2, asamplepos3, \
      ;asamplepos4, kwavekey1, kwavekey2, kwavekey3, kwavekey4, imax_grains \
      ;[, iopcode_id]
      iSineTable    ftgenonce 0, 0, 65537, 10, 1
      iCosineTable  ftgenonce 0, 0, 8193, 9, 1, 1, 90

      kGrainFrequency = 100
      kGrainDistribution = 0
      iGrainDisplacementTable = 0
      aSyncInput = 1
      kSecondaryEnvelopeAmount = 0
      iSecondaryEnvelopeTable = -1
      iEnvelopeAttackTable = -1
      iEnvelopeDecayTable = -1
      kSustainTime = .5
      kAttackDecayRatio = .5
      kGrainDuration = 10
      kamplitude = kamplitude
      iGainMaskTable = -1
      kWaveFrequency = 1
      kSweepShape = .5
      iWaveFrequencyStartTable = -1
      iWaveFrequencyEndTable = -1
      aFrequencyModulationWave = 1
      iFrequencyModulationAmmountTable = -1
      kFrequencyModulationEnvelopeTable = iSineTable
      iCosineTable = 0
      kTrainletFundamentalFrequency = 1000
      kNumberOfPartials = 1
      kChroma = 1
      iChannelMasksTable = -1
      kRandomMasking = 0
      kwaveform1 = isampleTable
      kwaveform2 = isampleTable
      kwaveform3 = isampleTable
      kwaveform4 = isampleTable
      iwaveamptab = -1
      aSampleStartPosition1 = 0
      aSampleStartPosition2 = 0
      aSampleStartPosition3 = 0
      aSampleStartPosition4 = 0
      kwavekey1 = 1
      kwavekey2 = 1
      kwavekey3 = 1
      kwavekey4 = 1
      iMaxGrainsPerKPeriod = 100
      iOpcodeId = 0

      asantanaBellL partikkel kGrainFrequency, kGrainDistribution, iGrainDisplacementTable, aSyncInput, kSecondaryEnvelopeAmount, iSecondaryEnvelopeTable, iEnvelopeAttackTable, iEnvelopeDecayTable, kSustainTime, kAttackDecayRatio, kGrainDuration, kamplitude, iGainMaskTable, kWaveFrequency, kSweepShape, iWaveFrequencyStartTable, iWaveFrequencyEndTable, aFrequencyModulationWave, iFrequencyModulationAmmountTable, kFrequencyModulationEnvelopeTable, iCosineTable, kTrainletFundamentalFrequency, kNumberOfPartials, kChroma, iChannelMasksTable, kRandomMasking, kwaveform1, kwaveform2, kwaveform3, kwaveform4, iwaveamptab, aSampleStartPosition1, aSampleStartPosition2, aSampleStartPosition3, aSampleStartPosition4, kwavekey1, kwavekey2, kwavekey3, kwavekey4, iMaxGrainsPerKPeriod, iOpcodeId
      asantanaBellR = asantanaBellL

    endif


    outleta "santanaBellOutL", asantanaBellL
    outleta "santanaBellOutR", asantanaBellR

endin

instr santanaBellBassKnob
    gksantanaBellEqBass linseg p4, p3, p5
endin

instr santanaBellMidKnob
    gksantanaBellEqMid linseg p4, p3, p5
endin

instr santanaBellHighKnob
    gksantanaBellEqHigh linseg p4, p3, p5
endin

instr santanaBellFader
    gksantanaBellFader linseg p4, p3, p5
endin

instr santanaBellPan
    gksantanaBellPan linseg p4, p3, p5
endin

instr santanaBellMixerChannel
    asantanaBellL inleta "santanaBellInL"
    asantanaBellR inleta "santanaBellInR"

    ksantanaBellFader = gksantanaBellFader
    ksantanaBellPan = gksantanaBellPan
    ksantanaBellEqBass = gksantanaBellEqBass
    ksantanaBellEqMid = gksantanaBellEqMid
    ksantanaBellEqHigh = gksantanaBellEqHigh

    asantanaBellL, asantanaBellR threeBandEqStereo asantanaBellL, asantanaBellR, ksantanaBellEqBass, ksantanaBellEqMid, ksantanaBellEqHigh

    if ksantanaBellPan > 100 then
        ksantanaBellPan = 100
    elseif ksantanaBellPan < 0 then
        ksantanaBellPan = 0
    endif

    asantanaBellL = (asantanaBellL * ((100 - ksantanaBellPan) * 2 / 100)) * ksantanaBellFader
    asantanaBellR = (asantanaBellR * (ksantanaBellPan * 2 / 100)) * ksantanaBellFader


    outleta "santanaBellOutL", asantanaBellL
    outleta "santanaBellOutR", asantanaBellR
endin

