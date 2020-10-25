instrumentRoute "SineWaveForKick", "DrumKitBus"
alwayson "SineWaveForKick"
alwayson "SineWaveForKickMixerChannel"

gkSineWaveForKickEqBass init 1
gkSineWaveForKickEqMid init 1
gkSineWaveForKickEqHigh init 1
gkSineWaveForKickFader init 0.5
gkSineWaveForKickPan init 50

gkSineWaveForKickThreshold init 0.35
giSineWaveForKickInitialFrequency init 66
gkSineWaveForKickFrequency init giSineWaveForKickInitialFrequency
giSineWaveForKickTrackingMode init 2

instr SineWaveForKick
  aKickSignalL inleta "InL"
  aKickSignalR inleta "InR"

  kKickRmsL = rms(aKickSignalL)
  kKickRmsR = rms(aKickSignalR)

  ; This isn't exactly a threshold since it reduces rms value across the board,
  ; but it does create a smooth activation in a simple way.
  if giSineWaveForKickTrackingMode == 0 then
    aSineAmplitudeL = interp(limit(kKickRmsL - gkSineWaveForKickThreshold, 0, 0dbfs))
    aSineAmplitudeR = interp(limit(kKickRmsR - gkSineWaveForKickThreshold, 0, 0dbfs))
  elseif giSineWaveForKickTrackingMode == 1 then
    ; This is more of a true gate/threshold implementation that smooths
    ; out the transition with the port opcode.
    ; Amplitude of Sine Wave tracks Amplitude of Kick
    aGateL interp port(kKickRmsL > gkSineWaveForKickThreshold ? 1 : 0, .0075)
    aGateR interp port(kKickRmsR > gkSineWaveForKickThreshold ? 1 : 0, .0075)

    aSineAmplitudeL = kKickRmsL * aGateL
    aSineAmplitudeR = kKickRmsR * aGateR
  elseif giSineWaveForKickTrackingMode == 2 then
    ; Amplitude of Sine Wave is Constant and gated
    aGateL interp port(kKickRmsL > gkSineWaveForKickThreshold ? 1 : 0, .0075)
    aGateR interp port(kKickRmsR > gkSineWaveForKickThreshold ? 1 : 0, .0075)

    aSineAmplitudeL = velocityToAmplitude(100) * aGateL
    aSineAmplitudeR = velocityToAmplitude(100) * aGateR
  endif



  aKickSineL poscil aSineAmplitudeL, gkSineWaveForKickFrequency
  aKickSineR poscil aSineAmplitudeR, gkSineWaveForKickFrequency

  outleta "OutL", aKickSineL
  outleta "OutR", aKickSineR
endin

instr SineWaveForKickBassKnob
  gkSineWaveForKickEqBass linseg p4, p3, p5
endin

instr SineWaveForKickMidKnob
  gkSineWaveForKickEqMid linseg p4, p3, p5
endin

instr SineWaveForKickHighKnob
  gkSineWaveForKickEqHigh linseg p4, p3, p5
endin

instr SineWaveForKickFader
  gkSineWaveForKickFader linseg p4, p3, p5
endin

instr SineWaveForKickPan
  gkSineWaveForKickPan linseg p4, p3, p5
endin

instr SineWaveForKickMixerChannel
  aSineWaveForKickL inleta "InL"
  aSineWaveForKickR inleta "InR"

  aSineWaveForKickL, aSineWaveForKickR mixerChannel aSineWaveForKickL, aSineWaveForKickR, gkSineWaveForKickFader, gkSineWaveForKickPan, gkSineWaveForKickEqBass, gkSineWaveForKickEqMid, gkSineWaveForKickEqHigh

  outleta "OutL", aSineWaveForKickL
  outleta "OutR", aSineWaveForKickR
endin
