instrumentRoute "ChorusedSynth", "Mixer"

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

$MIXER_CHANNEL(ChorusedSynth)
