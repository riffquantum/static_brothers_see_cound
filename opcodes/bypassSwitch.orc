opcode bypassSwitch, aaaa, aakkS
  aInL, aInR, kDryAmmount, kWetAmmount, SEffectIntrument xin

  kActiveEffectsInstruments active SEffectIntrument, 0, 1
  kEffectsInstrumentIsActive = kActiveEffectsInstruments > 0 ? 1 : 0

  aOutWetL = aInL * kWetAmmount
  aOutWetR = aInR * kWetAmmount

  if kActiveEffectsInstruments > 0 then
    ; kEnvelope = 1 - (linseg(1, 1, 0) * (1 - kDryAmmount))
    aOutDryL = aInL * kDryAmmount
    aOutDryR = aInR * kDryAmmount
  else
    aOutDryR = aInR
    aOutDryL = aInL
  endif

  xout aOutWetL, aOutWetR, aOutDryL, aOutDryR
endop
