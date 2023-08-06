# m8-wav-license-generator

Itemize all .wav files in a project, with licensing info


## Description

This is probably a misguided idea, but I'm giving it a quick shot.  Since I've started bundling and sharing recent [M8] projects, I've made a point of including proper attribution and licensing (and maybe provenance) info for all the bundled samples.

Currently, this is a _very simple_ proof-of-concept script:  Run `itemize.zb` with a bunch of .wav files as arguments, and it tries to figure out where they came from  and outputs a markdown snippet listing a summary of each file's attribution, licensing, and provenance.

Right now it only supports https://freesound.org, and requires a freesound.org API key.

[M8]: https://dirtywave.com/products/m8-tracker
