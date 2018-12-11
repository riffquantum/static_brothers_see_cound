; Linn Drum

connect "LinnDrum", "LinnDrumOutL", "LinnDrumMixerChannel", "LinnDrumInL"
connect "LinnDrum", "LinnDrumOutR", "LinnDrumMixerChannel", "LinnDrumInR"

alwayson "LinnDrumMixerChannel"

gkLinnDrumFader init 1
gkLinnDrumPan init 50

instr LinnDrum

    iCabasaL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Cabasa.aif", 0, 0, 1
    iCabasaR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Cabasa.aif", 0, 0, 2
    iClapL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Clap.aif", 0, 0, 1
    iClapR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Clap.aif", 0, 0, 2
    iCowbellL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Cowbell.aif", 0, 0, 1
    iCowbellR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Cowbell.aif", 0, 0, 2
    iCrashL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Crash.aif", 0, 0, 1
    iCrashR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Crash.aif", 0, 0, 2
    iHatClosed1L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed1.aif", 0, 0, 1
    iHatClosed1R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed1.aif", 0, 0, 2
    iHatClosed2L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed2.aif", 0, 0, 1
    iHatClosed2R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed2.aif", 0, 0, 2
    iHatClosed3L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed3.aif", 0, 0, 1
    iHatClosed3R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed3.aif", 0, 0, 2
    iHatClosed4L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed4.aif", 0, 0, 1
    iHatClosed4R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed4.aif", 0, 0, 2
    iHatClosed5L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed5.aif", 0, 0, 1
    iHatClosed5R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed5.aif", 0, 0, 2
    iHatClosed6L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed6.aif", 0, 0, 1
    iHatClosed6R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed6.aif", 0, 0, 2
    iHatClosed7L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed7.aif", 0, 0, 1
    iHatClosed7R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatClosed7.aif", 0, 0, 2
    iHatOpenL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatOpen.aif", 0, 0, 1
    iHatOpenR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/HatOpen.aif", 0, 0, 2
    iKickL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Kick.aif", 0, 0, 1
    iKickR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Kick.aif", 0, 0, 2
    iRideL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Ride.aif", 0, 0, 1
    iRideR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Ride.aif", 0, 0, 2
    iRimshot1L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot1.aif", 0, 0, 1
    iRimshot1R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot1.aif", 0, 0, 2
    iRimshot2L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot2.aif", 0, 0, 1
    iRimshot2R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot2.aif", 0, 0, 2
    iRimshot3L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot3.aif", 0, 0, 1
    iRimshot3R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot3.aif", 0, 0, 2
    iRimshot4L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot4.aif", 0, 0, 1
    iRimshot4R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot4.aif", 0, 0, 2
    iRimshot5L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot5.aif", 0, 0, 1
    iRimshot5R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot5.aif", 0, 0, 2
    iRimshot6L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot6.aif", 0, 0, 1
    iRimshot6R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot6.aif", 0, 0, 2
    iRimshot7L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot7.aif", 0, 0, 1
    iRimshot7R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot7.aif", 0, 0, 2
    iRimshot8L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot8.aif", 0, 0, 1
    iRimshot8R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot8.aif", 0, 0, 2
    iRimshot9L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot9.aif", 0, 0, 1
    iRimshot9R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Rimshot9.aif", 0, 0, 2
    iSnare1L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare1.aif", 0, 0, 1
    iSnare1R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare1.aif", 0, 0, 2
    iSnare2L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare2.aif", 0, 0, 1
    iSnare2R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare2.aif", 0, 0, 2
    iSnare3L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare3.aif", 0, 0, 1
    iSnare3R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare3.aif", 0, 0, 2
    iSnare4L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare4.aif", 0, 0, 1
    iSnare4R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare4.aif", 0, 0, 2
    iSnare5L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare5.aif", 0, 0, 1
    iSnare5R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare5.aif", 0, 0, 2
    iSnare6L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare6.aif", 0, 0, 1
    iSnare6R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare6.aif", 0, 0, 2
    iSnare7L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare7.aif", 0, 0, 1
    iSnare7R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare7.aif", 0, 0, 2
    iSnare8L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare8.aif", 0, 0, 1
    iSnare8R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare8.aif", 0, 0, 2
    iSnare9L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare9.aif", 0, 0, 1
    iSnare9R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare9.aif", 0, 0, 2
    iSnare10L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare10.aif", 0, 0, 1
    iSnare10R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare10.aif", 0, 0, 2
    iSnare11L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare11.aif", 0, 0, 1
    iSnare11R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare11.aif", 0, 0, 2
    iSnare12L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare12.aif", 0, 0, 1
    iSnare12R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare12.aif", 0, 0, 2
    iSnare13L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare13.aif", 0, 0, 1
    iSnare13R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare13.aif", 0, 0, 2
    iSnare14L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare14.aif", 0, 0, 1
    iSnare14R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Snare14.aif", 0, 0, 2
    iTambourineL ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tambourine.aif", 0, 0, 1
    iTambourineR ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tambourine.aif", 0, 0, 2
    iTom1L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom1.aif", 0, 0, 1
    iTom1R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom1.aif", 0, 0, 2
    iTom2L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom2.aif", 0, 0, 1
    iTom2R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom2.aif", 0, 0, 2
    iTom3L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom3.aif", 0, 0, 1
    iTom3R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom3.aif", 0, 0, 2
    iTom4L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom4.aif", 0, 0, 1
    iTom4R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom4.aif", 0, 0, 2
    iTom5L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom5.aif", 0, 0, 1
    iTom5R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom5.aif", 0, 0, 2
    iTom6L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom6.aif", 0, 0, 1
    iTom6R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom6.aif", 0, 0, 2
    iTom7L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom7.aif", 0, 0, 1
    iTom7R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom7.aif", 0, 0, 2
    iTom8L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom8.aif", 0, 0, 1
    iTom8R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom8.aif", 0, 0, 2
    iTom9L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom9.aif", 0, 0, 1
    iTom9R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom9.aif", 0, 0, 2
    iTom10L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom10.aif", 0, 0, 1
    iTom10R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom10.aif", 0, 0, 2
    iTom11L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom11.aif", 0, 0, 1
    iTom11R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom11.aif", 0, 0, 2
    iTom12L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom12.aif", 0, 0, 1
    iTom12R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom12.aif", 0, 0, 2
    iTom13L ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom13.aif", 0, 0, 1
    iTom13R ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Tom13.aif", 0, 0, 2


    ; ares grain xamp, xpitch, xdens, kampoff, kpitchoff, kgdur, igfn, iwfn, imgdur [, igrnd]
    ; ares grain2 kcps, kfmd, kgdur, iovrlp, kfn, iwfn [, irpow] [, iseed] [, imode]
    ; ares grain3 kcps, kphs, kfmd, kpmd, kgdur, kdens, imaxovr, kfn, iwfn, kfrpow, kprpow [, iseed] [, imode]

    SModifier strget p4
    kKillswitch init p7

    if (strcmp(SModifier, "Cabasa") == 0) then
        iDrumSoundL = iCabasaL
        iDrumSoundR = iCabasaR

    elseif (strcmp(SModifier, "Clap") == 0) then
        iDrumSoundL = iClapL
        iDrumSoundR = iClapR

    elseif (strcmp(SModifier, "Cowbell") == 0) then
        iDrumSoundL = iCowbellL
        iDrumSoundR = iCowbellR

    elseif (strcmp(SModifier, "Crash") == 0) then
        iDrumSoundL = iCrashL
        iDrumSoundR = iCrashR

    elseif (strcmp(SModifier, "HatClosed1") == 0) then
        iDrumSoundL = iHatClosed1L
        iDrumSoundR = iHatClosed1R

    elseif (strcmp(SModifier, "HatClosed2") == 0) then
        iDrumSoundL = iHatClosed2L
        iDrumSoundR = iHatClosed2R

    elseif (strcmp(SModifier, "HatClosed3") == 0) then
        iDrumSoundL = iHatClosed3L
        iDrumSoundR = iHatClosed3R

    elseif (strcmp(SModifier, "HatClosed4") == 0) then
        iDrumSoundL = iHatClosed4L
        iDrumSoundR = iHatClosed4R

    elseif (strcmp(SModifier, "HatClosed5") == 0) then
        iDrumSoundL = iHatClosed5L
        iDrumSoundR = iHatClosed5R

    elseif (strcmp(SModifier, "HatClosed6") == 0) then
        iDrumSoundL = iHatClosed6L
        iDrumSoundR = iHatClosed6R

    elseif (strcmp(SModifier, "HatClosed7") == 0) then
        iDrumSoundL = iHatClosed7L
        iDrumSoundR = iHatClosed7R

    elseif (strcmp(SModifier, "HatOpen") == 0) then
        iDrumSoundL = iHatOpenL
        iDrumSoundR = iHatOpenR

    elseif (strcmp(SModifier, "Kick") == 0) then
        iDrumSoundL = iKickL
        iDrumSoundR = iKickR

    elseif (strcmp(SModifier, "Ride") == 0) then
        iDrumSoundL = iRideL
        iDrumSoundR = iRideR

    elseif (strcmp(SModifier, "Rimshot1") == 0) then
        iDrumSoundL = iRimshot1L
        iDrumSoundR = iRimshot1R

    elseif (strcmp(SModifier, "Rimshot2") == 0) then
        iDrumSoundL = iRimshot2L
        iDrumSoundR = iRimshot2R

    elseif (strcmp(SModifier, "Rimshot3") == 0) then
        iDrumSoundL = iRimshot3L
        iDrumSoundR = iRimshot3R

    elseif (strcmp(SModifier, "Rimshot4") == 0) then
        iDrumSoundL = iRimshot4L
        iDrumSoundR = iRimshot4R

    elseif (strcmp(SModifier, "Rimshot5") == 0) then
        iDrumSoundL = iRimshot5L
        iDrumSoundR = iRimshot5R

    elseif (strcmp(SModifier, "Rimshot6") == 0) then
        iDrumSoundL = iRimshot6L
        iDrumSoundR = iRimshot6R

    elseif (strcmp(SModifier, "Rimshot7") == 0) then
        iDrumSoundL = iRimshot7L
        iDrumSoundR = iRimshot7R

    elseif (strcmp(SModifier, "Rimshot8") == 0) then
        iDrumSoundL = iRimshot8L
        iDrumSoundR = iRimshot8R

    elseif (strcmp(SModifier, "Rimshot9") == 0) then
        iDrumSoundL = iRimshot9L
        iDrumSoundR = iRimshot9R

    elseif (strcmp(SModifier, "Snare1") == 0) then
        iDrumSoundL = iSnare1L
        iDrumSoundR = iSnare1R

    elseif (strcmp(SModifier, "Snare2") == 0) then
        iDrumSoundL = iSnare2L
        iDrumSoundR = iSnare2R

    elseif (strcmp(SModifier, "Snare3") == 0) then
        iDrumSoundL = iSnare3L
        iDrumSoundR = iSnare3R

    elseif (strcmp(SModifier, "Snare4") == 0) then
        iDrumSoundL = iSnare4L
        iDrumSoundR = iSnare4R

    elseif (strcmp(SModifier, "Snare5") == 0) then
        iDrumSoundL = iSnare5L
        iDrumSoundR = iSnare5R

    elseif (strcmp(SModifier, "Snare6") == 0) then
        iDrumSoundL = iSnare6L
        iDrumSoundR = iSnare6R

    elseif (strcmp(SModifier, "Snare7") == 0) then
        iDrumSoundL = iSnare7L
        iDrumSoundR = iSnare7R

    elseif (strcmp(SModifier, "Snare8") == 0) then
        iDrumSoundL = iSnare8L
        iDrumSoundR = iSnare8R

    elseif (strcmp(SModifier, "Snare9") == 0) then
        iDrumSoundL = iSnare9L
        iDrumSoundR = iSnare9R

    elseif (strcmp(SModifier, "Snare10") == 0) then
        iDrumSoundL = iSnare10L
        iDrumSoundR = iSnare10R

    elseif (strcmp(SModifier, "Snare11") == 0) then
        iDrumSoundL = iSnare11L
        iDrumSoundR = iSnare11R

    elseif (strcmp(SModifier, "Snare12") == 0) then
        iDrumSoundL = iSnare12L
        iDrumSoundR = iSnare12R

    elseif (strcmp(SModifier, "Snare13") == 0) then
        iDrumSoundL = iSnare13L
        iDrumSoundR = iSnare13R

    elseif (strcmp(SModifier, "Snare14") == 0) then
        iDrumSoundL = iSnare14L
        iDrumSoundR = iSnare14R

    elseif (strcmp(SModifier, "Tambourine") == 0) then
        iDrumSoundL = iTambourineL
        iDrumSoundR = iTambourineR

    elseif (strcmp(SModifier, "Tom1") == 0) then
        iDrumSoundL = iTom1L
        iDrumSoundR = iTom1R

    elseif (strcmp(SModifier, "Tom2") == 0) then
        iDrumSoundL = iTom2L
        iDrumSoundR = iTom2R

    elseif (strcmp(SModifier, "Tom3") == 0) then
        iDrumSoundL = iTom3L
        iDrumSoundR = iTom3R

    elseif (strcmp(SModifier, "Tom4") == 0) then
        iDrumSoundL = iTom4L
        iDrumSoundR = iTom4R

    elseif (strcmp(SModifier, "Tom5") == 0) then
        iDrumSoundL = iTom5L
        iDrumSoundR = iTom5R

    elseif (strcmp(SModifier, "Tom6") == 0) then
        iDrumSoundL = iTom6L
        iDrumSoundR = iTom6R

    elseif (strcmp(SModifier, "Tom7") == 0) then
        iDrumSoundL = iTom7L
        iDrumSoundR = iTom7R

    elseif (strcmp(SModifier, "Tom8") == 0) then
        iDrumSoundL = iTom8L
        iDrumSoundR = iTom8R

    elseif (strcmp(SModifier, "Tom9") == 0) then
        iDrumSoundL = iTom9L
        iDrumSoundR = iTom9R

    elseif (strcmp(SModifier, "Tom10") == 0) then
        iDrumSoundL = iTom10L
        iDrumSoundR = iTom10R

    elseif (strcmp(SModifier, "Tom11") == 0) then
        iDrumSoundL = iTom11L
        iDrumSoundR = iTom11R

    elseif (strcmp(SModifier, "Tom12") == 0) then
        iDrumSoundL = iTom12L
        iDrumSoundR = iTom12R

    elseif (strcmp(SModifier, "Tom13") == 0) then
        iDrumSoundL = iTom13L
        iDrumSoundR = iTom13R
    endif


    itablen   =         ftlen(iTom13L) ;length of the table
    idur      =         itablen / sr ;duration
    alinnL     loscil   .5, 1, iDrumSoundL, 1, 0
    alinnR     loscil   .5, 1, iDrumSoundR, 1, 0


    ; alinn1 grain 0.1, 1, 1, 1, 1, 1, iTom13L, 1, 1, 1
    ; alinn2 grain 0.1, 1, 1, 1, 1, 1, iTom13R, 1, 1, 1

    ; alinn1, alinn2  diskin SFullPath, p5

    kresL           rms (alinnL * p6)
    kresR           rms (alinnR * p6)

    alinnL          gain alinnL, kresL
    alinnR          gain alinnR, kresR

    ; if (kKillswitch == 0) then
        outleta "LinnDrumOutL", alinnL
        outleta "LinnDrumOutR", alinnR
    ; endif

endin

instr LinnDrumFader
    gkLinnDrumFader linseg p4, p3, p5
endin

instr LinnDrumPan
    gkLinnDrumPan linseg p4, p3, p5
endin

instr LinnDrumMixerChannel
    aLinnDrumL inleta "LinnDrumInL"
    aLinnDrumR inleta "LinnDrumInR"

    kLinnDrumFader = gkLinnDrumFader
    kLinnDrumPan = gkLinnDrumPan

    if kLinnDrumPan > 100 then
        kLinnDrumPan = 100
    elseif kLinnDrumPan < 0 then
        kLinnDrumPan = 0
    endif

    aLinnDrumL = (aLinnDrumL * ((100 - kLinnDrumPan) * 2 / 100)) * kLinnDrumFader
    aLinnDrumR = (aLinnDrumR * (kLinnDrumPan * 2 / 100)) * kLinnDrumFader

    outleta "LinnDrumOutL", aLinnDrumL
    outleta "LinnDrumOutR", aLinnDrumR
endin
