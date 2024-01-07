$DRUM_SAMPLE(OpenHat'Mixer'localSamples/Drums/Mixed-Drums_Open-Hat_EA8445.wav'1)
$DRUM_SAMPLE_N(OpenHatN'Mixer'localSamples/Drums/Mixed-Drums_Open-Hat_EA8445.wav'1)

$DRUM_SAMPLE(Kick'Mixer'localSamples/Drums/Alesis-HR16A_Kick_05.wav'0)
$DRUM_SAMPLE_N(KickN'Mixer'localSamples/Drums/Alesis-HR16A_Kick_05.wav'0)

$DRUM_SAMPLE(Punish'Mixer'localSamples/punishmentAwaits.wav'0)
$DRUM_SAMPLE_N(PunishN'Mixer'localSamples/punishmentAwaits.wav'0)

$BREAK_SAMPLE(Amen'Mixer'localSamples/amenBreak.wav'16)
$BREAK_SAMPLE_N(AmenN'Mixer'localSamples/amenBreak.wav'16)

$SAMPLE_SCRUBBER(Scrub'Mixer'localSamples/amenBreak.wav'16)
$SAMPLER(ScrubN'Mixer'localSamples/amenBreak.wav'16'4)

$SAMPLER(Vamp'Mixer'localSamples/worldIsAVampire.wav'4.25'1)


instr OneShotSoundsTheSameForwards
  ; This one actually does sound slightly different because the old one had
  ; an envelope with zero attack. I've opted for the smoothed attack because
  ; I think the other way got us clicks.
  _ "Kick", 0, .001, 127, 1
  _ "KickN", 4, 10, 127, 1
  ; _ "KickN", 6, .001, 127, 1

  _ "Punish", 6, 1, 100, 1
  _ "PunishN", 10, 1, 100, 1
endin

instr OneShotSoundsTheSameBackwards
  _ "Kick", 0, .001, 100, -1
  _ "KickN", 4, .001, 100, -1

  _ "Punish", 6, 1, 100, -1
  _ "PunishN", 10, 1, 100, -1
endin

instr OneShotCanSkipAhead
  _ "PunishN", 0, 1, 100, 1, 1
  _ "PunishN", 4, 1, 100, -1, 1
endin

instr OneShotsCanPlaySimultaneously
  _ "PunishN", 0, 1, 100, 1, 0
  _ "PunishN", 1, 1, 60, 1, 0
endin

instr OneShotPitchSoundsTheSame
  _ "Kick", 0, .001, 100, 1.3
  _ "KickN", 4, .001, 100, 1.3
  _ "Kick", 8, .001, 100, .8
  _ "KickN", 12, .001, 100, .8
endin

instr OneShotTuningWorks
  gaPunishNTuning = .5
  _ "PunishN", 0, 1, 100, 1, 0
endin

instr OneShotCanChangeDirectionMidNote
  ; Move forward, pause, move backwards, turn around
  gaVampTuning = linseg:a(1, 2, 1, 0, 0, 2, 0, 0, -1, 4, 1)
  _ "Vamp", 0, 1, 100, 1, 0
endin

instr OneShotP3Stops
  _ "OpenHatN", 0, .25, 100, 1
endin

instr OneShotP3ADSRWorks
  ; _ "Vamp", 0, 20, 100, 1, 0, 0, .5
  _ "OpenHatN", 0, .25, 100, 1, 0, 0, 0, .25
  _ "OpenHatN", .5, .25, 100, 1, 0, 0, 0, 1
  _ "Vamp", 1, 2, 100, 1, 0, 2, 1, 1
endin

instr OneShotP3PlaysOnce
  _ "OpenHatN", 0, 20, 100, 1
endin

instr BreakLoops
  _ "AmenN", 0, 32, 100, 1
endin

instr BreakPitchWorks
  _ "AmenN", 0, 16, 100, 2
endin

instr BreakPlaysBackwards
  _ "AmenN", 0, 16, 100, -1
endin

instr BreakScalesToTempo
  _ "AmenN", 0, 1, 100, 1, 0
  _ "AmenN", 1, 1, 100, 1, 1
  _ "AmenN", 2, 1, 100, 1, 2
  _ "AmenN", 3, 1, 100, 1, 3
endin

instr BreakADSRWorks
  _ "AmenN", 0, 8, 100, 1, 0, 0, 1, 1
endin

instr BreakSoundsTheSame
  _ "AmenN", 0, 4, 100, 1
  _ "Amen", 4, 4, 100, 1
endin

instr BreakSkipsAhead
  _ "AmenN", 0, 8, 100, 1, 4
  _ "AmenN", 8, 4, 100, 2, 4
endin

instr ScrubSoundsTheSame
  gaScrubPointer = linseg:a(0, bts(2), 1, bts(2), 0)
  gaScrubNPointer = linseg:a(0, bts(4), 0, bts(2), 1, bts(2), 0)

  _ "Scrub", 0, 4, 100, 1, 0
  _ "ScrubN", 4, 4, 100, 1, 0
endin

instr ScrubSkipsAhead
  gaScrubPointer = linseg:a(0, bts(2), 1, bts(2), 0)
  gaScrubNPointer = linseg:a(0, bts(4), 0, bts(2), 1, bts(2), 0)

  _ "Scrub", 0, 4, 100, 1, 4
  _ "ScrubN", 4, 4, 100, 1, 4
endin

instr ScrubWorksInSeconds
  gaPunishNPointer = linseg:a(0, .25, .25, .5, .1, 1, 1, 2, 0)
  _ "PunishN", 0, 4, 100, 1, 0, 4
endin

instr ScrubWorksNormalized
  giPunishNNormalizePointer = 1
  gaPunishNPointer = linseg:a(0, .25, .25, .5, .1, 1, 1)
  _ "PunishN", 0, 4, 100, 1, 0, 4
endin

instr ScrubPitchWorks
  gaScrubPointer = linseg:a(0, bts(2), 1, bts(2), 0)
  gaScrubNPointer = linseg:a(0, bts(4), 0, bts(2), 1, bts(2), 0)

  _ "Scrub", 0, 4, 100, 2, 0
  _ "ScrubN", 4, 4, 100, 2, 0
endin

instr ScrubADSRWorks
  gaScrubNPointer = linseg:a(0, bts(2), 1, bts(2), 0)
  _ "ScrubN", 0, 3, 100, 2, 0, 0, 1, .5
endin
