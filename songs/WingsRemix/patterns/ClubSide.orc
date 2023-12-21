instr ClubSide
  gkVoxLongScreamFader = .65
  ; gkVoxHighBabbleFader =  .9
  ; gkVox1Fader = .9

  gkCloserKickFader = 0.9
  gkCloserSnareFader = 0.7
  gkFalseHatFader = 0.4

  gkGuitar1_B52Fader = .4
  gkGuitar2_B52Fader = .4
  gkBassBusFader = .4

  _ "NoInput", 0, stb(p3)+64, 25, 5.06
  _ "NoInput", 0, stb(p3)+64, 35, 5.05 ; experiment to get the harsh part of this right to the end
  _ "TechnoLoop", 0, 32
  ; _ "HiVox2", 0, 3, 100, 1 ; ma long
  _ "HiVox1", 9, 3, 60, 1 ;byea long
  _ "LowVox8", 16, 3, 60, 1 ; ma long
  _ "LowVox8", 20, 3, 60, .95
  ; _ "HiVox3", 0, 3, 100, 1 ; ya long harsher
  ; I think looping the descending guitar riff at the end of song over the electro loop could be good

  _ "LowVox2", 30, 3, 70, .8
  _ "ElectroLoop", 32, 32

  _ "Vox3Scratch", 32+8, 16
  _ "VoxScratch", 32+24, 28

  _ "TechnoLoop", 64, 32
  _ "LowVox3", 68, 3, 70, .8

  _ "Vox2Scratch", 64+12, 28

  _ "Vox2Scratch", stb(p3)-4, 28
  _ "HiVox1", stb(p3)+8, 3, 60, 1
  _ "HiVox2", stb(p3)+16, 3, 60, 1

  _ "CloserKick", stb(p3), 1, 100, 1
  _ "CloserKick", stb(p3) + 1, 1, 100, 1
  _ "CloserKick", stb(p3) + 2, 1, 100, 1

  _ "CloserKick", stb(p3) + 4.3333, 1, 100, .8
  _ "CloserKick", stb(p3) + 9, 1, 100, .8

  _ "CloserKick", stb(p3) + 13, 1, 100, .6

  ; maybe don't even need this
  ; _ "ElectroLoop", 96, 32
  ; _ "Vox3Scratch", 96+8, 16
  ; _ "VoxScratch", 96+24, 28
endin
