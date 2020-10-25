opcode bypassSwitch, aaaa, aakkS
  aInL, aInR, kDryAmount, kWetAmount, SEffectIntrument xin

  kActiveEffectsInstruments active SEffectIntrument, 0, 1
  kEffectsInstrumentIsActive = kActiveEffectsInstruments > 0 ? 1 : 0

  aOutWetL = aInL * kWetAmount
  aOutWetR = aInR * kWetAmount

  if kActiveEffectsInstruments > 0 then
    ; kEnvelope = 1 - (linseg(1, 1, 0) * (1 - kDryAmount))
    aOutDryL = aInL * kDryAmount
    aOutDryR = aInR * kDryAmount
  else
    aOutDryR = aInR
    aOutDryL = aInL
  endif

  xout aOutWetL, aOutWetR, aOutDryL, aOutDryR
endop
