; Roland TB-303 bassline emulator
; Downloaded here: http://www.csounds.com/jmc/Articles/Analog/analog.html
; This is a TB303 emulator written by Josep Mª Comajuncosas and adapted
; for use in this environment.




/*
In Progress Dev notes

I think this would read better if we split up the synsethizer and the sequencer into two different instruments. The sequencer can trigger notes on the synsethizer. One challenge there is that this is supposed to be monophonic.




*/

connect "TB303Synthesizer", "TB303Out", "TB303MixerChannel", "TB303In"
alwayson "TB303MixerChannel"

gkTB303EqBass init 1
gkTB303EqMid init 1
gkTB303EqHigh init 1
gkTB303Fader init 1
gkTB303Pan init 50

gkTB303Tuning init .5
gkTB303CutOffFreq init .1
gkTB303Resonance init .1
gkTB303EnvMod init .1
gkTB303Decay init .5
gkTB303Accent init 1
gSTB303Waveform init "Sawtooth"

gkTB303SawtoothTable init 1
gkTB303SquareTable init 1

instr TB303Sequencer
  iBPM                = (p4>30 ? p4 : p4*giBPM) ; A low number will multiply the global BPM. A high one will set it explicitly.
  iTranspose          = p5 ; Is this a feature on the real thing? It is, it's on a note by note basis I think. Gives the little keyboard 3 octaves of range instead of 1
  ;The Sequencer Aspect should have 4 different tables that plot out
  ; pitches, durations, accents, and slides.
  iPitchSequenceTable = p6
  iAccentsTable       = p7
  iDurationsTable     = p8
  iSlidesTable        = p9
  iMaximumAmplitude   = p10; maximum amplitude. Max 32768 for 16 bit output

  iStartTime = p2

  iPitchSequenceIndex init 0
  iPitchSequenceTableLength ftlen iPitchSequenceTable
  pitchLoop:
    iTotalDurationForNote table iPitchSequenceIndex, iDurationsTable

    iNoteStartingIndex = iPitchSequenceIndex
    iNoteEndingIndex = iPitchSequenceIndex

    iSlideLoopIndex = iPitchSequenceIndex
    slideLoop:
      if table(iSlideLoopIndex, iSlidesTable) == 1 && (iPitchSequenceIndex + 1) < iPitchSequenceTableLength then
        iNoteEndingIndex = iNoteEndingIndex + 1
        iSlideLoopIndex = iSlideLoopIndex + 1
        iPitchSequenceIndex = iPitchSequenceIndex + 1

        iTotalDurationForNote = iTotalDurationForNote + table(iPitchSequenceIndex, iDurationsTable)

        goto slideLoop
      endif

    iPitchSequenceTableSlice sliceTable iPitchSequenceTable, iNoteStartingIndex, iNoteEndingIndex
    iAccentsTableSlice sliceTable iAccentsTable, iNoteStartingIndex, iNoteEndingIndex
    iDurationsTableSlice sliceTable iDurationsTable, iNoteStartingIndex, iNoteEndingIndex

    event_i   "i", "TB303Synthesizer", iStartTime, iTotalDurationForNote, iPitchSequenceTableSlice, iAccentsTableSlice, iDurationsTableSlice, iMaximumAmplitude

    iStartTime += iTotalDurationForNote

  loop_lt iPitchSequenceIndex, 1, iPitchSequenceTableLength, pitchLoop
endin

instr TB303Synthesizer
  iPitches = p4
  iAccents = p5
  iDurations = p6
  iMaximumAmplitude = p7

  kTuning = gkTB303Tuning
  kCutOffFrequency = gkTB303CutOffFreq
  kResonance = gkTB303Resonance
  kEnvMod = gkTB303EnvMod
  kDecay = gkTB303Decay
  kAccent = gkTB303Accent


  kAccent = gkTB303Accent
  kAccentCurve init 0

  kEnvMod = gkTB303EnvMod

  kDecay = gkTB303Decay
  ienvdecay = i(kDecay)

  iAccent table 0, iAccents

  ; initial settings; control the overall character of the sound
  imaxfreq      = 1000; max.filter cutoff freq. when ienvmod = 0
  imaxsweep     = 10000; sr/2... max.filter freq. at kEnvMod & kAccent= 1
  ireson        = 1;scale the resonance as you like (you can make the filter to oscillate...)

  prints "%n%nTHE SYNTH%n"
  prints "   Duration: %i %n",  p3

  prints "Pitches:"
  iPitches printTable iPitches

  prints "Durations:"
  iDurations printTable iDurations

  prints "Accents:"
  iAccents printTable iAccents

  ;1. Set up waveforms



  ;2. Select waveform based on global variable


  ;3. Set up pitch envelope based on notes and slides
  ;Loop through pitches
    ;kPitch = lineseg with each pitch for its duration
    ;How can I join line segments?

  iNumberOfPitches ftlen iPitches
  iPitchEnvelopeIndex = 0
  iPreviousDuration = 0
  iPreviousPitch = 0
  kPitchEnvelope = 0
  iSineWaveTable ftgenonce 0, 0, 16384, 20, 1

  pitchEnvelopeLoop:
    iPitch table iPitchEnvelopeIndex, iPitches
    iDuration table iPitchEnvelopeIndex, iDurations

    print iPitchEnvelopeIndex
    if iPitchEnvelopeIndex == 0 then
      prints "FIRST PITCH %i %n", iPitch
      kPitchEnvelope = linseg( iPitch, iDuration, iPitch)

    else
      prints "PITCH %i: %i %n", iPitchEnvelopeIndex+1, iPitch
      iSlideDuration = (iDuration > .06 ? .06 : iDuration * .3)
      iDurationAdjusted = iDuration - iSlideDuration
      iPreviousPitch table (iPitchEnvelopeIndex - 1), iPitches

      kPitchEnvelope = linseg( iPreviousPitch, iSlideDuration, iPitch, iDurationAdjusted, iPitch)
    endif
      print i(kPitchEnvelope)

    iPreviousDuration += iDuration
    iPitchEnvelopeIndex += 1

  timout 0, iDuration, Skip
  reinit pitchEnvelopeLoop

  Skip:

    if iAccent != 0 then
      iAccentCurveTable ftgenonce 0, 0, 8193,   8,  0, 512, 1, 1024, 1, 512, .5, 2048, .2, 4096,  0

      kAccentCurve oscil1i 0, 1, .4, iAccentCurveTable
    endif

    iDecayDuration = p3<.02 ? .02 : p3
    kmeg expseg 1, p3-(iDecayDuration*ienvdecay), ienvdecay+.000001
    kveg linen 1, .004, p3, .016; attack should be 4 ms. but there would be clicks...

    ; amplitude envelope
    kamp = kveg*((1-i(kEnvMod)) + kmeg*i(kEnvMod)*(.5+.5*iAccent*kAccent))

    ; filter envelope
    ksweep = kveg * (imaxfreq + (.75*kmeg+.25*kAccentCurve*kAccent)*kEnvMod*(imaxsweep-imaxfreq))
    kCutOffFrequency = 20 + kCutOffFrequency * ksweep; cutoff always greater than 20 Hz ...
    kCutOffFrequency = (kCutOffFrequency > sr/2 ? sr/2 : kCutOffFrequency); could be necessary

    abuzz buzz kamp, kPitchEnvelope, sr/(4*kPitchEnvelope), iSineWaveTable, 0;bandlimited pulse (up to sr/4)
    asaw integ abuzz,0
    asawdc atone asaw,1

    ; resonant 4-pole LPF
    kfcn = kCutOffFrequency/sr; frequency normalized (0, 1/4)
    kcorr =1-4*kfcn; some empyrical tuning...
    kResonance = kResonance/kcorr; more feedback for higher frequencies

    aremovedc = 1

    ainpt = asawdc - aremovedc*kResonance*ireson
    alpf tone ainpt,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency

    aout balance alpf,asawdc; <- balance causes clicks,
    ; but it is the fastest solution to amplitude problems ;-)

    ;final output ... at last!
    aremovedc atone aout,10

   ;outleta "TB303Out", aremovedc;, aTB303Drone


   aTB303 oscil kamp, kPitchEnvelope, iSineWaveTable
   outleta "TB303Out", aTB303
endin

instr TB303
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Roland TB-303 bassline emulator
  ; coded by Josep Mª Comajuncosas , Sept - Nov 1997
  ; send your comments (and money ;-)) to
  ; gelida@lix.intercom.es
  ; (from January´98 to gelida@intercom.es)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  iBPM                = (p4>30 ? p4 : p4*giBPM)
  iTranspose          = p5


  ;The Sequencer Aspect should have 4 different tables that plot out
  ; pitches, durations, accents, and slides.
  iPitchSequenceTable = p6
  iAccentsTable       = p7
  iDurationsTable     = p8
  iSlidesTable        = p9

  iMaximumAmplitude   = p10; maximum amplitude. Max 32768 for 16 bit output


  ; initial settings; control the overall character of the sound
  imaxfreq      = 1000; max.filter cutoff freq. when ienvmod = 0
  imaxsweep     = 10000; sr/2... max.filter freq. at kEnvMod & kAccent= 1
  ireson        = 1;scale the resonance as you like (you can make the filter to oscillate...)

  iSequencerCount          init 0; sequence counter (for notes)
  iDurationsCount          init 0; id. for durations
  iPreviousDurationsCount  init 0

  iNoteDuration  = 15/iBPM
  iDecayDuration = iNoteDuration
  imindecay      = (iDecayDuration<.2 ? .2 : iDecayDuration)
  iPitch         table 0, iPitchSequenceTable; first note in the sequence
  iPitch         = cpspch(iTranspose + 6 + iPitch/100)
  kAccentCurve       init 0

  kTuning          = gkTB303Tuning
  kCutOffFrequency = gkTB303CutOffFreq
  kResonance       = gkTB303Resonance
  kEnvMod          = gkTB303EnvMod
  kDecay           = gkTB303Decay
  kAccent          = gkTB303Accent

  iSineWave ftgenonce 0, 0, 8192, 10, 1

  start:
    ;pitch & portamento from the sequence
    iPreviousPitch = iPitch

    ; I guess this is a mathematical way to make a table wrap?
    ; Pretty cool but I think table now has a wrap mode as an optional
    ; argument
    iPitchIndex = ftlen(iPitchSequenceTable)*frac(iSequencerCount/ftlen(iPitchSequenceTable))

    iPitch table iPitchIndex, iPitchSequenceTable
    iPitch = cpspch(iTranspose + 6 + iPitch/100)

    if iPreviousDurationsCount != iDurationsCount goto noslide

    kPitch linseg iPreviousPitch, .06, iPitch, iNoteDuration-.06, iPitch
    goto next

  noslide:
    kPitch = iPitch

  next:
    iPreviousDurationsCount = iDurationsCount
    timout 0, iNoteDuration, contin
    iSequencerCount = iSequencerCount + 1
    reinit start
    rireturn

  contin:
    ; accent detector
    iAccentIndex = ftlen(iAccentsTable)*frac((iSequencerCount-1)/ftlen(iAccentsTable))
    iAccent table iAccentIndex, iAccentsTable
    if iAccent == 0 goto noaccent
    ienvdecay = 0; accented notes are the shortest ones
    iPreviousAccent = i(kAccentCurve)

    iAccentCurveTable ftgenonce 0, 0, 8193,   8,  0, 512, 1, 1024, 1, 512, .5, 2048, .2, 4096,  0

    kAccentCurve oscil1i 0, 1, .4, iAccentCurveTable
    kAccentCurve = kAccentCurve+iPreviousAccent;successive accents cause hysterical raising cutoff

    goto sequencer

  noaccent:
    kAccentCurve = 0; no accent & "discharges" accent curve
    ienvdecay = i(kDecay)

  sequencer:
    aremovedc init 0; set feedback to 0 at every event
    iDurationMultiplierIndex = ftlen(iDurationsTable)*frac(iDurationsCount/ftlen(iDurationsTable))

    iDurationMultiplier table iDurationMultiplierIndex,iDurationsTable
    if iDurationMultiplier != 0 goto noproblemo; compensate for zero padding in the sequencer
    iDurationsCount = iDurationsCount + 1
    goto sequencer

  noproblemo:
    iEventDuration = iNoteDuration*iDurationMultiplier

    ; two envelopes
    kmeg expseg 1, imindecay+((iEventDuration-imindecay)*ienvdecay), ienvdecay+.000001
    kveg linen 1, .01, iEventDuration, .016; attack should be 4 ms. but there would be clicks...

    ; amplitude envelope
    kamp = kveg*((1-i(kEnvMod)) + kmeg*i(kEnvMod)*(.5+.5*iAccent*kAccent))

    ; filter envelope
    ksweep = kveg * (imaxfreq + (.75*kmeg+.25*kAccentCurve*kAccent)*kEnvMod*(imaxsweep-imaxfreq))
    kCutOffFrequency = 20 + kCutOffFrequency * ksweep; cutoff always greater than 20 Hz ...
    kCutOffFrequency = (kCutOffFrequency > sr/2 ? sr/2 : kCutOffFrequency); could be necessary

    timout 0, iEventDuration, out
    iDurationsCount = iDurationsCount + 1
    reinit contin

  out:
    ; generate bandlimited sawtooth wave
    abuzz buzz kamp, kPitch, sr/(4*kPitch), iSineWave ,0;bandlimited pulse (up to sr/4)
    asaw integ abuzz,0
    asawdc atone asaw,1

    ; resonant 4-pole LPF
    kfcn = kCutOffFrequency/sr; frequency normalized (0, 1/4)
    kcorr =1-4*kfcn; some empyrical tuning...
    kResonance = kResonance/kcorr; more feedback for higher frequencies

    ainpt = asawdc - aremovedc*kResonance*ireson
    alpf tone ainpt,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency
    alpf tone alpf,kCutOffFrequency

    aout balance alpf,asawdc; <- balance causes clicks,
    ; but it is the fastest solution to amplitude problems ;-)

    ;final output ... at last!
    aremovedc atone aout,10

    outleta "TB303Out", iMaximumAmplitude*aremovedc
endin

instr TB303WaveformSwitch
  gkTB303Waveform = p4
endin

instr TB303TuningKnob
  ; This knob is not currently incorporated into the emulator but
  ; I included it because it's on the real thing.

  gkTB303Tuning line p4, p3, p5
endin

instr TB303CutOffFreqKnob
  gkTB303CutOffFreq line p4, p3, p5
endin

instr TB303ResonanceKnob
  gkTB303Resonance line p4, p3, p5
endin

instr TB303EnvModKnob
  gkTB303EnvMod line p4, p3, p5
endin

instr TB303DecayKnob
  gkTB303Decay line p4, p3, p5
endin

instr TB303AccentKnob
  gkTB303Accent line p4, p3, p5
endin

instr TB303BassKnob
    gkTB303EqBass linseg p4, p3, p5
endin

instr TB303MidKnob
    gkTB303EqMid linseg p4, p3, p5
endin

instr TB303HighKnob
    gkTB303EqHigh linseg p4, p3, p5
endin

instr TB303Fader
    gkTB303Fader linseg p4, p3, p5
endin

instr TB303Pan
    gkTB303Pan linseg p4, p3, p5
endin

instr TB303MixerChannel
    aTB303L inleta "TB303In"
    aTB303R inleta "TB303In"

    kTB303Fader = gkTB303Fader
    kTB303Pan = gkTB303Pan
    kTB303EqBass = gkTB303EqBass
    kTB303EqMid = gkTB303EqMid
    kTB303EqHigh = gkTB303EqHigh

    aTB303L, aTB303R threeBandEqStereo aTB303L, aTB303R, kTB303EqBass, kTB303EqMid, kTB303EqHigh

    if kTB303Pan > 100 then
        kTB303Pan = 100
    elseif kTB303Pan < 0 then
        kTB303Pan = 0
    endif

    aTB303L = (aTB303L * ((100 - kTB303Pan) * 2 / 100)) * kTB303Fader
    aTB303R = (aTB303R * (kTB303Pan * 2 / 100)) * kTB303Fader

    outleta "TB303OutL", aTB303L
    outleta "TB303OutR", aTB303R
endin


