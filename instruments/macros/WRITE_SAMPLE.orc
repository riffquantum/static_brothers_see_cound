; My desire for a live granulizer remains. What I have now is good for certain applications but not the drop in and drop out sort of effect I want.

; One option I haven't tried is an alwayson buffer that is being written to at all times. That might at least eliminate unwanted noise and initial lack of data. The drawback is of course that it can't read into the future.


; Here's a compromise idea:

; A General Internal Sampler

; Instrument reads from some channel and writes to a buffer while it's on. The tables can be stored in a namespaced array and then be I could even do its routing in such a way that it can be parallel to a signal chain, not in it so it doesn't interrupt playback or require a bypass switch.

; Gonna need to figure out a way to get some instruments to accept a table number instead of a path.

; So I want to make a little break beat pattern with a regular break sampler. I want to record one measure of it here. Then 1 measure later I want to replace it with a granulizer version to allow for sudden twists. The original idea would still kinda be better for that though. Definitely want to test it with the constant buffer. Or even with a buffer that has to be separetly turned on.

#define WRITE_SAMPLE(INSTRUMENT_NAME'SOURCE) #
  gi$INSTRUMENT_NAME.SampleBankL[] init 10
  gi$INSTRUMENT_NAME.SampleBankR[] init 10

  connect "$SOURCE", "OutL", "$INSTRUMENT_NAME", "InL"
  connect "$SOURCE", "OutR", "$INSTRUMENT_NAME", "InR"

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    gi$INSTRUMENT_NAME.SampleBank[p4] = ftgen	0, 0, (p3 * sr), 2, 0

    recordBuffer gi$INSTRUMENT_NAME.SampleBankL[p4], aInL
    recordBuffer gi$INSTRUMENT_NAME.SampleBankR[p4], aInR
  endin
#
