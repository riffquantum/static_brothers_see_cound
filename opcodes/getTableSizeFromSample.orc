;getTableSizeFromSample
;Accepts a filepath as a string and returns the length in samples
;  rounded to the nearest power of 2.
;It's handy for working with opcodes
;  that require explicitly defined table lengths witha power of 2 value

opcode getTableSizeFromSample, i, S
	SFilePath xin
    iFileLength filelen SFilePath
    iFileNumChannels filenchnls SFilePath
    iFileSampleRate filesr SFilePath
    iLengthInSamples = iFileLength * iFileNumChannels * iFileSampleRate
    iTableLength = 2^ceil(log10(iLengthInSamples) / log10(2))
    xout iTableLength
endop