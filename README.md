# static_brothers_see_cound

## Static Brothers
### CSound Project Take 1
### Joe Hughes and Quinn McCord

This is the Static Brothers' CSound application for composition and performance.

TO DO:

MIDI Stuff
    done - Get all sample instruments running through amplitude envelopes
    done - Get All Sample Instruments accepting velocity as p4
    - duplicate current sample sets and songs in FL
    - Figure out some nice velocity curves
        this will involve sitting down at the drum kit and feeling out the pads

    - try writing an instrument that could be triggered by different note instruments and making sure they are included in the turnoff scheme
    - Work control knobs into this setup
    - Trying routing some note instruments through effects

* Change break beat instruments to calculate BPM from length and number of beats and add a time factor pfield

* Write some kind of limiter that can clipping during many simulatenous events for the final output.
-- The urgency of this has been mitigated. I changed the default value of 0dbsf by an order of magnitude thus giving every file a lot more head room.



* Write a BPM setter instrument that can change the global BPM variable at different points in the score. This might mean changing the BPM variable to k rate.

* Effects - I think our approach to effects should be to write them as opCodes and then wrap them in instruments on a song by song basis for manipulating their parameters in the score.
	- reverb
	- delay
	- echo
	- chorus
	- distortion
    - ring mod

* Cool Synths - Make some cool synths.

* Add some good envelopes to samplers

* Finish 303 conversion

Handy Notes:
Conversion Specifiers for string interpolation:
* d, i, o, u, x, X, e, E, f, F, g, G, c, s
* http://www.cplusplus.com/reference/cstdio/printf/


CSOUND Bugs maybe I've found?
* turnoff2 does not work within while loops
* connect does not work if instrument is declared with multiple names (integer and string names)
