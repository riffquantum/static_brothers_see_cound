; Roland TB-303 bassline emulator
; Downloaded here: http://www.csounds.com/jmc/Articles/Analog/analog.html
; This is a TB303 emulator written by Josep Mª Comajuncosas and adapted
; for use in this environment.

connect "TB303", "TB303Out", "TB303MixerChannel", "TB303In"
alwayson "TB303MixerChannel"

gkTB303EqBass init 1
gkTB303EqMid init 1
gkTB303EqHigh init 1
gkTB303Fader init 1
gkTB303Pan init 50

instr TB303
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Roland TB-303 bassline emulator
  ; coded by Josep Mª Comajuncosas , Sept - Nov 1997
  ; send your comments (and money ;-)) to
  ; gelida@lix.intercom.es
  ; (from January´98 to gelida@intercom.es)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  /*
  p field quick reference
  p4 - kfco start
  p5 - kfco end
  p6 - kres start
  p7 - kres end
  p8 - kenvmod start
  p9 - kenvmod end
  p10 - kdecay start
  p11 - kdecay end
  p12 - kaccent start
  p13 - kaccent end
  p14 - ibpm
  p15 - itranspose - 1 raise the whole seq. 1 octave, etc.
  p16 - iseqfn - function table for sequencer
  p17 - iaccfn - accent function table?
  p18 - idurfn
  p19 - imaxamp
  */

  ; initial settings; control the overall character of the sound
  imaxfreq      = 1000; max.filter cutoff freq. when ienvmod = 0
  imaxsweep     = 10000; sr/2... max.filter freq. at kenvmod & kaccent= 1
  ireson          = 1;scale the resonance as you like (you can make the filter to oscillate...)

  ; init variables; don´t touch this!
  itranspose   = p15; 1 raise the whole seq. 1 octave, etc.
  iseqfn       = p16
  iaccfn       = p17
  idurfn       = p18
  imaxamp      = p19; maximum amplitude. Max 32768 for 16 bit output
  ibpm         = p14; 4/4 bars per minute (or beats?)
  inotedur     = 15/ibpm
  icount       init 0; sequence counter (for notes)
  icount2      init 0; id. for durations
  ipcount2     init 0
  idecaydur    = inotedur
  imindecay    = (idecaydur<.2 ? .2 : idecaydur); set minimum decay to .2 or inotedur
  ipitch table 0,iseqfn; first note in the sequence
  ipitch = cpspch(itranspose + 6 + ipitch/100)
  kaccurve     init 0

  ; twisting the knobs from the score
  kfco       line p4, p3, p5
  kres       line p6, p3, p7
  kenvmod    line p8, p3, p9
  kdecay     line p10, p3, p11
  kaccent    line p12, p3, p13

  start:
  ;pitch & portamento from the sequence
  ippitch = ipitch
  ipitch table ftlen(iseqfn)*frac(icount/ftlen(iseqfn)),iseqfn
  ipitch = cpspch(itranspose + 6 + ipitch/100)

  if ipcount2 != icount2 goto noslide
  kpitch linseg ippitch, .06, ipitch, inotedur-.06, ipitch
  goto next

  noslide:
  kpitch = ipitch

  next:
  ipcount2 = icount2
  timout 0,inotedur,contin
  icount = icount + 1
  reinit start
  rireturn

  contin:
  ; accent detector
  iacc table ftlen(iaccfn)*frac((icount-1)/ftlen(iaccfn)), iaccfn
  if iacc == 0 goto noaccent
  ienvdecay = 0; accented notes are the shortest ones
  iremacc = i(kaccurve)
  kaccurve oscil1i 0, 1, .4, 3
  kaccurve = kaccurve+iremacc;successive accents cause hysterical raising cutoff

  goto sequencer

  noaccent:
  kaccurve = 0; no accent & "discharges" accent curve
  ienvdecay = i(kdecay)

  sequencer:
  aremovedc init 0; set feedback to 0 at every event
  imult table ftlen(idurfn)*frac(icount2/ftlen(idurfn)),idurfn
  if imult != 0 goto noproblemo; compensate for zero padding in the sequencer
  icount2 = icount2 + 1
  goto sequencer

  noproblemo:
  ieventdur = inotedur*imult

  ; two envelopes
  kmeg expseg 1, imindecay+((ieventdur-imindecay)*ienvdecay), ienvdecay+.000001
  kveg linen 1, .01, ieventdur, .016; attack should be 4 ms. but there would be clicks...

  ; amplitude envelope
  kamp = kveg*((1-i(kenvmod)) + kmeg*i(kenvmod)*(.5+.5*iacc*kaccent))

  ; filter envelope
  ksweep = kveg * (imaxfreq + (.75*kmeg+.25*kaccurve*kaccent)*kenvmod*(imaxsweep-imaxfreq))
  kfco = 20 + kfco * ksweep; cutoff always greater than 20 Hz ...
  kfco = (kfco > sr/2 ? sr/2 : kfco); could be necessary

  timout 0, ieventdur, out
  icount2 = icount2 + 1
  reinit contin

  out:
  ; generate bandlimited sawtooth wave
  abuzz buzz kamp, kpitch, sr/(4*kpitch), 1 ,0;bandlimited pulse (up to sr/4)
  asaw integ abuzz,0
  asawdc atone asaw,1

  ; resonant 4-pole LPF
  kfcn = kfco/sr; frequency normalized (0, 1/4)
  kcorr =1-4*kfcn; some empyrical tuning...
  kres = kres/kcorr; more feedback for higher frequencies

  ainpt = asawdc - aremovedc*kres*ireson
  alpf tone ainpt,kfco
  alpf tone alpf,kfco
  alpf tone alpf,kfco
  alpf tone alpf,kfco

  aout balance alpf,asawdc; <- balance causes clicks,
  ; but it is the fastest solution to amplitude problems ;-)

  ;final output ... at last!
  aremovedc atone aout,10

  outleta "TB303Out", imaxamp*aremovedc
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


