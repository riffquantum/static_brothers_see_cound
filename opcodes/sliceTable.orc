;; sliceTable - turns a table into an array, slices it, turns it back into a table
opcode sliceTable, i, iii
  iTable, iStartingIndex, iEndingIndex xin
  iNumberOfValues = iEndingIndex - iStartingIndex + 1
  iTableLength = -1 * iNumberOfValues


  iSlicedTable ftgen 0, 0, iTableLength, -2, 0

  iOriginalTableIndex = iStartingIndex
  iNewTableIndex = 0
  setTableValues:
    iValue table iOriginalTableIndex, iTable

    tableiw iValue, iNewTableIndex, iSlicedTable
    iNewTableIndex = iNewTableIndex + 1

  loop_lt iOriginalTableIndex, 1, (iEndingIndex+1), setTableValues

  xout iSlicedTable
endop
