instrumentRoute "ChorusedSynth", "Mixer"

alwayson "ChorusedSynthMixerChannel"

gkChorusedSynthEqBass init 1
gkChorusedSynthEqMid init 1
gkChorusedSynthEqHigh init 1
gkChorusedSynthFader init 1
gkChorusedSynthPan init 50

instr ChorusedSynth
  ;CONTROL SIGNALS
  ;output action  args

  kamp    linseg    p4, (p3 - (p3 * 0.1)), p4, (p3 * 0.1), 0 ; amplitude envelope
  ifreq    =        (p5 < 15 ? cpspch(p5) : p5)
  kfreq   linseg    ifreq*1.2, (p3*0.2), ifreq

  iTable ftgenonce 100, 0, 16384, 20, 1

  aChorusedSynthMidiIn oscil   kamp,    ifreq,          100 ; main oscillator

  aChorusedSynthMidiIn += oscil(   kamp,   (ifreq * 0.99),  100)

  aChorusedSynthMidiIn += oscil(   kamp,   (ifreq * 1.01),  100)

  outleta "OutL", aChorusedSynthMidiIn
  outleta "OutR", aChorusedSynthMidiIn
endin

instr ChorusedSynthBassKnob
  gkChorusedSynthEqBass linseg p4, p3, p5
endin

instr ChorusedSynthMidKnob
  gkChorusedSynthEqMid linseg p4, p3, p5
endin

instr ChorusedSynthHighKnob
  gkChorusedSynthEqHigh linseg p4, p3, p5
endin

instr ChorusedSynthFader
  gkChorusedSynthFader linseg p4, p3, p5
endin

instr ChorusedSynthPan
  gkChorusedSynthPan linseg p4, p3, p5
endin

instr ChorusedSynthMixerChannel
  aChorusedSynthL inleta "InL"
  aChorusedSynthR inleta "InR"

  aChorusedSynthL, aChorusedSynthR mixerChannel aChorusedSynthL, aChorusedSynthR, gkChorusedSynthFader, gkChorusedSynthPan, gkChorusedSynthEqBass, gkChorusedSynthEqMid, gkChorusedSynthEqHigh

  outleta "OutL", aChorusedSynthL
  outleta "OutR", aChorusedSynthR
endin

