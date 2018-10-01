; Chorused Synth

connect "ChorusedSynthQuarterTone", "ChorusedSynthQuarterToneOut", "ChorusedSynthQuarterToneMixerChannel", "ChorusedSynthQuarterToneIn"
connect "ChorusedSynthQuarterToneMixerChannel", "ChorusedSynthQuarterToneOutL", "Mixer", "MixerInL"
connect "ChorusedSynthQuarterToneMixerChannel", "ChorusedSynthQuarterToneOutR", "Mixer", "MixerInR"
alwayson "ChorusedSynthQuarterToneMixerChannel"

gkChorusedSynthQuarterToneFader init 1
gkChorusedSynthQuarterTonePan init 50

instr ChorusedSynthQuarterTone
    ;CONTROL SIGNALS
    ;output action  args

    kamp     =        0.1

    iMidiNote notnum
    
    ifreq = midiNoteQuarterToneKeyboardLayout(iMidiNote, 7)
    
    kfreq   linseg    ifreq*1.2, 0.1, ifreq

    iTable ftgenonce 100, 0, 16384, 20, 1

    aChorusedSynthQuarterTone1      oscil   kamp,    ifreq,          100 ; main oscillator

    aChorusedSynthQuarterTone2      oscil   kamp,   (ifreq * 0.99),  100 ; chorus oscillator

    aChorusedSynthQuarterTone3      oscil   kamp,   (ifreq * 1.01),  100
                         outleta "ChorusedSynthQuarterToneOut", aChorusedSynthQuarterTone1 + aChorusedSynthQuarterTone2 + aChorusedSynthQuarterTone3
endin

instr ChorusedSynthQuarterToneFader
    gkChorusedSynthQuarterToneFader linseg p4, p3, p5
endin

instr ChorusedSynthQuarterTonePan
    gkChorusedSynthQuarterTonePan linseg p4, p3, p5
endin

instr ChorusedSynthQuarterToneMixerChannel
    aChorusedSynthQuarterToneL inleta "ChorusedSynthQuarterToneIn"
    aChorusedSynthQuarterToneR inleta "ChorusedSynthQuarterToneIn"

    kChorusedSynthQuarterToneFader = gkChorusedSynthQuarterToneFader
    kChorusedSynthQuarterTonePan = gkChorusedSynthQuarterTonePan

    if kChorusedSynthQuarterTonePan > 100 then
        kChorusedSynthQuarterTonePan = 100
    elseif kChorusedSynthQuarterTonePan < 0 then
        kChorusedSynthQuarterTonePan = 0
    endif

    aChorusedSynthQuarterToneL = (aChorusedSynthQuarterToneL * ((100 - kChorusedSynthQuarterTonePan) * 2 / 100)) * kChorusedSynthQuarterToneFader
    aChorusedSynthQuarterToneR = (aChorusedSynthQuarterToneR * (kChorusedSynthQuarterTonePan * 2 / 100)) * kChorusedSynthQuarterToneFader

    outleta "ChorusedSynthQuarterToneOutL", aChorusedSynthQuarterToneL
    outleta "ChorusedSynthQuarterToneOutR", aChorusedSynthQuarterToneR
endin

;0 - 127

; 1  2  3  4  5  6  7  8  9  10  11 12
; A  A# B  C  C# D  D# E  F  F#  G  G#



/*



60 = 7.04
61 = 7.045
62 = 7.05
63 = 7.055
64 = 7.06
65 = 7.065
66 = 7.07
67 = 7.075
68 = 7.08
69 = 7.085
70 = 7.09
71 = 7.095
72 = 7.1
73 = 7.105
74 = 7.11
75 = 7.115
76 = 7.12
77 = 7.125
78 = 8

.005 * midinote (24/127)

*/