#define BITCRUSHER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.BitDepth init 16
  gk$INSTRUMENT_NAME.SampleRate init 44100
  gk$INSTRUMENT_NAME.BitDepthModifier init 1
  gk$INSTRUMENT_NAME.SampleRateModifier init 1
  gk$INSTRUMENT_NAME.AntiAlias init 0
  gk$INSTRUMENT_NAME.PreGain init 1
  gk$INSTRUMENT_NAME.PostGain init 1
  gk$INSTRUMENT_NAME.RoundingMethod init 0

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    aInL *= gk$INSTRUMENT_NAME.PreGain
    aInR *= gk$INSTRUMENT_NAME.PreGain

    kBitDepth = (p4 == 0 ? gk$INSTRUMENT_NAME.BitDepth : p4) * gk$INSTRUMENT_NAME.BitDepthModifier
    kBitDepth = limit(kBitDepth, 2, 64)
    kSampleRate = (p5 == 0 ? gk$INSTRUMENT_NAME.SampleRate : p5) * gk$INSTRUMENT_NAME.SampleRateModifier
    kRoundingMethod = p6 == 0 ? gk$INSTRUMENT_NAME.RoundingMethod : p6

    kNyquist = gk$INSTRUMENT_NAME.SampleRate/2
    if gk$INSTRUMENT_NAME.AntiAlias != 0 then
      ; This kinda sucks and I don't think it's working well. The idea
      ; is to hard cut everything above the nyquist frequency before
      ; processing.
      aInL pareq aInL, kNyquist, 0, sqrt(.5), 2
      aInR pareq aInR, kNyquist, 0, sqrt(.5), 2
    endif

    ; This number is halved because audio resolution
    ; represents the number of possible values above and below zero.
    ; The range of values for 16-bit samples is between -32,768 and 32,767.
    ; So we should be scaling our values to one half of the bit depth.
    kResolutionOut = 2^kBitDepth/2 - 1

    iAmpValueScale = 0dbfs

    ; Scale sample value to new resolution
    aOutL = aInL/iAmpValueScale * kResolutionOut
    aOutR = aInR/iAmpValueScale * kResolutionOut

    ; Round the sample value - These all give a slightly different sound
    if kRoundingMethod == 2 then
      aOutL = int(aOutL)
      aOutR = int(aOutR)
    elseif kRoundingMethod == 1 then
      aOutL = floor(aOutL)
      aOutR = floor(aOutR)
    else
      aOutL = round(aOutL)
      aOutR = round(aOutR)
    endif

    ; Scale it back to 0dbfs
    aOutL = aOutL/kResolutionOut * iAmpValueScale
    aOutR = aOutR/kResolutionOut * iAmpValueScale

    /* Notes and code from my method of doing this with samphold */
    ; This is a rude attempt at an a rate metro equivalent to gate
    ; samples. The osillator should exceed once per sample rate and
    ; the whole thing gets rounded down to make it strictly binary.
    ; It seems to work as intended but it feels a little hacky and
    ; imprecise.
    ; aGate = round:a(poscil:a(.5, gk$INSTRUMENT_NAME.SampleRate, -1, .25)+.6)

    ; As opposed to the above, mpulse appears to be the actual intended
    ; opcode for this kind of thing. Unfortunately, when smoothly changing
    ; the sample rate I hear stepped changes instead of a smooth sweep. I
    ; would really prefer to use this over the above but that's kind of a
    ; dealbreaker. Is this something internal to the opcode? Or am I misusing
    ; it? Is it because the interval input is k rate?
    ; aGate = mpulse:a(1, -sr/gk$INSTRUMENT_NAME.SampleRate)
    ; aOutL = samphold(aOutL, aGate)
    ; aOutR = samphold(aOutR, aGate)

    /* Notes and code from the fold method */
    ; It seems like the REAL ACTUAL opcode for reducing sample rate is fold.
    ; But I'm reluctant to use it because it's so jargony and high concept.
    ; I don't understand what the term "foldover" actually means mathematically.
    ; Whereas the samphold method is easily understood by jerks like me: It
    ; doesn't change the sample until the gate tells it too. Simple. However
    ; Iain McCurdy does it this way so it's probably actually the best way.
    ; After some testing I've found that it sounds indistinguisable from the above.
    ; I guess I'll just use it since its more concise.
    aOutL = fold(aOutL, sr/gk$INSTRUMENT_NAME.SampleRate)
    aOutR = fold(aOutR, sr/gk$INSTRUMENT_NAME.SampleRate)

    ; This is just a volume attenuation based on how low the resolution
    ; goes to keep the output volume roughly around the input volume.
    ; It's a pretty goofy equation I just tried to tune by ear to not
    ; attenuate for any bit depth above 6 and to increasingly attenuate as
    ; the bit depth goes lower.
    kAttenuationForBitDepth = sin(limit(kBitDepth, 0, 6)/4)^3
    aOutL *= kAttenuationForBitDepth
    aOutR *= kAttenuationForBitDepth

    aOutL *= gk$INSTRUMENT_NAME.PostGain
    aOutR *= gk$INSTRUMENT_NAME.PostGain

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
