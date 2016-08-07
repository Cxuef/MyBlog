---
title: FFmpeg 基本命令
comments: true
categories: devtools
tags: [ffmpeg]
date: 2016-03-01 21:14:21
---
* 【ffmpeg命令】无损剪辑视频
利用ffmpeg可以快速的剪辑视频，保留你想要的有用信息。嘿嘿，格式如下：
ffmpeg -i input.mp4 -ss [START_TIME] -t [TOTAL_TIME] -acodec copy -vcodec copy output.mp4
eirot@ubuntu64 :~/MyDev/video$ ffmpeg -i Caminandes.mp4 -ss 00:00:21 -t 00:00:20 -acodec copy -vcodec copy  -strict -2 haha.mp4

* 【ffmpeg命令】MP4转换为gif并且裁剪视频大小
eirot@ubuntu64:~/MyDev/video$ ffmpeg -i haha.mp4 -pix_fmt rgb24 -vf crop=iw/1.15:ih:0:0  Mygif.gif

* 【ffmpeg命令】转换视频格式、分辨率及宽高比
ffmpeg -i input.mp4 -vcodec mjpeg -s 320x240 -aspect 4:3 output.avi

* 【用图片制作视频】
ffmpeg -f image2 -i ImageNamePrefix%04d.png -r [frame rate] output.mp4


![ffmpeng logo](/PostImage/ffmpeg_logo.png)
<!--more-->

ffmpeg helper command:
```bash
eirot@ubuntu64:~/MyDev/video$ ffmpeg -h
ffmpeg version 2.8.3 Copyright (c) 2000-2015 the FFmpeg developers
  built with gcc 4.8 (Ubuntu 4.8.4-2ubuntu1~14.04)
  configuration: --enable-shared --disable-static --prefix=/usr/local/ffmpeg
  WARNING: library configuration mismatch
  swscale     configuration: --enable-shared
  swresample  configuration: --enable-shared
  libavutil      54. 31.100 / 54. 31.100
  libavcodec     56. 60.100 / 56. 60.100
  libavformat    56. 40.101 / 56. 40.101
  libavdevice    56.  4.100 / 56.  4.100
  libavfilter     5. 40.101 /  5. 40.101
  libswscale      3.  1.101 /  3.  1.101
  libswresample   1.  2.101 /  1.  2.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Getting help:
    -h      -- print basic options
    -h long -- print more options
    -h full -- print all options (including all format and codec specific options, very long)
    See man ffmpeg for detailed description of the options.

Print help / information / capabilities:
-L                  show license
-h topic            show help
-? topic            show help
-help topic         show help
--help topic        show help
-version            show version
-buildconf          show build configuration
-formats            show available formats
-devices            show available devices
-codecs             show available codecs
-decoders           show available decoders
-encoders           show available encoders
-bsfs               show available bit stream filters
-protocols          show available protocols
-filters            show available filters
-pix_fmts           show available pixel formats
-layouts            show standard channel layouts
-sample_fmts        show available audio sample formats
-colors             show available color names
-sources device     list sources of the input device
-sinks device       list sinks of the output device
-hwaccels           show available HW acceleration methods

Global options (affect whole program instead of just one file:
-loglevel loglevel  set logging level
-v loglevel         set logging level
-report             generate a report
-max_alloc bytes    set maximum size of a single allocated block
-y                  overwrite output files
-n                  never overwrite output files
-ignore_unknown     Ignore unknown stream types
-stats              print progress report during encoding
-max_error_rate ratio of errors (0.0: no errors, 1.0: 100% error  maximum error rate
-bits_per_raw_sample number  set the number of bits per raw sample
-vol volume         change audio volume (256=normal)

Per-file main options:
-f fmt              force format
-c codec            codec name
-codec codec        codec name
-pre preset         preset name
-map_metadata outfile[,metadata]:infile[,metadata]  set metadata information of outfile from infile
-t duration         record or transcode "duration" seconds of audio/video
-to time_stop       record or transcode stop time
-fs limit_size      set the limit file size in bytes
-ss time_off        set the start time offset
-sseof time_off     set the start time offset relative to EOF
-seek_timestamp     enable/disable seeking by timestamp with -ss
-timestamp time     set the recording timestamp ('now' to set the current time)
-metadata string=string  add metadata
-target type        specify target file type ("vcd", "svcd", "dvd", "dv" or "dv50" with optional prefixes "pal-", "ntsc-" or "film-")
-apad               audio pad
-frames number      set the number of frames to output
-filter filter_graph  set stream filtergraph
-filter_script filename  read stream filtergraph description from a file
-reinit_filter      reinit filtergraph on input parameter changes
-discard            discard
-disposition        disposition

Video options:
-vframes number     set the number of video frames to output
-r rate             set frame rate (Hz value, fraction or abbreviation)
-s size             set frame size (WxH or abbreviation)
-aspect aspect      set aspect ratio (4:3, 16:9 or 1.3333, 1.7777)
-bits_per_raw_sample number  set the number of bits per raw sample
-vn                 disable video
-vcodec codec       force video codec ('copy' to copy stream)
-timecode hh:mm:ss[:;.]ff  set initial TimeCode value.
-pass n             select the pass number (1 to 3)
-vf filter_graph    set video filters
-ab bitrate         audio bitrate (please use -b:a)
-b bitrate          video bitrate (please use -b:v)
-dn                 disable data

Audio options:
-aframes number     set the number of audio frames to output
-aq quality         set audio quality (codec-specific)
-ar rate            set audio sampling rate (in Hz)
-ac channels        set number of audio channels
-an                 disable audio
-acodec codec       force audio codec ('copy' to copy stream)
-vol volume         change audio volume (256=normal)
-af filter_graph    set audio filters

Subtitle options:
-s size             set frame size (WxH or abbreviation)
-sn                 disable subtitle
-scodec codec       force subtitle codec ('copy' to copy stream)
-stag fourcc/tag    force subtitle tag/fourcc
-fix_sub_duration   fix subtitles duration
-canvas_size size   set canvas size (WxH or abbreviation)
-spre preset        set the subtitle options to the indicated preset

```

查看ffmpeg支持的格式
```bash
eirot@ubuntu64:~$ ffmpeg -formats
ffmpeg version 2.8.3 Copyright (c) 2000-2015 the FFmpeg developers
  built with gcc 4.8 (Ubuntu 4.8.4-2ubuntu1~14.04)
  configuration: --enable-shared --disable-static --prefix=/usr/local/ffmpeg
  WARNING: library configuration mismatch
  swscale     configuration: --enable-shared
  swresample  configuration: --enable-shared
  libavutil      54. 31.100 / 54. 31.100
  libavcodec     56. 60.100 / 56. 60.100
  libavformat    56. 40.101 / 56. 40.101
  libavdevice    56.  4.100 / 56.  4.100
  libavfilter     5. 40.101 /  5. 40.101
  libswscale      3.  1.101 /  3.  1.101
  libswresample   1.  2.101 /  1.  2.100
File formats:
 D. = Demuxing supported
 .E = Muxing supported
 --
  E 3g2             3GP2 (3GPP2 file format)
  E 3gp             3GP (3GPP file format)
 D  4xm             4X Technologies
  E a64             a64 - video for Commodore 64
 D  aa              Audible AA format files
 D  aac             raw ADTS AAC (Advanced Audio Coding)
 DE ac3             raw AC-3
 D  act             ACT Voice file format
 D  adf             Artworx Data Format
 D  adp             ADP
  E adts            ADTS AAC (Advanced Audio Coding)
 DE adx             CRI ADX
 D  aea             MD STUDIO audio
 D  afc             AFC
 DE aiff            Audio IFF
 DE alaw            PCM A-law
 D  alias_pix       Alias/Wavefront PIX image
 DE amr             3GPP AMR
 D  anm             Deluxe Paint Animation
 D  apc             CRYO APC
 D  ape             Monkey's Audio
 DE apng            Animated Portable Network Graphics
 D  aqtitle         AQTitle subtitles
 DE asf             ASF (Advanced / Active Streaming Format)
 D  asf_o           ASF (Advanced / Active Streaming Format)
  E asf_stream      ASF (Advanced / Active Streaming Format)
 DE ass             SSA (SubStation Alpha) subtitle
 DE ast             AST (Audio Stream)
 DE au              Sun AU
 DE avi             AVI (Audio Video Interleaved)
  E avm2            SWF (ShockWave Flash) (AVM2)
 D  avr             AVR (Audio Visual Research)
 D  avs             AVS
 D  bethsoftvid     Bethesda Softworks VID
 D  bfi             Brute Force & Ignorance
 D  bfstm           BFSTM (Binary Cafe Stream)
 D  bin             Binary text
 D  bink            Bink
 DE bit             G.729 BIT file format
 D  bmp_pipe        piped bmp sequence
 D  bmv             Discworld II BMV
 D  boa             Black Ops Audio
 D  brender_pix     BRender PIX image
 D  brstm           BRSTM (Binary Revolution Stream)
 D  c93             Interplay C93
 DE caf             Apple CAF (Core Audio Format)
 DE cavsvideo       raw Chinese AVS (Audio Video Standard) video
 D  cdg             CD Graphics
 D  cdxl            Commodore CDXL video
 D  cine            Phantom Cine
 D  concat          Virtual concatenation script
  E crc             CRC testing
  E dash            DASH Muxer
 DE data            raw data
 DE daud            D-Cinema audio
 D  dds_pipe        piped dds sequence
 D  dfa             Chronomaster DFA
 DE dirac           raw Dirac
 DE dnxhd           raw DNxHD (SMPTE VC-3)
 D  dpx_pipe        piped dpx sequence
 D  dsf             DSD Stream File (DSF)
 D  dsicin          Delphine Software International CIN
 D  dss             Digital Speech Standard (DSS)
 DE dts             raw DTS
 D  dtshd           raw DTS-HD
 DE dv              DV (Digital Video)
 D  dv1394          DV1394 A/V grab
 D  dvbsub          raw dvbsub
  E dvd             MPEG-2 PS (DVD VOB)
 D  dxa             DXA
 D  ea              Electronic Arts Multimedia
 D  ea_cdata        Electronic Arts cdata
 DE eac3            raw E-AC-3
 D  epaf            Ensoniq Paris Audio File
 D  exr_pipe        piped exr sequence
 DE f32be           PCM 32-bit floating-point big-endian
 DE f32le           PCM 32-bit floating-point little-endian
  E f4v             F4V Adobe Flash Video
 DE f64be           PCM 64-bit floating-point big-endian
 DE f64le           PCM 64-bit floating-point little-endian
 DE fbdev           Linux framebuffer
 DE ffm             FFM (FFserver live feed)
 DE ffmetadata      FFmpeg metadata in text
 D  film_cpk        Sega FILM / CPK
 DE filmstrip       Adobe Filmstrip
 DE flac            raw FLAC
 D  flic            FLI/FLC/FLX animation
 DE flv             FLV (Flash Video)
  E framecrc        framecrc testing
  E framemd5        Per-frame MD5 testing
 D  frm             Megalux Frame
 DE g722            raw G.722
 DE g723_1          raw G.723.1
 D  g729            G.729 raw format demuxer
 DE gif             GIF Animation
 D  gsm             raw GSM
 DE gxf             GXF (General eXchange Format)
 DE h261            raw H.261
 DE h263            raw H.263
 DE h264            raw H.264 video
  E hds             HDS Muxer
 DE hevc            raw HEVC video
  E hls             Apple HTTP Live Streaming
 D  hls,applehttp   Apple HTTP Live Streaming
 D  hnm             Cryo HNM v4
 DE ico             Microsoft Windows ICO
 D  idcin           id Cinematic
 D  idf             iCE Draw File
 D  iff             IFF (Interchange File Format)
 DE ilbc            iLBC storage
 DE image2          image2 sequence
 DE image2pipe      piped image2 sequence
 D  ingenient       raw Ingenient MJPEG
 D  ipmovie         Interplay MVE
  E ipod            iPod H.264 MP4 (MPEG-4 Part 14)
 DE ircam           Berkeley/IRCAM/CARL Sound Format
  E ismv            ISMV/ISMA (Smooth Streaming)
 D  iss             Funcom ISS
 D  iv8             IndigoVision 8000 video
 DE ivf             On2 IVF
 D  j2k_pipe        piped j2k sequence
 DE jacosub         JACOsub subtitle format
 D  jpeg_pipe       piped jpeg sequence
 D  jpegls_pipe     piped jpegls sequence
 D  jv              Bitmap Brothers JV
 DE latm            LOAS/LATM
 D  lavfi           Libavfilter virtual input device
 D  live_flv        live RTMP FLV (Flash Video)
 D  lmlm4           raw lmlm4
 D  loas            LOAS AudioSyncStream
 DE lrc             LRC lyrics
 D  lvf             LVF
 D  lxf             VR native stream (LXF)
 DE m4v             raw MPEG-4 video
  E matroska        Matroska
 D  matroska,webm   Matroska / WebM
  E md5             MD5 testing
 D  mgsts           Metal Gear Solid: The Twin Snakes
 DE microdvd        MicroDVD subtitle format
 DE mjpeg           raw MJPEG video
  E mkvtimestamp_v2 extract pts as timecode v2 format, as defined by mkvtoolnix
 DE mlp             raw MLP
 D  mlv             Magic Lantern Video (MLV)
 D  mm              American Laser Games MM
 DE mmf             Yamaha SMAF
  E mov             QuickTime / MOV
 D  mov,mp4,m4a,3gp,3g2,mj2 QuickTime / MOV
  E mp2             MP2 (MPEG audio layer 2)
 DE mp3             MP3 (MPEG audio layer 3)
  E mp4             MP4 (MPEG-4 Part 14)
 D  mpc             Musepack
 D  mpc8            Musepack SV8
 DE mpeg            MPEG-1 Systems / MPEG program stream
  E mpeg1video      raw MPEG-1 video
  E mpeg2video      raw MPEG-2 video
 DE mpegts          MPEG-TS (MPEG-2 Transport Stream)
 D  mpegtsraw       raw MPEG-TS (MPEG-2 Transport Stream)
 D  mpegvideo       raw MPEG video
 DE mpjpeg          MIME multipart JPEG
 D  mpl2            MPL2 subtitles
 D  mpsub           MPlayer subtitles
 D  msnwctcp        MSN TCP Webcam stream
 D  mtv             MTV
 DE mulaw           PCM mu-law
 D  mv              Silicon Graphics Movie
 D  mvi             Motion Pixels MVI
 DE mxf             MXF (Material eXchange Format)
  E mxf_d10         MXF (Material eXchange Format) D-10 Mapping
  E mxf_opatom      MXF (Material eXchange Format) Operational Pattern Atom
 D  mxg             MxPEG clip
 D  nc              NC camera feed
 D  nistsphere      NIST SPeech HEader REsources
 D  nsv             Nullsoft Streaming Video
  E null            raw null video
 DE nut             NUT
 D  nuv             NuppelVideo
  E oga             Ogg Audio
 DE ogg             Ogg
 DE oma             Sony OpenMG audio
  E opus            Ogg Opus
 DE oss             OSS (Open Sound System) playback
 D  paf             Amazing Studio Packed Animation File
 D  pictor_pipe     piped pictor sequence
 D  pjs             PJS (Phoenix Japanimation Society) subtitles
 D  pmp             Playstation Portable PMP
 D  png_pipe        piped png sequence
  E psp             PSP MP4 (MPEG-4 Part 14)
 D  psxstr          Sony Playstation STR
 D  pva             TechnoTrend PVA
 D  pvf             PVF (Portable Voice Format)
 D  qcp             QCP
 D  qdraw_pipe      piped qdraw sequence
 D  r3d             REDCODE R3D
 DE rawvideo        raw video
 D  realtext        RealText subtitle format
 D  redspark        RedSpark
 D  rl2             RL2
 DE rm              RealMedia
 DE roq             raw id RoQ
 D  rpl             RPL / ARMovie
 D  rsd             GameCube RSD
 DE rso             Lego Mindstorms RSO
 DE rtp             RTP output
  E rtp_mpegts      RTP/mpegts output format
 DE rtsp            RTSP output
 DE s16be           PCM signed 16-bit big-endian
 DE s16le           PCM signed 16-bit little-endian
 DE s24be           PCM signed 24-bit big-endian
 DE s24le           PCM signed 24-bit little-endian
 DE s32be           PCM signed 32-bit big-endian
 DE s32le           PCM signed 32-bit little-endian
 DE s8              PCM signed 8-bit
 D  sami            SAMI subtitle format
 DE sap             SAP output
 D  sbg             SBaGen binaural beats script
 D  sdp             SDP
 D  sdr2            SDR2
  E segment         segment
 D  sgi_pipe        piped sgi sequence
 D  shn             raw Shorten
 D  siff            Beam Software SIFF
  E singlejpeg      JPEG single image
 D  sln             Asterisk raw pcm
 DE smjpeg          Loki SDL MJPEG
 D  smk             Smacker
  E smoothstreaming Smooth Streaming Muxer
 D  smush           LucasArts Smush
 D  sol             Sierra SOL
 DE sox             SoX native
 DE spdif           IEC 61937 (used on S/PDIF - IEC958)
  E spx             Ogg Speex
 DE srt             SubRip subtitle
 D  stl             Spruce subtitle format
  E stream_segment,ssegment streaming segment muxer
 D  subviewer       SubViewer subtitle format
 D  subviewer1      SubViewer v1 subtitle format
 D  sunrast_pipe    piped sunrast sequence
 D  sup             raw HDMV Presentation Graphic Stream subtitles
  E svcd            MPEG-2 PS (SVCD)
 DE swf             SWF (ShockWave Flash)
 D  tak             raw TAK
 D  tedcaptions     TED Talks captions
  E tee             Multiple muxer tee
 D  thp             THP
 D  tiertexseq      Tiertex Limited SEQ
 D  tiff_pipe       piped tiff sequence
 D  tmv             8088flex TMV
 DE truehd          raw TrueHD
 D  tta             TTA (True Audio)
 D  tty             Tele-typewriter
 D  txd             Renderware TeXture Dictionary
 DE u16be           PCM unsigned 16-bit big-endian
 DE u16le           PCM unsigned 16-bit little-endian
 DE u24be           PCM unsigned 24-bit big-endian
 DE u24le           PCM unsigned 24-bit little-endian
 DE u32be           PCM unsigned 32-bit big-endian
 DE u32le           PCM unsigned 32-bit little-endian
 DE u8              PCM unsigned 8-bit
  E uncodedframecrc uncoded framecrc testing
  E v4l2            Video4Linux2 output device
 DE vc1             raw VC-1 video
 DE vc1test         VC-1 test bitstream
  E vcd             MPEG-1 Systems / MPEG program stream (VCD)
 D  video4linux2,v4l2 Video4Linux2 device grab
 D  vivo            Vivo
 D  vmd             Sierra VMD
  E vob             MPEG-2 PS (VOB)
 D  vobsub          VobSub subtitle format
 DE voc             Creative Voice
 D  vplayer         VPlayer subtitles
 D  vqf             Nippon Telegraph and Telephone Corporation (NTT) TwinVQ
 DE w64             Sony Wave64
 DE wav             WAV / WAVE (Waveform Audio)
 D  wc3movie        Wing Commander III movie
  E webm            WebM
  E webm_chunk      WebM Chunk Muxer
 DE webm_dash_manifest WebM DASH Manifest
  E webp            WebP
 D  webp_pipe       piped webp sequence
 DE webvtt          WebVTT subtitle
 D  wsaud           Westwood Studios audio
 D  wsvqa           Westwood Studios VQA
 DE wtv             Windows Television (WTV)
 DE wv              raw WavPack
 D  x11grab         X11 screen capture, using XCB
 D  xa              Maxis XA
 D  xbin            eXtended BINary text (XBIN)
 D  xmv             Microsoft XMV
 D  xwma            Microsoft xWMA
 D  yop             Psygnosis YOP
 DE yuv4mpegpipe    YUV4MPEG pipe
```

![ffmpeg架构图](/PostImage/ffmpeg_structure_decode.jpg)
