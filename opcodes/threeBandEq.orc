/* threeBandEq and threeBandEqStereo
A three band Equalizer that accepts an audio signal (or two) and three k-rate values for Bass, Mid and High. It runs the signal through eqfil for each of those ranges.
*/

opcode threeBandEq, a, akkk
    aSignal, kEqBass, kEqMid, kEqHigh xin

    /*
    aSignal eqfil aSignal, 155, 200, kEqBass
    aSignal eqfil aSignal, 2125, 1000, kEqMid
    aSignal eqfil aSignal, 5000, 1000, kEqHigh
    */

    aSignal pareq aSignal, 150, kEqBass, sqrt(.5), 1
    aSignal eqfil aSignal, 2125, 1000, kEqMid
    aSignal pareq aSignal, 5000, kEqHigh, sqrt(.5), 2

    xout aSignal
endop

opcode threeBandEqStereo, aa, aakkk
    aSignalL, aSignalR, kEqBass, kEqMid, kEqHigh xin

    /*
    aSignalL eqfil aSignalL, 155, 200, kEqBass
    aSignalR eqfil aSignalR, 155, 200, kEqBass

    aSignalL eqfil aSignalL, 2125, 1000, kEqMid
    aSignalR eqfil aSignalR, 2125, 1000, kEqMid

    aSignalL eqfil aSignalL, 5000, 1000, kEqHigh
    aSignalR eqfil aSignalR, 5000, 1000, kEqHigh
    */

    aSignalL pareq aSignalL, 150, kEqBass, sqrt(.5), 1
    aSignalR pareq aSignalR, 150, kEqBass, sqrt(.5), 1

    aSignalL eqfil aSignalL, 2125, 1000, kEqMid
    aSignalR eqfil aSignalR, 2125, 1000, kEqMid

    aSignalL pareq aSignalL, 5000, kEqHigh, sqrt(.5), 2
    aSignalR pareq aSignalR, 5000, kEqHigh, sqrt(.5), 2

    xout aSignalL, aSignalR
endop
