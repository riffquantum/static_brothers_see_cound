giMetronomeIsOn = 1
giMetronomeCount = 1
giMetronomeBeatsPerMeasure = 4
giMetronomeAccents[] fillarray 1

instr MetronomeTone
  ilen init .01
  iamp init 1

  kcutfreq  expon     10000, 0.1, 2500
  aamp      expon     iamp,  0.1,  .1
  arand     rand      aamp
  alp1      butterlp  arand,kcutfreq
  alp2      butterlp  alp1,kcutfreq
  ahp1      butterhp  alp2,3500
  asigpre   butterhp  ahp1,3500
  asig      linen    (asigpre+arand/2),0,ilen, .05

  if arrayContains(giMetronomeAccents, giMetronomeCount) == 1 then
    asig = asig * 3
  endif

  out asig, asig
endin

instr Metronome
    kTrigger  metro  gkBPM/60
    if giMetronomeIsOn == 1 then
      schedkwhen    kTrigger, 0, 0, "MetronomeTone", 0, gkBPM/60
      schedkwhen    kTrigger, 0, 0, "MetronomeCounter", 0, .1
    endif
endin

instr MetronomeSwitch
  giMetronomeIsOn = p4
endin

instr MetronomeCounter
  giMetronomeCount = giMetronomeCount + 1

  if giMetronomeCount > giMetronomeBeatsPerMeasure then
    giMetronomeCount = 1
  endif
endin
