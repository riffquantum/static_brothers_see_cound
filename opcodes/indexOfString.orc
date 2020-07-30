opcode indexOfString, i, SS[]
  SElement, SArray[] xin
  iIndex = 0
  iMatchFound = 0

  until iMatchFound == 1 || iIndex == lenarray(SArray) do
    iMatch = strcmp(SArray[iIndex], SElement) == 1 ? 1 : 0
    iResult = strcmp(SArray[iIndex], SElement) == 1 ? iIndex : -1
    iIndex += 1
  od

  xout iResult
endop
