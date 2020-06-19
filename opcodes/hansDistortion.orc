;;Based on an example written by Hans Mikelson -- http://www.csounds.com/mikelson/#multifx


opcode hansDistortion, a, akkkko
  aDistortionIn, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable xin
  iDefaultDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  iDistortionTable = iDistortionTable == 0 ? iDefaultDistortionTable : iDistortionTable

  aDistortionEffect = kPreGain * aDistortionIn/60000

  aClip tablei  aDistortionEffect, iDistortionTable , 1, .5

  aClip *= kPostGain*15000

  aTemp delayr .1
  aDistortionOut deltapi (2- kDutyOffset * aDistortionEffect)/1500 + kSlopeShift * (aDistortionEffect - aDistortionIn)/300
  delayw  aClip

  xout aDistortionOut
endop
