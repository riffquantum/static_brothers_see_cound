alwayson "K35LowPassFilterInput"
alwayson "K35LowPassFilterMixerChannel"

bypassRoute "K35LowPassFilter", "JeanetteChorusInput", "JeanetteChorusInput"

gkK35LowPassFilterEqBass init 1
gkK35LowPassFilterEqMid init 1
gkK35LowPassFilterEqHigh init 1
gkK35LowPassFilterFader init 1
gkK35LowPassFilterPan init 50

gkK35LowPassFilterDryAmount init 0
gkK35LowPassFilterWetAmount init 1
gkK35LowPassFilterCutoffFrequency init 10000
gkK35LowPassFilterQ init 4

instr K35LowPassFilterInput
  aK35LowPassFilterInL inleta "InL"
  aK35LowPassFilterInR inleta "InR"

  aK35LowPassFilterOutWetL, aK35LowPassFilterOutWetR, aK35LowPassFilterOutDryL, aK35LowPassFilterOutDryR bypassSwitch aK35LowPassFilterInL, aK35LowPassFilterInR, gkK35LowPassFilterDryAmount, gkK35LowPassFilterWetAmount, "K35LowPassFilter"

  outleta "OutWetL", aK35LowPassFilterOutWetL
  outleta "OutWetR", aK35LowPassFilterOutWetR

  outleta "OutDryL", aK35LowPassFilterOutDryL
  outleta "OutDryR", aK35LowPassFilterOutDryR
endin

instr K35LowPassFilter
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"
  kCutoffFrequency = gkK35LowPassFilterCutoffFrequency * (p4 == 0 ? 1 : p4)
  kQ = gkK35LowPassFilterQ * (p5 == 0 ? 1 : p5)
  iNonLinearProcessingMethod = 1 ; Non-linear processing method. 0 = no processing, 1 = non-linear processing. Method 1 uses tanh(ksaturation * input). Enabling NLP may increase the overall output of filter above unity and should be compensated for outside of the filter.
  kSaturation = 2 ; saturation amount to use for non-linear processing. Values > 1 increase the steepness of the NLP curve.
  iStore = 1 ;initial disposition of internal data space. Since filtering incorporates a feedback loop of previous output, the initial status of the storage space used is significant. A zero value will clear the space; a non-zero value will allow previous information to remain. The default value is 0.

  ; kCutoffFrequency = oscil(5000, 2) + 5300
  kQ = oscil(1, 1) + 2
  kSaturation = oscil(.5, .5) + 1

  aSignalOutL K35_lpf aSignalInL, kCutoffFrequency, kQ, iNonLinearProcessingMethod, kSaturation, iStore
  aSignalOutR K35_lpf aSignalInR, kCutoffFrequency, kQ, iNonLinearProcessingMethod, kSaturation, iStore

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr K35LowPassFilterAmountKnob
  gkK35LowPassFilterAmount linseg p4, p3, p5
endin

instr K35LowPassFilterBassKnob
  gkK35LowPassFilterEqBass linseg p4, p3, p5
endin

instr K35LowPassFilterMidKnob
  gkK35LowPassFilterEqMid linseg p4, p3, p5
endin

instr K35LowPassFilterHighKnob
  gkK35LowPassFilterEqHigh linseg p4, p3, p5
endin

instr K35LowPassFilterFader
  gkK35LowPassFilterFader linseg p4, p3, p5
endin

instr K35LowPassFilterPan
  gkK35LowPassFilterPan linseg p4, p3, p5
endin

instr K35LowPassFilterMixerChannel
  aK35LowPassFilterL inleta "InL"
  aK35LowPassFilterR inleta "InR"

  aK35LowPassFilterL, aK35LowPassFilterR mixerChannel aK35LowPassFilterL, aK35LowPassFilterR, gkK35LowPassFilterFader, gkK35LowPassFilterPan, gkK35LowPassFilterEqBass, gkK35LowPassFilterEqMid, gkK35LowPassFilterEqHigh

  outleta "OutL", aK35LowPassFilterL
  outleta "OutR", aK35LowPassFilterR
endin
