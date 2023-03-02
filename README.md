# Datamoshing
Repo of my moshing resources


Good resources
- [FFGlitch](https://ffglitch.org/) - this is a fucking godsend Ramiro I love you
- [Some good examples of working with it from @tiberiuiancu](https://github.com/tiberiuiancu/datamoshing)
- [Librosa:](https://librosa.org/) Python library, great for audio analysis
- [Spleeter:](https://github.com/deezer/spleeter) For splitting tracks into components for analysis
- [Audacity:](https://www.audacityteam.org/) For processing audio pre-analysis
- [Avidemux 2.6.5](https://sourceforge.net/projects/avidemux/files/avidemux/2.6.5/) Every guide has their own preference, but this with libxvid works well as prep for ffglitch, save as mp4. if you pass it through ffglitch you can strip all the I-frames in the commandline  so I often just rinse it through without checking settings.

Basic concepts
- mpeg has 3 frame types, I-frame, P-frame, and B-frame
- I do not understand B-frames, so I just make sure I have none
- They seem to be some sort of backwards P frame? Anyways, don't include them in encoding
- I-frames are basically full images, all pixel data, think a jpg
- P-frames contain some pixel data, but mostly contain motion data where possible. It'll try to generate the next frame by applying motion data to the result of previous motion data applied to the previous I-frame. Why? It's cheaper, data-side.
- This is where the magic happens - by splicing two videos in the sea of P-frames between I-frames, you apply the motion and included pixel data of video 2 to video 1. This causes video 2 to "push through" video 1's last good P-frame, causing that delicious crunchyu mosh.
