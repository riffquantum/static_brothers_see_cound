# static_brothers_see_cound

## Static Brothers
### CSound Project Take 1
### Joe Hughes and Quinn McCord

TO DO:

Write some kind of limiter that can react to input and prevent clipping during many simulatenous events
	One option to protect against that is to have everything work at a very low volume so that we have lots of headroom for simultaneous events and then amplify it at the end
		A fast way to that is to change the value of 0dbsf by an order of magnitude.

Write some sequencing/scheduling instruments that can replace current score usage and allow for faster beat composition and more powerful programming capabilities. 
	I want to be able to schedule drum beats with very few inputs. 
	Should set defaults for pfields.
	should be really convenient to add and remove notes
	should be convenient to adjust note params but also unobtrusive
	

Find a solution for instrument interruption in realtime MIDI situations (IE hi hat closure)
	In the MPC and FL's MPC emulator, samples are assigned numbers for interrupts. I could put an interrupt stage in the instruments before the mixer channel that works as a global audio variable. 

Improve responsiveness of real time MIDI input
