/* Utility Macros */
#include "macros/utilities/BUS.orc"
#include "macros/utilities/EFFECT_BYPASS.orc"
#include "macros/utilities/MIXER_CHANNEL.orc"
#include "macros/utilities/NEW_EFFECT.orc"
#include "macros/utilities/NEW_INSTRUMENT.orc"
#include "macros/utilities/PATTERN_LOOP.orc"

/* Instrument Macros */
#include "macros/ARPEGGIATOR.orc"
#include "macros/BASS_SYNTH.orc"
#include "macros/BREAK_SAMPLE.orc"
#include "macros/COMPRESSOR.orc"
#include "macros/CHORUS.orc"
#include "macros/CLIP.orc"
#include "macros/DARKSIDE_50_REVERB.orc"
#include "macros/DELAY.orc"
#include "macros/DISTORTED_808_KICK.orc"
#include "macros/DISTORTION.orc"
#include "macros/DRUM_SAMPLE.orc"
#include "macros/EFFECT_CHAIN.orc"
#include "macros/FREEZER.orc"
#include "macros/FT_CONV_REVERB.orc"
#include "macros/IN_TIME_SYNCLOOP_SAMPLER.orc"
#include "macros/IN_TIME_SNDWARP_SAMPLER.orc"
#include "macros/K35_LPF.orc"
#include "macros/LOW_PASS_FILTER.orc"
#include "macros/MULTI_MODE_REVERB.orc"
#include "macros/MULTI_STAGE_DISTORTION.orc"
#include "macros/OCARINA.orc"
#include "macros/PITCH_SHIFTER.orc"
#include "macros/RING_MOD.orc"
#include "macros/STRING_PAD.orc"
#include "macros/SYNCLOOP_SAMPLER.orc"
#include "macros/TAPE_WOBBLE.orc"
#include "macros/TO_MONO.orc"
#include "macros/TREMOLO.orc"
#include "macros/TWISTED_KICK.orc"
#include "macros/TWISTED_UP_HAT.orc"
#include "macros/VOCODER.orc"
#include "macros/WARM_DISTORTION.orc"

/* Instruments */
#include "BassPluck.orc"
#include "LayeredBassSynth.orc"
#include "BigCrunchySynth.orc"
#include "BigRichSynth.orc"

$BREAK_SAMPLE(AmenBreak'Mixer'instruments/breakBeatInstruments/amenBreak.wav'16)
$BREAK_SAMPLE(FunkyDrummerBreak'Mixer'instruments/breakBeatInstruments/funkyDrummerBreak.wav'32)
$BREAK_SAMPLE(GettinHappyBreak'Mixer'instruments/breakBeatInstruments/gettinHappyBreak0.wav'16)
$BREAK_SAMPLE(ItsExpectedBreak'Mixer'instruments/breakBeatInstruments/handInTheHandBreak0.wav'16)
$BREAK_SAMPLE(ItsExpectedBreak'Mixer'instruments/breakBeatInstruments/itsExpectedBreak.wav'16)
$BREAK_SAMPLE(ItsOnlyLoveBreak'Mixer'instruments/breakBeatInstruments/itsOnlyLoveBreak.wav'8)
$BREAK_SAMPLE(JbShoutBreak'Mixer'instruments/breakBeatInstruments/jbSHoutBreakClean.wav'16)
$BREAK_SAMPLE(JohnnyTheFoxBreak'Mixer'instruments/breakBeatInstruments/johnnyTheFoxBreak.wav'16)
$BREAK_SAMPLE(KissingMyLoveBreak'Mixer'instruments/breakBeatInstruments/kissingMyLoveBreak0.wav'8)
$BREAK_SAMPLE(KissingMyLoveSpankyBreak'Mixer'instruments/breakBeatInstruments/kissingMyLoveSpankyBreak.wav'16)
$BREAK_SAMPLE(LoserInTheEndBreak'Mixer'instruments/breakBeatInstruments/loserInTheEndBreak.wav'16)
$BREAK_SAMPLE(NothingIDontLikeBreak'Mixer'instruments/breakBeatInstruments/nothingIDontLikeBreak.wav'16)
$BREAK_SAMPLE(RafflesiaBreak'Mixer'instruments/breakBeatInstruments/rafflesiaBreak.wav'4)
$BREAK_SAMPLE(ThinkBreak'Mixer'instruments/breakBeatInstruments/thinkBreak0.wav'4)
#include "chorusedSynth.orc"
$EFFECT_CHAIN(DefaultEffectChain'Mixer)
#include "DelayHiHat.orc"
#include "DisonantSynth.orc"
$DISTORTED_808_KICK(Distorted808Kick'Mixer'localSamples/Drums/TR-808_Kick_41.wav)
#include "FlowingTrumpetingOvertones.orc"
#include "K35LowPassFilter.orc"
#include "linnDrum/linnDrum.orc"
#include "Metronome/Metronome.orc"
#include "Mixer.orc"
#include "MidiRouter.orc"
#include "MidiControlInputs/MidiControlInputs.orc"
#include "NewEffect.orc"
#include "NewInstrument.orc"
#include "PatternWriter.orc"
#include "SimpleOscillator.orc"
#include "SyncloopSamplerTemplate.orc"
#include "SyncLoopSamplerTemplate2.orc"
#include "TR808/TR808.orc"
#include "TR606/TR606.orc"
#include "TwistedUpKickExample.orc"
#include "TwistedUpHatExample.orc"
#include "YiBanjo.orc"
#include "YiHarp.orc"
#include "YiSynth1.orc"
#include "YiSynth2.orc"
#include "YiSynth3.orc"
#include "Arpeggiator.orc"
