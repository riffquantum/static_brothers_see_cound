<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr 1
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.4
iSus = 0.6
iRel = 0.7
iCutoff = 5000
iRes = .4
kEnv madsr iAtt, iDec, iSus, iRel 
aVco vco2 iAmp, iFreq
aLp moogladder aVco, iCutoff*kEnv, iRes
out aLp*kEnv
endin

instr 2
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.1
iSus = 0.6
iRel = 1.7
iCutoff = 5000
iRes = .4
kEnv madsr iAtt, iDec, iSus, iRel 
aVco vco2 iAmp, iFreq
aLp moogladder aVco, iCutoff*kEnv, iRes
out aLp*kEnv
endin


</CsInstruments>
<CsScore>
i1 0 1 100 1
i2 2 1 100 1
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
