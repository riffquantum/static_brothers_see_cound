gkXSessionKnobC1Value ctrl7 1, giXSessionKnobC1ControlNumber, 0, 127
gkXSessionKnobC1Trigger changed gkXSessionKnobC1Value

if gkXSessionKnobC1Trigger == 1 then
  gkBPMAdjustment = (gkXSessionKnobC1Value+1)/128 * 500
  gkBPM = gkBPMAdjustment

  SBPMReadout = sprintfk({{ Current BPM: %d}}, gkBPM)
  printks "%n********************%n Current BPM %n", 1/kr
  printk2 gkBPM
  printks "%n********************%n", 1/kr
endif

