giMetronomeIsOn = 1
giMetronomeCount = 1
giMetronomeBeatsPerMeasure = 4
giMetronomeAccents[] fillarray 1
giMetronomeToneSample ftgen 0, 0, 0, 1, "instruments/Metronome/Dance-Kit_Clv_EA8116.wav", 0, 0, 0

instr MetronomeTone
  iToneAmplitude = 0dbfs/2


  if giMetronomeIsOn == 1 then
    if arrayContains(giMetronomeAccents, giMetronomeCount) == 1 then
      aTone loscil iToneAmplitude, 1.1, giMetronomeToneSample, 1
      aTone = aTone * 2
    else
      aTone loscil iToneAmplitude, 1, giMetronomeToneSample, 1
    endif
  endif

  out aTone, aTone
endin

instr Metronome
    kTrigger  metro  gkBPM/60

    if giMetronomeIsOn == 1 then
      schedkwhen    kTrigger, 0, 0, "MetronomeTone", 0, gkBPM/60
      schedkwhen    kTrigger, 0, 0, "MetronomeCounter", 0, .1
    endif
endin

instr MetronomeSwitch
  if giMetronomeIsOn == 1 then
    giMetronomeIsOn = 0
    printsBlock "Metronome is Off"
  else
    giMetronomeIsOn = 1
    printsBlock "Metronome is On"
  endif

  giMetronomeCount = 1
endin

instr MetronomeCounter
  giMetronomeCount = giMetronomeCount + 1

  if giMetronomeCount > giMetronomeBeatsPerMeasure then
    giMetronomeCount = 1
  endif
endin
