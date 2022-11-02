/*
  TB_303
  Creates an instrument that emulates the Roland TB-303. Based on
  code by Josep M� Comajuncosas (gelida@intercom.es), Sept - Nov 1997.

  Global Variables:
    TO DO

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    TO DO

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
*/

#define TB_303(INSTRUMENT_NAME'ROUTE) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"
  gi$INSTRUMENT_NAME.SineTable ftgenonce 0, 0, 8192, 10, 1; sine wave
  ; gi$INSTRUMENT_NAME.AccentCurveTable ftgenonce 0, 0, 8193, 8, 0, 512, 1, 1024, 1, 512, .5, 2048, .2, 4096, 0
  gi$INSTRUMENT_NAME.AccentCurveTable ftgenonce 0, 0, 8193, 8, 0, 512, 1, 1024, 1, 512, .5, 2048, .2, 4096, 0

  gk$INSTRUMENT_NAME.CutoffFrequency init 1
  gk$INSTRUMENT_NAME.Resonance init 1
  gk$INSTRUMENT_NAME.EnvMod init 1
  gk$INSTRUMENT_NAME.Decay init 1
  gk$INSTRUMENT_NAME.Accent init 1
  gk$INSTRUMENT_NAME.BPM init i(gkBPM)


  instr $INSTRUMENT_NAME
    ; initial settings; control the overall character of the sound
    iMaxFrequency = 1000; max.filter cutoff freq. when ienvmod = 0
    iMaxSweep = 10000; sr/2... max.filter freq. at kEnvMod & kAccent= 1
    iResonance = 1;scale the resonance as you like (you can make the filter to oscillate...)

    ; init variables; don�t touch this!
    iBPM = p14; 4/4 bars per minute (or beats?)
    iBPM = i(gk$INSTRUMENT_NAME.BPM)

    iTranspose = p15; 1 raise the whole seq. 1 octave, etc.

    iSequencerTable = p16
    iAccentTable = p17
    iDurationTable = p18

    iMaximumAmplitude = velocityToAmplitude(p19); maximum amplitude. Max 32768 for 16 bit output
    iNoteDuration = 15/iBPM
    iMinDecay = (iNoteDuration < .2 ? .2 : iNoteDuration); set minimum decay to .2 or iNoteDuration
    kAccentCurve     init 0

    ; twisting the knobs from the score
    kCutoffFrequency       line p4, p3, p5
    kResonance       line p6, p3, p7
    kEnvMod    line p8, p3, p9
    kDecay     line p10, p3, p11
    kAccent    line p12, p3, p13

    kCutoffFrequency *= gk$INSTRUMENT_NAME.CutoffFrequency
    kResonance *= gk$INSTRUMENT_NAME.Resonance
    kEnvMod *= gk$INSTRUMENT_NAME.EnvMod
    kDecay *= gk$INSTRUMENT_NAME.Decay
    kAccent *= gk$INSTRUMENT_NAME.Accent


    iCount init 0; sequence counter (for notes)
    iCount2 init 0; id. for durations
    iPortamentoCount2 init 0
    iPitch table 0, iSequencerTable; first note in the sequence
    iPitch = cpspch(iTranspose + 6 + iPitch/100)

    start:
      ;pitch & portamento from the sequence
      iPortamentoPitch = iPitch
      iPitch table ftlen(iSequencerTable)*frac(iCount/ftlen(iSequencerTable)), iSequencerTable
      iPitch = cpspch(iTranspose + 6 + iPitch/100)
      kPitch = iPitch

      if iPortamentoCount2 != iCount2 then
        kPitch linseg iPortamentoPitch, .06, iPitch, iNoteDuration-.06, iPitch
      endif

    next:
      iPortamentoCount2 = iCount2
      timout 0, iNoteDuration, contin
      iCount += 1
      reinit start
      rireturn

    contin:
      ; accent detector
      iAccent table ftlen(iAccentTable)*frac((iCount-1)/ftlen(iAccentTable)), iAccentTable
      if iAccent == 0 then
        kAccentCurve = 0; no accent & "discharges" accent curve
        ienvdecay = i(kDecay)
      else
        ienvdecay = 0; accented notes are the shortest ones
        iremacc = i(kAccentCurve)
        kAccentCurve oscil1i 0, 1, .4, gi$INSTRUMENT_NAME.AccentCurveTable
        kAccentCurve = kAccentCurve+iremacc;successive accents cause hysterical raising cutoff
      endif

      goto sequencer

    sequencer:
      aRemoveDc init 0; set feedback to 0 at every event
      iDurationMultiplier table ftlen(iDurationTable)*frac(iCount2/ftlen(iDurationTable)),iDurationTable
      if iDurationMultiplier != 0 goto noproblemo; compensate for zero padding in the sequencer
      iCount2 = iCount2 + 1
      goto sequencer

    noproblemo:
      iEventDuration = iNoteDuration * iDurationMultiplier

    ; two envelopes
    kMeg expseg 1, iMinDecay + ((iEventDuration-iMinDecay)*ienvdecay), ienvdecay + .000001
    kVeg linen 1, .01, iEventDuration, .016; attack should be 4 ms. but there would be clicks...

    ; amplitude envelope
    kAmplitudeEnvelope = kVeg*((1-i(kEnvMod)) + kMeg*i(kEnvMod)*(.5+.5*iAccent*kAccent))

    ; filter envelope
    ksweep = kVeg * (iMaxFrequency + (.75*kMeg+.25*kAccentCurve*kAccent)*kEnvMod*(iMaxSweep-iMaxFrequency))
    kCutoffFrequency = 20 + kCutoffFrequency * ksweep; cutoff always greater than 20 Hz ...
    kCutoffFrequency = (kCutoffFrequency > sr/2 ? sr/2 : kCutoffFrequency); could be necessary

    timout 0, iEventDuration, out
    iCount2 = iCount2 + 1
    reinit contin

    out:
      ; generate bandlimited sawtooth wave
      aBuzz buzz kAmplitudeEnvelope, kPitch, sr/(4*kPitch), gi$INSTRUMENT_NAME.SineTable, 0 ;bandlimited pulse (up to sr/4)
      aSaw integ aBuzz,0
      aSawDc atone aSaw,1

      ; resonant 4-pole LPF
      kNormalizedFrequency = kCutoffFrequency/sr; frequency normalized (0, 1/4)
      kCorr = 1 - (4 * kNormalizedFrequency); some empyrical tuning...
      kResonance = kResonance/kCorr; more feedback for higher frequencies

      aInput = aSawDc - aRemoveDc * kResonance * iResonance
      aLPF tone aInput, kCutoffFrequency
      aLPF tone aLPF, kCutoffFrequency
      aLPF tone aLPF, kCutoffFrequency
      aLPF tone aLPF, kCutoffFrequency

      aOut balance aLPF, aSawDc; <- balance causes clicks,
      ; but it is the fastest solution to amplitude problems ;-)

      ;final output ... at last!
      aRemoveDc atone aOut, 10

      aSignalOut = iMaximumAmplitude * aRemoveDc


    outleta "OutL", aSignalOut
    outleta "OutR", aSignalOut
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
