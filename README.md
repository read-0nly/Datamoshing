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
- This is where the magic happens - by splicing two videos in the sea of P-frames between I-frames, you apply the motion and included pixel data of video 2 to video 1. This causes video 2 to "push through" video 1's last good P-frame, causing that delicious crunchy mosh~

Is this the best/only way?
-  God no
-  This is madness
-  What is here was dangerous and repulsive to us. This message is a warning about danger. 
-  Everyone develops their own methods. A lot of us use premade glitching tools, you might be here hoping to do the same
-  I hope I end up making something polished enough to meet that need
-  but at the core of moshing and glitch art as a whole is always the same philosophy
-  break shit, and make it look cool
-  some of us hex-edit video files
-  some of us generate raw mpeg bytestreams from code
-  some of us just bang our heads at command lines until it encodes then kiss the sweet earth and bless being done.
-  all of us have some technique, refined in time through expermentation and play
-  you, too, maybe
-  so grab a hammer
-  and break shit

Manifesto aside, the barrier to entry is...  so low man. So low. You can probably make something cool just by opening a bitmap in notepad and deleting  lines at random or entering trash - I've had some success with that method too. But the more you experiment, the more you learn. About media file structures, sure, but about the truth of all this noise at the end of the day - it's all 0s and 1s. It's nothing without context - but it's also just waiting, begging to be reinterpreted through another. 

Throwaway starter project - get Irfanview. Save an image as RAW, keep track of the image dimensions and pixel depth, you'll need it. Open the RAW file in audacity as RAW audio. Whatever version you want, really. Export it as RAW, pick a different encoding. Open in Irfanview.

Do that again, this time apply echo and export with the same import encoding

Do that again but apply a low-pass, or high-pass filter

Some of these audio manipulations translate somehow very well onto image manipulation, looking exactly how they sound. Wah wah is an odd one, I could never get it to look good.

Here's something you can make by Audacity manipulation of a RAW image
![image](https://user-images.githubusercontent.com/33932119/222355729-f6aed081-2eb9-45a3-8a5a-7e8b50b94c98.png)

I imported the image as Unsigned 8-bit, applied an Echo audio effect on the whole stream, re-balanced to only the right channel if I remember correctly, then exported as U-law. I like the graininess of it - I think it would make a cool blanket or carpet. If ever I get the loom project off the ground I might give it a shot
