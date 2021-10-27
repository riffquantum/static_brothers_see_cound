bypassRoute "Murk", "Mixer"
stereoRoute "MurkMixerChannel", "Mixer"

alwayson "MurkInput"
alwayson "MurkMixerChannel"

gkMurkEqBass init 1
gkMurkEqMid init 1
gkMurkEqHigh init 1
gkMurkFader init 1
gkMurkPan init 50

gkMurkDryAmmount init 0
gkMurkWetAmmount init 1

; giMurkVST vstinit  "../../VST/murk/murk.vst", 1

; vstinfo giMurkVST

/*
VST work
http://csound.1045644.n5.nabble.com/Csnd-building-csound-with-vst4cs-on-OSX-td5754160.html
https://michaelgogins.tumblr.com/csound_extended
http://csound.1045644.n5.nabble.com/Csound-VST-download-updated-td1121691.html
https://github.com/gogins/csound-vst3-opcodes
http://csound.1045644.n5.nabble.com/Csnd-dev-ANNOUNCEMENT-CsoundVST-and-the-vst4cs-Opcodes-available-again-on-Linux-td5762592.html
https://www.dropbox.com/s/fx7uhzj5gqzm31g/csound-vst-1.1.1-Linux.tar.gz?dl=0
https://michaelgogins.tumblr.com/csound_extended


*/

;  Shome getEnvVar "HOME"

instr MurkInput
  aMurkInL inleta "InL"
  aMurkInR inleta "InR"

  aMurkOutWetL, aMurkOutWetR, aMurkOutDryL, aMurkOutDryR bypassSwitch aMurkInL, aMurkInR, gkMurkDryAmmount, gkMurkWetAmmount, "Murk"

  outleta "OutWetL", aMurkOutWetL
  outleta "OutWetR", aMurkOutWetR

  outleta "OutDryL", aMurkOutDryL
  outleta "OutDryR", aMurkOutDryR
endin


instr Murk
  aMurkInL inleta "InL"
  aMurkInR inleta "InR"

  aMurkOutL = aMurkInL
  aMurkOutR = aMurkInR

  

  ; aMurkOutL *= kDeclick
  ; aMurkOutR *= kDeclick

  outleta "OutL", aMurkOutL
  outleta "OutR", aMurkOutR
endin

instr MurkBassKnob
  gkMurkEqBass linseg p4, p3, p5
endin

instr MurkMidKnob
  gkMurkEqMid linseg p4, p3, p5
endin

instr MurkHighKnob
  gkMurkEqHigh linseg p4, p3, p5
endin

instr MurkFader
  gkMurkFader linseg p4, p3, p5
endin

instr MurkPan
  gkMurkPan linseg p4, p3, p5
endin

instr MurkMixerChannel
  aMurkL inleta "InL"
  aMurkR inleta "InR"

  aMurkL, aMurkR mixerChannel aMurkL, aMurkR, gkMurkFader, gkMurkPan, gkMurkEqBass, gkMurkEqMid, gkMurkEqHigh

  outleta "OutL", aMurkL
  outleta "OutR", aMurkR
endin
