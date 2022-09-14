/* Utility Macros */
#include "macros/utilities/BUS.orc"
#include "macros/utilities/EFFECT_BYPASS.orc"
#include "macros/utilities/MIXER_CHANNEL.orc"
#include "macros/utilities/NEW_EFFECT.orc"
#include "macros/utilities/NEW_INSTRUMENT.orc"
#include "macros/utilities/PATTERN_LOOP.orc"
#include "macros/utilities/TABLE.orc"

/* Instrument Macros */
#include "macros/ARPEGGIATOR.orc"
#include "macros/BASS_SYNTH.orc"
#include "macros/BREAK_SAMPLE.orc"
#include "macros/CASSETTE.orc"
#include "macros/COMPRESSOR.orc"
#include "macros/CHORUS.orc"
#include "macros/CLIP.orc"
#include "macros/DARKSIDE_50_REVERB.orc"
#include "macros/DELAY.orc"
#include "macros/DELAY_WITH_PATCH.orc"
#include "macros/DISTORTED_808_KICK.orc"
#include "macros/DISTORTION.orc"
#include "macros/DRUM_SAMPLE.orc"
#include "macros/DRUM_SAMPLE_2.orc"
#include "macros/DRUM_SAMPLE_P.orc"
#include "macros/EFFECT_CHAIN.orc"
#include "macros/FREEZER.orc"
#include "macros/FT_CONV_REVERB.orc"
#include "macros/IN_TIME_SYNCLOOP_SAMPLER.orc"
#include "macros/IN_TIME_SNDWARP_SAMPLER.orc"
#include "macros/K35_LPF.orc"
#include "macros/LIVE_SYNCLOOP.orc"
#include "macros/LOW_PASS_FILTER.orc"
#include "macros/MULTI_MODE_REVERB.orc"
#include "macros/MULTI_STAGE_DISTORTION.orc"
#include "macros/OCARINA.orc"
#include "macros/PITCH_SHIFTER.orc"
#include "macros/RING_MOD.orc"
#include "macros/SAMPLE_SCRUBBER.orc"
#include "macros/SPECTRAL_DELAY.orc"
#include "macros/STEREO_SHIFTER.orc"
#include "macros/STRING_PAD.orc"
#include "macros/SYNCLOOP_SAMPLER.orc"
#include "macros/TAPE_WOBBLE.orc"
#include "macros/TO_MONO.orc"
#include "macros/TREMOLO.orc"
#include "macros/TWISTED_KICK.orc"
#include "macros/TWISTED_UP_HAT.orc"
#include "macros/VOCODER.orc"
#include "macros/WARM_DISTORTION.orc"

/* Compound Instrument Macros */
#include "macros/DELAY_TO_GRAIN.orc"
#include "macros/GRAIN_TO_DELAY.orc"
#include "macros/RECURSIVE_GRAIN_DELAY.orc"

/* Instruments */
#include "BassPluck.orc"
#include "LayeredBassSynth.orc"
#include "BigCrunchySynth.orc"
#include "BigRichSynth.orc"

$BREAK_SAMPLE(AmenBreak'Mixer'localSamples/amenBreak.wav'16)
$BREAK_SAMPLE(FunkyDrummerBreak'Mixer'localSamples/funkyDrummerBreak.wav'32)
$BREAK_SAMPLE(GettinHappyBreak'Mixer'localSamples/gettinHappyBreak0.wav'16)
$BREAK_SAMPLE(ItsExpectedBreak'Mixer'localSamples/handInTheHandBreak0.wav'16)
$BREAK_SAMPLE(ItsOnlyLoveBreak'Mixer'localSamples/itsOnlyLoveBreak.wav'8)
$BREAK_SAMPLE(JbShoutBreak'Mixer'localSamples/jbSHoutBreakClean.wav'16)
$BREAK_SAMPLE(JohnnyTheFoxBreak'Mixer'localSamples/johnnyTheFoxBreak.wav'16)
$BREAK_SAMPLE(KissingMyLoveBreak'Mixer'localSamples/kissingMyLoveBreak0.wav'8)
$BREAK_SAMPLE(KissingMyLoveSpankyBreak'Mixer'localSamples/kissingMyLoveSpankyBreak.wav'16)
$BREAK_SAMPLE(LoserInTheEndBreak'Mixer'localSamples/loserInTheEndBreak.wav'16)
$BREAK_SAMPLE(NothingIDontLikeBreak'Mixer'localSamples/nothingIDontLikeBreak.wav'16)
$BREAK_SAMPLE(RafflesiaBreak'Mixer'localSamples/rafflesiaBreak.wav'4)
$BREAK_SAMPLE(ThinkBreak'Mixer'localSamples/thinkBreak0.wav'4)
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
#include "Section.orc"
#include "SimpleOscillator.orc"
#include "SyncloopSamplerTemplate.orc"
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
