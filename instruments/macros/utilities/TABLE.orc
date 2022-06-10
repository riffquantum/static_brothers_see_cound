/*
  TABLE
  Macro for convenient creation of arbitrary tables with Gen Routine 2.
  Very lazy stuff here

  Macro Arguments:
    $SIZE - Number - Size of the table. 0 is a deferred size allocation.
    $CONTENTS - String - A comma separated list of values.
*/

#define TABLE(SIZE'CONTENTS) #
  ftgen(0, 0, $SIZE, -2, $CONTENTS)
#
