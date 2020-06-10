; Chorused Synth

connect "ChorusedSynthMidiIn", "OutL", "ChorusedSynthMidiInMixerChannel", "InL"
connect "ChorusedSynthMidiIn", "OutR", "ChorusedSynthMidiInMixerChannel", "InR"

connect "ChorusedSynthMidiInMixerChannel", "OutL", "Mixer", "InL"
connect "ChorusedSynthMidiInMixerChannel", "OutR", "Mixer", "InR"

alwayson "ChorusedSynthMidiInMixerChannel"

gkChorusedSynthMidiInFader init 1
gkChorusedSynthMidiInPan init 50

instr ChorusedSynthMidiIn
  ;CONTROL SIGNALS
  ;output action  args


  kamp     =        0.1
  ifreq   cpsmidi
  kfreq   linseg    ifreq*1.2, 0.1, ifreq

  iTable ftgenonce 100, 0, 16384, 20, 1

  ;AUDIO SIGNALS
  ;output action  args
  ;               amp     hz                    f
  aChorusedSynthMidiIn oscil   kamp,    ifreq,          100 ; main oscillator

  aChorusedSynthMidiIn += oscil(   kamp,   (ifreq * 0.99),  100)

  aChorusedSynthMidiIn += oscil(   kamp,   (ifreq * 1.01),  100)

  outleta "OutL", aChorusedSynthMidiIn
  outleta "OutR", aChorusedSynthMidiIn
endin

instr ChorusedSynthMidiInFader
    gkChorusedSynthMidiInFader linseg p4, p3, p5
endin

instr ChorusedSynthMidiInPan
    gkChorusedSynthMidiInPan linseg p4, p3, p5
endin

instr ChorusedSynthMidiInMixerChannel
    aChorusedSynthMidiInL inleta "InL"
    aChorusedSynthMidiInR inleta "InR"

    kChorusedSynthMidiInFader = gkChorusedSynthMidiInFader
    kChorusedSynthMidiInPan = gkChorusedSynthMidiInPan

    if kChorusedSynthMidiInPan > 100 then
        kChorusedSynthMidiInPan = 100
    elseif kChorusedSynthMidiInPan < 0 then
        kChorusedSynthMidiInPan = 0
    endif

    aChorusedSynthMidiInL = (aChorusedSynthMidiInL * ((100 - kChorusedSynthMidiInPan) * 2 / 100)) * kChorusedSynthMidiInFader
    aChorusedSynthMidiInR = (aChorusedSynthMidiInR * (kChorusedSynthMidiInPan * 2 / 100)) * kChorusedSynthMidiInFader

    outleta "OutL", aChorusedSynthMidiInL
    outleta "OutR", aChorusedSynthMidiInR
endin

