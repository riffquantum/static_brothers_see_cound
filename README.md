# static_brothers_see_cound

## Static Brothers
### CSound Project Take 1
### Joe Hughes and Quinn McCord

This is the Static Brothers' CSound application for composition and performance.

TO DO:
* Write some kind of limiter that can clipping during many simulatenous events for the final output.
-- The urgency of this has been mitigated. I changed the default value of 0dbsf by an order of magnitude thus giving every file a lot more head room.

* Find a solution for instrument interruption in realtime MIDI situations (IE hi hat closure) - The right way to do this is to use MIDI note on/note off signals and to ditch this triggering of score events method I'm using.

* Improve responsiveness of real time MIDI input

* Write a BPM setter instrument that can change the global BPM variable at different points in the score. This might mean changing the BPM variable to k rate.

* Effects - I think our approach to effects should be to write them as opCodes and then wrap them in instruments on a song by song basis for manipulating their parameters in the score.
	- reverb
	- delay
	- echo
	- chorus
	- distortion
    - ring mod

* Cool Synths

* Add some good envelopes to samplers

* Finish 303 conversion

Handy Notes:
Conversion Specifiers for string interpolation:
* d, i, o, u, x, X, e, E, f, F, g, G, c, s
* http://www.cplusplus.com/reference/cstdio/printf/
