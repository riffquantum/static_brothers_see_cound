# static_brothers_see_cound

## Static Brothers
### Csound Project Take 1
### Joe Hughes and Quinn McCord

This is the Static Brothers' Csound application for composition and performance.

### Some Notes on my approach:

#### Instrument Definition:
- I write my instruments with a specific format. Each sound generating instrument gets its own .orc file in its own directory within the instruments directory. Most instruments will also have a set of supporting instruments that include a Mixer Channel Instrument, which accepts sound from the primary instrument and applies amplitude, panning, and EQ changes before passing it out with the outleta opcode. There are also control instruments for each channel's volume and eq values. These instrument groups relate to one another with global variables that should always be namespaced with the primary instrument (e.g. gkBigRichSynthFader, gkBigRichSynthPan). These instruments typically will not ever have a direct out. Instead they route the signal through any number of supporting effects instruments or busses before the mixer instrument outputs the final mix in two channels. There are deliberate exceptions such as the Metronome Instrument. This approach was largely inspired by Stephen Yi's "Emulating MIDI-based Studio Setups with Csound" (http://www.csounds.com/journal/issue13/emulatingMidiBasedStudios.html).

#### Directory Structure:
- My approach breaks files up into reusable partials as much as possible. I'll describe some important aspects of this.
- The config directory contains a few default config files. One contains the set of values that csound needs to operate (sr, ksmps, kr, nchnls, 0dbfs) as well as the giBPM variable (more on that later). There is also a file for setting MidiChannel assignments with namespaced global variables.
- Instruments are kept in their own directories as described above. There are all included in a file called orchestra-manifest.orc.
- There is a localSamples directory which is not included in the repository. This is just a big collection WAV file samples that is too big to host on GitHub.
- User Defined Opcodes, like instruments, each get their own file within the opcodes directory and they are gather for inclusion in opcode-manifest.orc. I have a bunch of utility opcodes in here, a couple that set up specific keyboard layouts for midi input, common function table generators (Sine, Saw, Square, etc), and others. I have not developed a thorough approach to effects yet but for now I'm trying to write the basic signal processors as opcodes which will then be wrapped in effects instruments.
- There is a patterns directory with a pattern-manifest file. This is a place to store any kind of pattern of score statements for reuse in different songs. Like a common hi-hat pattern or something like that.
- More on the previewer directory later.
- The songs directory is where new projects should be stored. Each song should get its own directory with a central .csd file that executes the whole composition. The directory structure within a song directory should match the global directory structure with song-specific overrides wherever necessary. You may need to override the config files so you would put a new file in songs/{song name}/config/. You'll very likely write song-specific instruments. They belong in songs/{song name}/instruments/ and the song's csd should reference its own orchestra-manifest instead of the global one. The patterns directory is much more useful within a specific song for reasons that should be obvious. See getDiluvian/ for an example of how I use all these song specific overrides.
- There are still a number of .csd's in the root directory. These are either leftovers from before this directory structure was fully developed or quick files written to test specific instruments. I intend to remove them or find new homes for them. The testing files are a good concept but are not all that useful right now. I need to develop some kind of approach to unit tests for instruments and features.

#### Utilities
- There is a directory called previewer/ with its own README. This is basically a shell script and webpage that watches your files and renders them as you change them. The webpage displays the Waveform so you can scrub and play as you work. If you serve it through a local server then it will also auto refresh. See the specific readme for more info.
- There is a .csd in the root directory called workBench.csd. I often find myself working on an instrument concept or some code change outside of a specific song. In the past I might have spent time making a new file in the root directory, working in that, and then either spending time cleaning it up after or leaving a messy collection of half-baked ideas in the root directory. This file is meant to address that and serve as a designated place to try out concepts and instrument ideas.

#### Approach to the Score
- Csound's operations are split into two areas: The Orchestra and The Score. The orchestra offers a lot of freedom to a developer for programmatic events, dynamic values and whatever other promises of computer music brought you here. The score, on the other hand, is extremely limited and frankly is a bummer to work with. With a lot of inspiration from Csound Journal articles I've developed an approach to writing my instrument events in the orchestra instead of the score. In some ways it's a little chunky and ugly but the advantages are all the freedom that working in the orchestra provides.
- On a note by note level I use a custom opcode called beatScoreLine to trigger individual instrument instances. This opcode takes 4 arguments: instrument name, start time, duration, and a string of the instrument's other p-fields. The opcode uses the giBPM variable to schedule the event at the correct tempo. This extra layer around events is necessary because events in the orchestra space do not respect t statements in the score. giBPM should be defined in every song and a t statement needs to be included in the score with a matching value. I don't like the fact that the tempo needs to be defined in multiple places but I haven't found a way around it yet.
- These events will mostly be triggered within patterns. I create instruments that I call patterns to trigger sets of events. So I might define a bassline as one pattern and drum track as another then trigger both of them in the score simultaneously. This approach to pattern layout allows for loops that change over time and can be a lot fun to work with.
In a song, I usually use the actual score only to trigger the broad sections of a song. See getDiluvian.csd for an example of this type of layout.


#### Live Input
- I've recently started to write my instruments with realtime midi input in mind. So now I try to make sure that any instrument I write can be triggered in the score or with midi input. I've written some opcodes for flexibily accepting p-fields or midi values for amplitude and pitch. I also added a central config file for channel assignments. I like instrument channel assignments in one file so that I won't accidentally overwrite another instrument's assignment. Approach to control values is in development. More documentation is forthcoming.
- Another goal of this repo is to replace FL Studio as the brain of our live Drum Trigger setup. There is a big midi routing instrument in progress in songs/sbDrumKit/. This thing is large, complex, and evolving so it probably warrants it's own README. The basic idea is that a central instrument triggers other instruments based on the midi note, there is a separate instrument for each pad on my drumkit and mpc and those instruments will then trigger the actual sound generating instruments. These instruments can also cancel one another (like in the case of hi-hat closure). More documentation on this is forthcoming.

#### Code Style
- Broadly speaking, my code style favors readability over brevity. I prefer long descriptive variable, opcode, and instrument names. I avoid numbered instrument definitions for clarity's sake. This occassionally causes problems. When I absolutely have to use a numbered instrument definition I store that number in a namespaced global variable for easy, readable access.
- Files should be broken up as often as it's sensible to do so. See the notes above on directory structure for more on that.
- Instrument names should be defined in PascalCase. Variable and Opcode names should be in camelCase.
- Indenting should be 2 spaces in all files.
- Global variables are pretty liberally used. I often write instruments that control aspects of other instruments and I use global variables to allow that interraction. I mitigate the danger of scoping issues by namespacing all global variables with the instrument name. I am open to criticisms and alternatives to this approach.
- Code standards have been developed over the lifetime of this repo and are inconsistently applied. This whole repo is due for a big cleanup, especially with indentation.


### TO DO's
* Turn giBPM into gkBPM.
* Write a BPM setter instrument that can change the global BPM variable at different points in the score
* Write a good distortion
* Write a chorus
* Write a flanger
* Write a better delay
* Write a ring mod
* Improve 3 Band EQ opcode with shelf adjustments for Hi and Low
* Write some kind of limiter that can prevent clipping in a smart way during many simulatenous events for the final output (The urgency of this has been mitigated. I changed the default value of 0dbsf by an order of magnitude thus giving every file a lot more head room.)
* Generally improve my approach to overall amplitude
* Cool Synths - Make some cool synths
* Finish 303 conversion -- heres a JS 303 example: https://github.com/errozero/js-303-instrument/blob/master/acid_synth.instrument.js
* A shell script for starting new songs would be really nice.

### SB Drumkit To Do's
* duplicate current sample sets and songs in FL
* Figure out some nice velocity curves - this will involve sitting down at the drum kit and feeling out the pads.
* Set up some control knobs for adjusting different instrument parameters.
* Trying routing some note instruments through effects and test performace.

### Handy Notes:
Conversion Specifiers for string interpolation:
* d, i, o, u, x, X, e, E, f, F, g, G, c, s
* http://www.cplusplus.com/reference/cstdio/printf/


### Possible Csound Bugs I've found
* turnoff2 does not work within while loops
* connect does not work if instrument is declared with multiple names (integer and string names). Wrong, it actually works but it seems like you need to use the last declared name
