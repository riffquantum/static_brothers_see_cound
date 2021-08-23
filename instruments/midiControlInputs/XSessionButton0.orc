gkXSessionButton0Value ctrl7 1, giXSessionButton0ControlNumber, 0, 127
gkXSessionButton0Trigger changed gkXSessionButton0Value

if gkXSessionButton0Trigger == 1 then
  if gkXSessionButton0Value == 127 then
    schedkwhen gkXSessionButton0Trigger, -1, 1, "Metronome", 0, -1
  else
    turnoff2 "Metronome", 1, 1
  endif
endif

