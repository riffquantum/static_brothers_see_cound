$DRUM_SAMPLE_2(HMOpenHat1'HMDrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_27.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(HMOpenHat2'HMDrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_28.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(HMClosedHat2'HMDrumBus'localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7516.wav'1'1'+'0'-1)
$BREAK_SAMPLE(HMAmen'HMDrumBus'localSamples/AmenBreak.wav'16)


$DRUM_SAMPLE_2(HMKick'HMDrumBus'localSamples/Drums/Alesis-HR16A_Kick_04.wav'0'0'+'0'0)
$DRUM_SAMPLE_2(HMHighSnare'HMDrumBus'localSamples/Drums/Mixed-Drums_Snare_EA8501.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(HMLoudSnare'HMDrumBus'localSamples/Drums/Dance-Kit_Snare_EA8105.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(HMSnare'HMDrumBus'localSamples/Drums/House-Drums_Snare_EA8708.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(HMBigSnare'HMDrumBus'localSamples/Drums/Alesis-HR16A_Snare_42.wav'1'1'+'0'-1)
$BUS(HMDrumBus'HMDrumDistInput)
$CLIP(HMDrumDist'HMDrumPostBus'HMDrumPostBus)
$BUS(HMDrumPostBus'Mixer)
alwayson "HMDrumDist"

instr HMAggKick
  schedule "Distorted808Kick", 0, p3, p4*.50, .5
  schedule "Distorted808Kick", 0, p3, p4*.40, .75
  schedule "Kick", 0, p3, p4, 1
endin
