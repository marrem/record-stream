# record-stream

A script to record from a http stream for a certain duration.
The script will record, (remux aac into m4a (mp4 container, with aac stream)), tag and split into smaller parts.

I want to be able to play programs I listen to "on the radio" (http streams) on my mobile devices, my car audio etc, at work etc.

So I need to be able to record them. This is easily done with a single 'curl' command. Yet this will produce a file without 
tags. I you have many of them in a folder, it will be difficult to browse. Furthermore recording aac streams will produce
raw aac files. These can't be tagged or played on many players. That's why the script tags and if necessary muxes the stream.


## dependencies

ffmpeg
curl



