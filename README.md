# static_brothers_see_cound

## Static Brothers
### Csound Project Take 1
### Joe Hughes and Quinn McCord

This is the Static Brothers' Csound application for composition and performance.

### Some Notes on my approach:

#### Instrument Definition:
- I write my instruments with a specific format. Each sound generating instrument gets its own .orc file, and maybe its own directory if necessary, within the instruments directory. Most instruments will also have a set of supporting instruments that include a Mixer Channel Instrument, which accepts sound from the primary instrument and applies amplitude, panning, and EQ changes before passing it out with the outleta opcode. There are also global k-rate variables for each channel's volume and eq values that should always be namespaced with the primary instrument (e.g. gkBigRichSynthFader, gkBigRichSynthPan). I typically will not ever have a direct out. Instead they route the signal through any number of supporting effects instruments or busses before the mixer instrument outputs the final mix in two channels. This approach was largely inspired by Stephen Yi's "Emulating MIDI-based Studio Setups with Csound" (http://www.csounds.com/journal/issue13/emulatingMidiBasedStudios.html).

- A newer pattern in this repository is to define instruments as Macros that can redeclare new instances of an instrument repeatedly. This is convenient during composition and really DRYs up the repository when instrument patterns are reused in every song. The convention in this repo is to declare macros in all caps with underscores. See BREAK_SAMPLE.orc for an example. Instruments that play a sample with pitch adjusted for song tempo are exceptionally common in our songs. The macro allows such instruments to be declard in one line with arguments for instrument name, route, sample path, etc: `$BREAK_SAMPLE(AmenBreak'Mixer'localSamples/amenBreak.wav'16)`. See the file itself for more specific documentation. Usage of these Macros reduces the need for the "one instrument definition per file" rule and you may find cases, such as sets of drum samples, are defined together in a single file along with their shared busses and effects.

#### Directory Structure:
- My approach breaks files up into reusable partials as much as possible. I'll describe some important aspects of this.
- The config directory contains a few default config files. One contains the set of values that csound needs to operate (sr, ksmps, kr, nchnls, 0dbfs) as well as the gkBPM variable (more on that later). There is also a file for setting MidiChannel assignments with namespaced global variables.
- Instruments are kept in the instruments directory as described above. There are all included in a file called orchestra-manifest.orc.
- There is a localSamples directory which is not included in the repository. This is just a big collection WAV file samples that is too big to host on GitHub.
- User Defined Opcodes, like instruments, each get their own file within the opcodes directory and they are gathered for inclusion in opcode-manifest.orc. I have a bunch of utility opcodes in here, a couple that set up specific keyboard layouts for midi input, common function table generators (Sine, Saw, Square, etc), various signal processors/effects, and others.
- There is a patterns directory with a pattern-manifest file. This is a place to store any kind of pattern of score statements for reuse in different songs. Like a common hi-hat pattern or something like that.
- See the Utilities section below for more info on the previewer directory.
- The songs directory is where new projects should be stored. Each song should get its own directory with a central .csd file that executes the whole composition. The directory structure within a song directory should match the global directory structure with song-specific overrides wherever necessary. You may need to override the config files so you would put a new file in songs/{song name}/config/. You'll very likely write song-specific instruments. They belong in songs/{song name}/instruments/ and the song's csd should reference its own orchestra-manifest instead of the global one. The patterns directory is much more useful within a specific song for reasons that should be obvious. See getDiluvian/ for an example of how I use all these song specific overrides.

#### Utilities
- There is a directory called previewer/ with its own README. This is basically a shell script and webpage that watches your files and renders them as you change them. The webpage displays the Waveform so you can scrub and play as you work. If you serve it through a local server then it will also auto refresh. See the specific readme for more info.
- There is a .csd in the root directory called workBench.csd. It's meant to serve as place to quickly sketch out ideas or to work on instruments and opcodes outside of the context of any particular song. Nothing in this file should be considered permanent or stable.

#### Approach to the Score
- Csound's operations are split into two areas: The Orchestra and The Score. The orchestra offers a lot of freedom to a developer for programmatic events, dynamic values and whatever other promises of computer music brought you here. The score, on the other hand, is extremely limited and frankly is a bummer to work with. With a lot of inspiration from Csound Journal articles I've developed an approach to writing my instrument events in the orchestra instead of the score. In some ways it's a little chunky and ugly but the advantages are all the freedom that working in the orchestra provides.
- On a note by note level I use a custom opcode called beatScoreLine (which is also aliased to `_`) to trigger individual instrument instances. This opcode takes 4 arguments: instrument name, start time, duration, and a string of the instrument's other p-fields. The opcode uses the gkBPM variable to schedule the event at the correct tempo. This extra layer around events is necessary because events in the orchestra space do not respect t statements in the score. gkBPM should be defined in every song and a t statement needs to be included in the score with a matching value. I don't like the fact that the tempo needs to be defined in multiple places but I haven't found a way around it yet.
- These events will mostly be triggered within patterns. I create instruments that I call patterns to trigger sets of events. So I might define a bassline as one pattern and drum track as another then trigger both of them in the score simultaneously. This approach to pattern layout allows for loops that change over time and can be a lot fun to work with.
In a song, I usually use the actual score only to trigger the broad sections of a song. See getDiluvian.csd for an example of this type of layout.


#### Live Input
- I've recently started to write my instruments with realtime midi input in mind. So now I try to make sure that any instrument I write can be triggered in the score or with midi input. I've written some opcodes for flexibily accepting p-fields or midi values for amplitude and pitch. I also added a central config file for channel assignments. I like instrument channel assignments in one file so that I won't accidentally overwrite another instrument's assignment. Approach to control values is in development. More documentation is forthcoming.
- Another goal of this repo is to replace FL Studio as the brain of our live Drum Trigger setup. There is a big midi routing instrument in progress in songs/sbDrumKit/. This thing is large, complex, and evolving so it probably warrants it's own README. The basic idea is that a central instrument triggers other instruments based on the midi note, there is a separate instrument for each pad on my drumkit and mpc and those instruments will then trigger the actual sound generating instruments. These instruments can also cancel one another (like in the case of hi-hat closure). More documentation on this is forthcoming. NOTE: This description is pretty out of date. There have been a lot of changes and even a succesful show with this. liveDrums.csd in the root directory is now the starting point for this. More documentation forthcoming.

#### Code Style
- Broadly speaking, my code style favors readability over brevity. I prefer long descriptive variable, opcode, and instrument names. I avoid numbered instrument definitions for clarity's sake. This occassionally causes problems. When I absolutely have to use a numbered instrument definition I store that number in a namespaced global variable for easy, readable access.
- Files should be broken up as often as it's sensible to do so. See the notes above on directory structure for more on that.
- Instrument names should be defined in PascalCase. Variable and Opcode names should be in camelCase. Macros in all caps with underscores (what's the name for that one?)
- Indenting should be 2 spaces in all files.
- Global variables are pretty liberally used. I often write instruments that control aspects of other instruments and I use global variables to allow that interraction. I mitigate the danger of scoping issues by namespacing all global variables with the instrument name. I am open to criticisms and alternatives to this approach.
- Code standards have been developed over the lifetime of this repo and are inconsistently applied. This whole repo is due for a big cleanup, especially with indentation.


### TO DO's
* Figure out smooth tempo changes with orchestra triggered score events
* Improve 3 Band EQ opcode with shelf adjustments for Hi and Low
* Finish 303 conversion -- heres a JS 303 example: https://github.com/errozero/js-303-instrument/blob/master/acid_synth.instrument.js
* try these Yamaha Synth Emulators: https://github.com/gleb812/cs81z, http://www.parnasse.com/dx72csnd.shtml
3000146976147
* Do something fun with this gesture to MIDI thing: https://www.youtube.com/watch?v=H97t17Q_BbM

### Handy Notes:
Conversion Specifiers for string interpolation:
* d, i, o, u, x, X, e, E, f, F, g, G, c, s
* http://www.cplusplus.com/reference/cstdio/printf/
