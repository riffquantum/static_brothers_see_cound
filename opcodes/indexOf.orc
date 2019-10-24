opcode indexOf i, ii[]
  iElement, iArray[] xin
  iIndex = 0
  iMatchFound = 0

  until iMatchFound == 1 || iIndex == lenarray(iArray) do
    iMatch = iArray[iIndex] == iElement ? 1 : 0
    iResult = iArray[iIndex] == iElement ? iIndex : -1
    iIndex += 1
  od

  xout iResult
endop
