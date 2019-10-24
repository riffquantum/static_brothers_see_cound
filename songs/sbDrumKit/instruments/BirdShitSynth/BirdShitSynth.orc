alwayson "BirdShitSynthMixerChannel"
alwayson "BirdShitSynthDistortion"
alwayson "BirdShitSynthDistortionMixerChannel"

gSBirdShitSynthName = "BirdShitSynth"
gSBirdShitSynthRoute = "BirdShitSynthDistortion"
instrumentRoute gSBirdShitSynthName, gSBirdShitSynthRoute
gkBirdShitSynthEqBass init 1
gkBirdShitSynthEqMid init 1
gkBirdShitSynthEqHigh init 1
gkBirdShitSynthFader init 1
gkBirdShitSynthPan init 50

gkBirdShitSynthDistortionEqBass init 1
gkBirdShitSynthDistortionEqMid init 1
gkBirdShitSynthDistortionEqHigh init 1
gkBirdShitSynthDistortionFader init 1
gkBirdShitSynthDistortionPan init 50
gSBirdShitSynthDistortionName = "BirdShitSynthDistortion"
gSBirdShitSynthDistortionRoute = "Mixer"
instrumentRoute gSBirdShitSynthDistortionName, gSBirdShitSynthDistortionRoute

/* MIDI Config Values */
;massign giBirdShitSynthMidiChannel, "BirdShitSynth"


instr BirdShitSynth
    iAmplitude flexibleAmplitudeInput p4
    iPitch flexiblePitchInput p5
    iSineTable sineWave
    kTremolo = .75 + oscil(.25, 1.5, iSineTable)
    kAmplitudeEnvelope = madsr(.005, .01, iAmplitude, .5, 0)
    kAmplitudeEnvelope = kAmplitudeEnvelope * kTremolo


    aBirdShitSynthL = oscil(kAmplitudeEnvelope*0.5, iPitch*1.1, iSineTable)
    aBirdShitSynthL += oscil(kAmplitudeEnvelope, iPitch*1.1*.5, iSineTable)
    aBirdShitSynthL += oscil(kAmplitudeEnvelope*0.25, iPitch*1.1*.9, iSineTable)

    aBirdShitSynthR = oscil(kAmplitudeEnvelope*0.5, iPitch*.9, iSineTable)
    aBirdShitSynthR += oscil(kAmplitudeEnvelope, iPitch*.9*.5, iSineTable)
    aBirdShitSynthR += oscil(kAmplitudeEnvelope*0.25, iPitch*.9*.9, iSineTable)


    outleta "BirdShitSynthOutL", aBirdShitSynthL
    outleta "BirdShitSynthOutR", aBirdShitSynthR
endin

instr BirdShitSynthBassKnob
    gkBirdShitSynthEqBass linseg p4, p3, p5
endin

instr BirdShitSynthMidKnob
    gkBirdShitSynthEqMid linseg p4, p3, p5
endin

instr BirdShitSynthHighKnob
    gkBirdShitSynthEqHigh linseg p4, p3, p5
endin

instr BirdShitSynthFader
    gkBirdShitSynthFader linseg p4, p3, p5
endin

instr BirdShitSynthPan
    gkBirdShitSynthPan linseg p4, p3, p5
endin

instr BirdShitSynthMixerChannel
    aBirdShitSynthL inleta "BirdShitSynthInL"
    aBirdShitSynthR inleta "BirdShitSynthInR"

    kBirdShitSynthFader = gkBirdShitSynthFader
    kBirdShitSynthPan = gkBirdShitSynthPan
    kBirdShitSynthEqBass = gkBirdShitSynthEqBass
    kBirdShitSynthEqMid = gkBirdShitSynthEqMid
    kBirdShitSynthEqHigh = gkBirdShitSynthEqHigh

    aBirdShitSynthL, aBirdShitSynthR threeBandEqStereo aBirdShitSynthL, aBirdShitSynthR, kBirdShitSynthEqBass, kBirdShitSynthEqMid, kBirdShitSynthEqHigh

    if kBirdShitSynthPan > 100 then
        kBirdShitSynthPan = 100
    elseif kBirdShitSynthPan < 0 then
        kBirdShitSynthPan = 0
    endif

    aBirdShitSynthL = (aBirdShitSynthL * ((100 - kBirdShitSynthPan) * 2 / 100)) * kBirdShitSynthFader
    aBirdShitSynthR = (aBirdShitSynthR * (kBirdShitSynthPan * 2 / 100)) * kBirdShitSynthFader

    outleta "BirdShitSynthOutL", aBirdShitSynthL
    outleta "BirdShitSynthOutR", aBirdShitSynthR
endin

instr BirdShitSynthDistortion
  aBirdShitSynthDistortionInL inleta "BirdShitSynthDistortionInL"
  aBirdShitSynthDistortionInR inleta "BirdShitSynthDistortionInR"

  aBirdShitSynthDistortionOutL = aBirdShitSynthDistortionInL
  aBirdShitSynthDistortionOutR = aBirdShitSynthDistortionInR

  aBirdShitSynthDistortionOutL += distortion(aBirdShitSynthDistortionOutL, 1.3, .7, .1, .1)
  aBirdShitSynthDistortionOutR += distortion(aBirdShitSynthDistortionOutR, 1.3, .7, .1, .1)

  aBirdShitSynthDistortionOutL = clip(aBirdShitSynthDistortionOutL * 1.3, 1, 1, 0)
  aBirdShitSynthDistortionOutR = clip(aBirdShitSynthDistortionOutL * 1.3, 1, 1, 0)

  aBirdShitSynthDistortionOutL = butterlp(aBirdShitSynthDistortionOutL, 5000)
  aBirdShitSynthDistortionOutR = butterlp(aBirdShitSynthDistortionOutR, 5000)

  outleta "BirdShitSynthDistortionOutL", aBirdShitSynthDistortionOutL
  outleta "BirdShitSynthDistortionOutR", aBirdShitSynthDistortionOutR
endin

instr BirdShitSynthDistortionBassKnob
  gkBirdShitSynthDistortionEqBass linseg p4, p3, p5
endin

instr BirdShitSynthDistortionMidKnob
  gkBirdShitSynthDistortionEqMid linseg p4, p3, p5
endin

instr BirdShitSynthDistortionHighKnob
  gkBirdShitSynthDistortionEqHigh linseg p4, p3, p5
endin

instr BirdShitSynthDistortionFader
  gkBirdShitSynthDistortionFader linseg p4, p3, p5
endin

instr BirdShitSynthDistortionPan
  gkBirdShitSynthDistortionPan linseg p4, p3, p5
endin

instr BirdShitSynthDistortionMixerChannel
  aBirdShitSynthDistortionL inleta "BirdShitSynthDistortionInL"
  aBirdShitSynthDistortionR inleta "BirdShitSynthDistortionInR"

  kBirdShitSynthDistortionFader = gkBirdShitSynthDistortionFader
  kBirdShitSynthDistortionPan = gkBirdShitSynthDistortionPan
  kBirdShitSynthDistortionEqBass = gkBirdShitSynthDistortionEqBass
  kBirdShitSynthDistortionEqMid = gkBirdShitSynthDistortionEqMid
  kBirdShitSynthDistortionEqHigh = gkBirdShitSynthDistortionEqHigh

  aBirdShitSynthDistortionL, aBirdShitSynthDistortionR threeBandEqStereo aBirdShitSynthDistortionL, aBirdShitSynthDistortionR, kBirdShitSynthDistortionEqBass, kBirdShitSynthDistortionEqMid, kBirdShitSynthDistortionEqHigh

  if kBirdShitSynthDistortionPan > 100 then
      kBirdShitSynthDistortionPan = 100
  elseif kBirdShitSynthDistortionPan < 0 then
      kBirdShitSynthDistortionPan = 0
  endif

  aBirdShitSynthDistortionL = (aBirdShitSynthDistortionL * ((100 - kBirdShitSynthDistortionPan) * 2 / 100)) * kBirdShitSynthDistortionFader
  aBirdShitSynthDistortionR = (aBirdShitSynthDistortionR * (kBirdShitSynthDistortionPan * 2 / 100)) * kBirdShitSynthDistortionFader

  outleta "BirdShitSynthDistortionOutL", aBirdShitSynthDistortionL
  outleta "BirdShitSynthDistortionOutR", aBirdShitSynthDistortionR
endin
