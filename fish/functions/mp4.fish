function update-tag --description 'Convert an MOV file to MP4 using ffmpeg'
  ffmpeg -i $1 -vcodec h264 -acodec mp2 $1
end
