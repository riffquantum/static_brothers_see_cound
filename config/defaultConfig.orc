; Default Config Values
sr = 44100

; Control Rate Settings
ksmps = 32
kr = 1378.125
; ksmps = 10
; kr = 4410
; ksmps = 8
; kr = 5512.5

nchnls = 2
0dbfs = 10

; Tempo for composotions should be set at the CsOptions level with the -t flag.
; This variable assignment ensures that the widely used gkBPM value is set.
; TODO: Consider eliminating this variable in favor of miditempo usage throughout
; the repo.
gkBPM miditempo

; See selectTuningSystemAndReturnFrequency for a list of available tuning systems.
; A numeric ID and a number of divisions per octave must be set.
giGlobalTuningSystem init 1
giDivisionsInTuningSystem init 12

; Experimental feature for writing seperate tracks during performance.
; gSStemsToWrite[] init 50
