# static_brothers_see_cound

## Static Brothers
### CSound Project Take 1
### Joe Hughes and Quinn McCord

This is the Static Brothers' CSound application for composition and performance. 

TO DO:

Write some kind of limiter that can react to input and prevent clipping during many simulatenous events
	One option to protect against that is to have everything work at a very low volume so that we have lots of headroom for simultaneous events and then amplify it at the end
		A fast way to that is to change the value of 0dbsf by an order of magnitude.

Write some sequencing/scheduling instruments that can replace current score usage and allow for faster beat composition and more powerful programming capabilities. 
	I like what I've got right now. It's not as smooth and intuitive as clicking on a grid but my beatScoreline opcode at least allows us to schedule notes in the orchestra and define patterns as instruments. That way the score can be used for high level song layout.
	

Find a solution for instrument interruption in realtime MIDI situations (IE hi hat closure)
	In the MPC and FL's MPC emulator, samples are assigned numbers for interrupts. I could put an interrupt stage in the instruments before the mixer channel that works as a global audio variable. 

Improve responsiveness of real time MIDI input

Find a way to interrupt midi triggered events (hi hat closure)

Filters, effects and EQ
	Any instrument channel should have an EQ stage in it.
	High Pass, Low Pass filters
	Nice Reverbs

Synthesizers
	figure out that 303 emulator
	write something good for bass

Find a way to change global BPM value whenever
	probably just need to make giBPM into giBPM

