giCustomTuningFrequencyDefaultRatios ftgen 0, 0, 0, 2, 1/1, 1, 9/8, 1, 5/4, 4/3, 1, 3/2, 1, 5/3, 1, 15/8

giPartchRatios ftgen 0, 0, 0, 2, 1/1, 81/80,	33/32,	21/20,	16/15, 12/11, 11/10, 10/9, 9/8, 8/7, 7/6, 32/27, 6/5, 11/9, 5/4, 14/11, 9/7, 21/16, 4/3, 27/20, 11/8, 7/5, 10/7, 16/11, 40/27, 3/2, 32/21, 14/9, 11/7, 8/5, 18/11, 5/3, 27/16, 12/7, 7/4, 16/9, 9/5, 20/11, 11/6, 15/8, 40/21, 64/33, 160/81

opcode customTuningFrequency, i, iioo
  iOctaveNumber, iNoteNumber, iRatios, iFrequencyOfRoot xin
  iFrequencyOfRoot = iFrequencyOfRoot == 0 ? 261.63 : iFrequencyOfRoot
  iRatios = iRatios == 0 ? giCustomTuningFrequencyDefaultRatios : iRatios
  iDivisions ftlen iRatios

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/iDivisions)
  iNoteNumber = iNoteNumber % iDivisions

  iOctaveFrequency = iFrequencyOfRoot * 2^(iOctaveNumber -4)
  iFrequency = iOctaveFrequency * table(iNoteNumber, iRatios)

  xout iFrequency
endop
