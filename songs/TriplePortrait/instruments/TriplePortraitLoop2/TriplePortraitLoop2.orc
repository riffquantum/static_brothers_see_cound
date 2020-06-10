instrumentRoute "TriplePortraitLoop2", "Mixer"
alwayson "TriplePortraitLoop2MixerChannel"

gkTriplePortraitLoop2EqBass init 1
gkTriplePortraitLoop2EqMid init 1
gkTriplePortraitLoop2EqHigh init 1
gkTriplePortraitLoop2Fader init 1
gkTriplePortraitLoop2Pan init 50

/* MIDI Config Values */
; massign giTriplePortraitLoop2MidiChannel, "TriplePortraitLoop2"

gSTriplePortraitLoop2SamplePath = "songs/TriplePortrait/instruments/TriplePortraitLoop2/TriplePortraitLoop2.wav"
giTriplePortraitLoop2SampleChannels filenchnls gSTriplePortraitLoop2SamplePath
giTriplePortraitLoop2SampleLength filelen gSTriplePortraitLoop2SamplePath
giTriplePortraitLoop2SampleLengthInBeats = 2
giTriplePortraitLoop2LengthOfBeat = giTriplePortraitLoop2SampleLength / giTriplePortraitLoop2SampleLengthInBeats
giTriplePortraitLoop2LengthBPM init 60 /giTriplePortraitLoop2LengthOfBeat
giTriplePortraitLoop2LengthOfBeatFactor = i(gkBPM) / giTriplePortraitLoop2LengthBPM

if giTriplePortraitLoop2SampleChannels = 2 then
  giTriplePortraitLoop2SampleL ftgen 0, 0, 0, 1, gSTriplePortraitLoop2SamplePath, 0, 0, 1
  giTriplePortraitLoop2SampleR ftgen 0, 0, 0, 1, gSTriplePortraitLoop2SamplePath, 0, 0, 2
else
  giTriplePortraitLoop2Sample ftgen 0, 0, 0, 1, gSTriplePortraitLoop2SamplePath, 0, 0, 0
endif

instr TriplePortraitLoop2
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giTriplePortraitLoop2SampleLength * p5 * giTriplePortraitLoop2LengthOfBeatFactor

  kPitch += oscil(.005, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giTriplePortraitLoop2SampleLengthInBeats : p7
  kAmplitudeEnvelope madsr .005, .01, iAmplitude, .1
  iStartTime = (iStartBeat / giTriplePortraitLoop2SampleLengthInBeats) + 0.17

  if giTriplePortraitLoop2SampleChannels = 2 then
    aTriplePortraitLoop2R poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop2SampleR, iStartTime
    aTriplePortraitLoop2L poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop2SampleL, iStartTime
  else
    aTriplePortraitLoop2L poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop2Sample, iStartTime
    aTriplePortraitLoop2R = aTriplePortraitLoop2L
  endif

  outleta "OutL", aTriplePortraitLoop2L
  outleta "OutR", aTriplePortraitLoop2R
endin

instr TriplePortraitLoop2BassKnob
  gkTriplePortraitLoop2EqBass linseg p4, p3, p5
endin

instr TriplePortraitLoop2MidKnob
  gkTriplePortraitLoop2EqMid linseg p4, p3, p5
endin

instr TriplePortraitLoop2HighKnob
  gkTriplePortraitLoop2EqHigh linseg p4, p3, p5
endin

instr TriplePortraitLoop2Fader
  gkTriplePortraitLoop2Fader linseg p4, p3, p5
endin

instr TriplePortraitLoop2Pan
  gkTriplePortraitLoop2Pan linseg p4, p3, p5
endin

instr TriplePortraitLoop2MixerChannel
  aTriplePortraitLoop2L inleta "InL"
  aTriplePortraitLoop2R inleta "InR"

  kTriplePortraitLoop2Fader = gkTriplePortraitLoop2Fader
  kTriplePortraitLoop2Pan = gkTriplePortraitLoop2Pan
  kTriplePortraitLoop2EqBass = gkTriplePortraitLoop2EqBass
  kTriplePortraitLoop2EqMid = gkTriplePortraitLoop2EqMid
  kTriplePortraitLoop2EqHigh = gkTriplePortraitLoop2EqHigh

  aTriplePortraitLoop2L, aTriplePortraitLoop2R threeBandEqStereo aTriplePortraitLoop2L, aTriplePortraitLoop2R, kTriplePortraitLoop2EqBass, kTriplePortraitLoop2EqMid, kTriplePortraitLoop2EqHigh

  if kTriplePortraitLoop2Pan > 100 then
      kTriplePortraitLoop2Pan = 100
  elseif kTriplePortraitLoop2Pan < 0 then
      kTriplePortraitLoop2Pan = 0
  endif

  aTriplePortraitLoop2L = (aTriplePortraitLoop2L * ((100 - kTriplePortraitLoop2Pan) * 2 / 100)) * kTriplePortraitLoop2Fader
  aTriplePortraitLoop2R = (aTriplePortraitLoop2R * (kTriplePortraitLoop2Pan * 2 / 100)) * kTriplePortraitLoop2Fader

  outleta "OutL", aTriplePortraitLoop2L
  outleta "OutR", aTriplePortraitLoop2R
endin

