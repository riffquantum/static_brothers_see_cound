gkXSessionKnobC3Value ctrl7 1, giXSessionKnobC3ControlNumber, 0, 127
gkXSessionKnobC3Trigger changed gkXSessionKnobC3Value

if gkXSessionKnobC3Trigger == 1 then
  ; gkPreClipMixerFader = (gkXSessionKnobC3Value)/127 * 1.5

  ; printks "%n********************%n Master Pre-clip Fader %n", 1/kr
  ; printk2 gkPreClipMixerFader
  ; printks "%n********************%n", 1/kr
endif
