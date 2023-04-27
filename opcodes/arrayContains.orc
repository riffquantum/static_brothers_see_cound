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

opcode arrayContainsS, i, S[]S
  SArray[], SElement xin
  iIndex = 0
  iMatchFound = -1

  until iMatchFound == 0 || iIndex == lenarray(SArray) do
    iMatchFound = strcmp(SArray[iIndex], SElement)

    iIndex += 1
  od

  xout iMatchFound == 0 ? 1 : 0
endop
