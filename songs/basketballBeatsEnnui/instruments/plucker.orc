; plucker

connect "plucker", "pluckerOut", "pluckerMixerChannel", "pluckerIn"

connect "pluckerMixerChannel", "pluckerOutL", "Mixer", "MixerInL"
connect "pluckerMixerChannel", "pluckerOutR", "Mixer", "MixerInR"

alwayson "pluckerMixerChannel"

gkpluckerEqBass init 1
gkpluckerEqMid init 1
gkpluckerEqHigh init 1
gkpluckerFader init 1
gkpluckerPan init 50

instr plucker
    kAmp = p4
    kPitch = (p5 < 15 ? cpspch(p5) : p5)
    iPitch = (p5 < 15 ? cpspch(p5) : p5)
    ifn init 0
    idecayMethod init 6
    iformat init 0
    iskipinit init 0
    iParam1 = .09
    iParam2 = .09

    iPluckPoint = .5
    kReflectionCoefficient = .95

    /*
      idecayMethod -- method of natural decay. There are six, some of which use parameters values that follow.

      simple averaging. A simple smoothing process, uninfluenced by parameter values.

      stretched averaging. As above, with smoothing time stretched by a factor of iparm1 (>=1).

      simple drum. The range from pitch to noise is controlled by a 'roughness factor' in iparm1 (0 to 1). Zero gives the plucked string effect, while 1 reverses the polarity of every sample (octave down, odd harmonics). The setting .5 gives an optimum plucker drum.

      stretched drum. Combines both roughness and stretch factors. iparm1 is roughness (0 to 1), and iparm2 the stretch factor (>=1).

      weighted averaging. As method 1, with iparm1 weighting the current sample (the status quo) and iparm2 weighting the previous adjacent one. iparm1 + iparm2 must be <= 1.

      1st order recursive filter, with coefs .5. Unaffected by parameter values.
    */

    aplucker pluck kAmp, kPitch, iPitch, ifn, idecayMethod, iParam1, iParam2

    ;aplucker wgpluck2 iPluckPoint, kAmp, kPitch, kReflectionCoefficient

    outleta "pluckerOut", aplucker
endin

instr pluckerBassKnob
    gkpluckerEqBass linseg p4, p3, p5
endin

instr pluckerMidKnob
    gkpluckerEqMid linseg p4, p3, p5
endin

instr pluckerHighKnob
    gkpluckerEqHigh linseg p4, p3, p5
endin

instr pluckerFader
    gkpluckerFader linseg p4, p3, p5
endin

instr pluckerPan
    gkpluckerPan linseg p4, p3, p5
endin

instr pluckerMixerChannel
    apluckerL inleta "pluckerIn"
    apluckerR inleta "pluckerIn"

    kpanvalue linseg 0, 1, 100

    kpluckerFader = gkpluckerFader
    kpluckerPan = gkpluckerPan
    kpluckerEqBass = gkpluckerEqBass
    kpluckerEqMid = gkpluckerEqMid
    kpluckerEqHigh = gkpluckerEqHigh

    apluckerD1L = delayBuffer(pitchShifter( apluckerR, 1.5, 1, 1), .5, .025, 1)
    apluckerD1R = delayBuffer(pitchShifter( apluckerR, 1.8, 1, 1), .5, .03, 1)

    apluckerD2L = delayBuffer(pitchShifter( apluckerR, 1.25, 1, 1), .5, .035, 1)
    apluckerD2R = delayBuffer(pitchShifter( apluckerR, 2.25, 1, 1), .5, .04, 1)

    apluckerL = apluckerL + apluckerD1L
    apluckerR = apluckerR + apluckerD1R

    apluckerL = apluckerL + apluckerD2L
    apluckerR = apluckerR + apluckerD2R

    ;apluckerL limit apluckerL, 0, 1
    ;apluckerR limit apluckerR, 0, 1

    apluckerL, apluckerR threeBandEqStereo apluckerL, apluckerR, kpluckerEqBass, kpluckerEqMid, kpluckerEqHigh

    if kpluckerPan > 100 then
        kpluckerPan = 100
    elseif kpluckerPan < 0 then
        kpluckerPan = 0
    endif

    apluckerL = (apluckerL * ((100 - kpluckerPan) * 2 / 100)) * kpluckerFader
    apluckerR = (apluckerR * (kpluckerPan * 2 / 100)) * kpluckerFader

    outleta "pluckerOutL", apluckerL
    outleta "pluckerOutR", apluckerR

endin
