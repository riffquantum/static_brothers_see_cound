; $SAMPLER_PLUS(Asma'Mixer'localSamples/Asmon Asmoton - Maria Farandouri.wav'0'3'1'+'0'.01)
$SAMPLER_PLUS(Asma1'Mixer'localSamples/Asma1.wav'8'3'1'+'0'.01)
; $SAMPLER_PLUS(Asma1'Mixer'localSamples/Asma1b.wav'8'3'1'+'0'.01)
$SAMPLER_PLUS(Asma2'Mixer'localSamples/Asma2.wav'4'3'1'+'0'.01)
$SAMPLER_PLUS(Asma3'Mixer'localSamples/Asma3.wav'8'3'1'+'0'.01)
$SAMPLER_PLUS(Asma4'Mixer'localSamples/Asma4.wav'24'3'1'+'0'.01)
$SAMPLER_PLUS(Asma5'Mixer'localSamples/Asma5.wav'12'3'1'+'0'.01)
$SAMPLER_PLUS(Asma6'Mixer'localSamples/Asma6.wav'20'3'1'+'0'.01)
$SAMPLER_PLUS(Asma7'Mixer'localSamples/Asma7.wav'36'3'1'+'0'.01)
$SAMPLER_PLUS(Asma8'Mixer'localSamples/Asma8.wav'8'3'1'+'0'.01)
$SAMPLER_PLUS(Asma9'Mixer'localSamples/Asma9.wav'4'3'1'+'0'.01)
$SAMPLER_PLUS(AsmaStab'Mixer'localSamples/AsmaStab.wav'0'3'1'+'0'.01)

#define ASTHMA1G_SETTINGS #
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = 1 + poscil(.7, .3) * linseg(0, beatsToSeconds(.75), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .5 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kGrainSizeAdjustment = 1
  ; kGrainFrequencyAdjustment = linseg(1, stb(.75), 1, stb(2), 2, stb(1), 10)
  ; kPitchAdjustment = 1
  ; kGrainOverlapPercentageAdjustment = 1 ;linseg(1, beatsToSeconds(4), .5)

  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kGrainFrequencyAdjustment = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
#
$SYNCLOOP_SAMPLER2(Asma1G'Mixer'localSamples/Asma1.wav'$ASTHMA1G_SETTINGS'8)


giAsma1AttackTime init .1

$BITCRUSHER(KissBit'Mixer'Mixer)
$SAMPLER_PLUS(Hand'KissBitInput'localSamples/handInTheHandBreak2.wav'8'3'1'+'0'0.005)
$SAMPLER_PLUS(Kiss'KissBitInput'localSamples/kissingMyLoveBreak0.wav'16'3'1'+'0'0.005)
$SAMPLER_PLUS(Kiss2'KissBitInput'localSamples/kissingMyLoveBreak1.wav'8'3'1'+'0'0.005)


; $DRUM_SAMPLE_V2(Kick2'Mixer'localSamples/Drums/Alesis-HR16A_Kick_08.wav'0'0'+'0'0)
; localSamples/Drums/Alesis-HR16A_Kick_08.wav
; localSamples/Drums/House-Drums_Kick_EA8602.wav
$DRUM_SAMPLE_N(KickThump'KickBus'localSamples/Drums/Alesis-HR16A_Kick_08.wav'0)
$DRUM_SAMPLE_N(KickThick'KickBus'localSamples/Drums/House-Drums_Kick_EA8602.wav'0)
gaKickThickTuning init .8
gkKickThickFader init .75
gkKickThumpFader init .25
instr Kick
  _ "KickThump", 0, stb(p3), p4, p5, p6, p7, p8, p9
  _ "KickThick", 0, stb(p3), p4, p5, p6, p7, p8, p9
endin
$BUS(KickBus'Mixer)


$SAMPLER_PLUS(HarpGlis'MarianVerbInput'localSamples/poorLittleRichGirlHarpGlis.wav'0'2'1'+'0'0.5)
$SAMPLER_PLUS(PianoBits'MarianVerbInput'localSamples/poorLittleRichGirlPianoBits.wav'0'2'1'+'0'0.5)

$FT_CONV_REVERB(MarianVerb'Mixer'Mixer'./localSamples/IMreverbs/Narrow Bumpy Space.wav)
