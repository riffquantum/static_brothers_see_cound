opcode bypassSwitch, aaaa, aakkS
  aInL, aInR, kDryAmount, kWetAmount, SEffectIntrument xin

  kActiveEffectsInstruments active SEffectIntrument, 0, 1
  kEffectsInstrumentIsActive = kActiveEffectsInstruments > 0 ? 1 : 0

  aOutWetL = aInL * kWetAmount
  aOutWetR = aInR * kWetAmount

  if kActiveEffectsInstruments > 0 then
    aOutDryL = aInL * kDryAmount
    aOutDryR = aInR * kDryAmount
  else
    aOutDryR = aInR
    aOutDryL = aInL
  endif

  ; TODO: Try and figure out a way to crossfade the wet and dry signals
  ; kActiveDryAmount init 0
  ; kActiveWetAmount init 0
  ; iCrossFadeTime init .01

  ; if kActiveEffectsInstruments > 0 then
  ;   kActiveDryAmount = 1
  ;   kActiveWetAmount = 1
  ; else
  ;   kActiveDryAmount = 0
  ;   kActiveWetAmount = 0
  ; endif

  ; kFinalDry = ntrpol(1, kDryAmount, port(kActiveDryAmount, iCrossFadeTime))
  ; kFinalWet = ntrpol(1, kWetAmount, 1 - port(kActiveWetAmount, iCrossFadeTime))

  ; if nstrnum(SEffectIntrument) == 158 then
  ;   printk2(kFinalWet)
  ; endif

  ; aOutWetL = aInL * kFinalWet
  ; aOutWetR = aInR * kFinalWet

  ; aOutDryL = aInL * kFinalDry
  ; aOutDryR = aInR * kFinalDry

  xout aOutWetL, aOutWetR, aOutDryL, aOutDryR
endop
