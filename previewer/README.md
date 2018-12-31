## Csound Previewer

This is a little preview application I wrote that will render your CSD as you save and display it with a nice waveform timeline in a web browser.

From the main directory run `./previewer/preview.sh {path to file}`. That is a shell script that watches the specified file and renders it to the previewer directory whenever you save. You may need to update the permissions on that script to get it to run.

You can then view the index.html file in a browser window to play, pause, and scrub through the waveform. If you run it through a server then auto refresh will work too. The page will refresh every time the soundfile is rendered. I recommend using pow (http://pow.cx/) along with this nifty trick to get it to serve static html: https://www.codeography.com/2014/01/17/using-pow-for-static-sites.html.

Hopefully being able to skip around in playback and visualize your composition will make writing in csound a little more comfortable.
