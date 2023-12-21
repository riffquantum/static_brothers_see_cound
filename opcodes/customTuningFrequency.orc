giCustomTuningFrequencyDefaultRatios ftgen 0, 0, 0, 2, 1/1, 1, 9/8, 1, 5/4, 4/3, 1, 3/2, 1, 5/3, 1, 15/8
giPartchRatios ftgen 0, 0, 0, 2, 1/1, 81/80,	33/32,	21/20,	16/15, 12/11, 11/10, 10/9, 9/8, 8/7, 7/6, 32/27, 6/5, 11/9, 5/4, 14/11, 9/7, 21/16, 4/3, 27/20, 11/8, 7/5, 10/7, 16/11, 40/27, 3/2, 32/21, 14/9, 11/7, 8/5, 18/11, 5/3, 27/16, 12/7, 7/4, 16/9, 9/5, 20/11, 11/6, 15/8, 40/21, 64/33, 160/81
giBohlenPierceRatios ftgen 0, 0, 0, 2, 1/1, 27/25, 25/21, 9/7, 7/5, 75/49, 5/3, 9/5, 49/25, 15/7, 7/3, 63/25, 25/9

; This is based on the frets of a Bağlama justly intonated (https://en.wikipedia.org/wiki/Ba%C4%9Flama)
giJustBaglama ftgen 0, 0, 0, 2, 1/1, 18/17, 12/11, 9/8, 81/68, 27/22, 81/64, 4/3, 24/17, 16/11, 3/2, 27/17, 18/11, 27/16, 16/9, 32/17, 64/33

giHoldrianComma = 2^(1/53)
giTurkishRatios ftgen 0, 0, 0, 2, (giHoldrianComma^0), (giHoldrianComma^4), (giHoldrianComma^5), (giHoldrianComma^8), (giHoldrianComma^9), (giHoldrianComma^13), (giHoldrianComma^14), (giHoldrianComma^17), (giHoldrianComma^18), (giHoldrianComma^22), (giHoldrianComma^23), (giHoldrianComma^26), (giHoldrianComma^27), (giHoldrianComma^30), (giHoldrianComma^31), (giHoldrianComma^35), (giHoldrianComma^36), (giHoldrianComma^39), (giHoldrianComma^40), (giHoldrianComma^44), (giHoldrianComma^45), (giHoldrianComma^48), (giHoldrianComma^49), (giHoldrianComma^52)


opcode customTuningFrequency, i, iiooo
  iOctaveNumber, iNoteNumber, iRatios, iFrequencyOfMiddleC, iOctaveSize xin
  iFrequencyOfMiddleC = iFrequencyOfMiddleC == 0 ? 261.626 : iFrequencyOfMiddleC
  iRatios = iRatios == 0 ? giCustomTuningFrequencyDefaultRatios : iRatios
  iDivisions = ftlen(iRatios)
  iOctaveSize = iOctaveSize == 0 ? 2 : iOctaveSize

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/iDivisions)
  iNoteNumber = round(iNoteNumber % iDivisions)

  iRatio = table(iNoteNumber, iRatios)

  iOctaveFrequency = iFrequencyOfMiddleC * iOctaveSize^(iOctaveNumber -4)
  iFrequency = iOctaveFrequency * iRatio

  xout iFrequency
endop
