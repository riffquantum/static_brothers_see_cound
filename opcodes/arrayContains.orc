opcode arrayContains, i, i[]i
  iArray[], iElement xin
  iIndex = 0
  iMatchFound = 0

  until iMatchFound == 1 || iIndex == lenarray(iArray) do
    iMatchFound = iArray[iIndex] == iElement ? 1 : 0
    iIndex += 1
  od

  xout iMatchFound
endop
