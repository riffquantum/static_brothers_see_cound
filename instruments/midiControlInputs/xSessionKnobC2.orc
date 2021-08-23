gkXSessionKnobC2Value ctrl7 1, giXSessionKnobC2ControlNumber, 0, 127
gkXSessionKnobC2Trigger changed gkXSessionKnobC2Value

if gkXSessionKnobC2Trigger == 1 then
  gkMetronomeFader = (gkXSessionKnobC2Value)/127 * 1.5

  printks "%n********************%n Metronome Fader %n", 1/kr
  printk2 gkMetronomeFader
  printks "%n********************%n", 1/kr
endif

