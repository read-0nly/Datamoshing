param(
	$projectFile="Project.mp4",
	$fps=15
)

if(-not(test-path  C:\\Users\\r00t\\Videos\\datamosh\\scripts\\iList.ps1)){
	write-host "No I-frame  indices found"
	return "Failed"
}
. C:\\Users\\r00t\\Videos\\datamosh\\scripts\\iList.ps1
$projectName = $projectFile.split("\")[-1].split(".")[0]
$SliceFiles =  @()
$NoPFile = $projectName+"-NoP.mpg"
ffgac -fflags +genpts -i $projectFile -qscale:v 0 -map 0:v -vcodec mpeg2video -f rawvideo -filter:v fps=30 raw.mpg
ffgac -fflags +genpts -i raw.mpg -qscale:v 0 -map 0:v -vcodec mpeg2video -f rawvideo -filter:v fps=30 $NoPFile #($projectName+"-recombined.mpg")
#ffgac -i ($projectName+"-recombined.mpg") -an -mpv_flags +nopimb+forcemv -qscale:v 0 -g 100 -vcodec mpeg2video -f rawvideo -y $NoPFile
for($i=0;$i -lt <#/>2<##>$SliceFrames.Length-1<##>;$i++){
	
	$trimLine = ('"trim=start_frame='+$SliceFrames[$i]+':end_frame='+$SliceFrames[$i+1]+', setpts=PTS-STARTPTS"')
	if($i -eq  $SliceFrames.Length-2){
		$trimLine = ('"trim=start_frame='+$SliceFrames[$i]+', setpts=PTS-STARTPTS"')
	}
	$segmentName  =  $projectName+"-"+$i+"-raw.mpg"
	$segmentEncodedName  =  $projectName+"-"+$i+"-Encoded.mpg"
	
	write-host "ffmpeg -i $NoPFile -vf $trimLine -vcodec copy -an $segmentEncodedName" -foregroundcolor green
	ffgac -i $NoPFile -vf $trimLine -mpv_flags +nopimb+forcemv -qscale:v 0 -g 100000 -vcodec mpeg2video -f rawvideo -an $segmentEncodedName
	#ffgac -i $segmentName -an -mpv_flags +nopimb+forcemv -qscale:v 0 -g 100000 -r 1  -vcodec mpeg2video -f rawvideo -y $segmentEncodedName
	
	$SliceFiles+=$segmentEncodedName
}
rm list.txt
new-item list.txt
(Get-Content list.txt) | Set-Content list.txt -Encoding ASCII
$sliceFiles |  %{
	echo ("file '"+$_+"'") | out-file list.txt -Encoding ASCII -append
}
ffgac -fflags +genpts -safe 0 -f concat -r 1 -i list.txt -c copy -f rawvideo ($projectName+"-Stitched.mpg")
read-host "Stich  complete"
return ($projectName+"-Stitched.mpg")
