iex (iwr  https://raw.githubusercontent.com/read-0nly/PSRepo/master/Utility/Vt100-FormattingGlyphs.ps1 -UseBasicParsing).content

function doAsJobSync{
	param($command, $message)
	$python = "cd $PSScriptRoot;"+$command
	$job = Start-Job -Name PShellJob -ScriptBlock ([Scriptblock]::Create($python))
	clear
	write-host ($VT100.Fore["Magenta+"]+$message+$VT100.ResetAll+$VT100.ResetAll)
	while($job.state  -eq  "Running"){
		write-host ($VT100.Fore["Green+"]+"."+$VT100.ResetAll+$VT100.ResetAll) -nonewline
		start-sleep -milliseconds 1000
	}
	$last=($job | receive-job)
	$last | out-file (""+(get-date).ticks+".log")
	$job | stop-job
	$job | remove-job
	write-host ( $last|select -last 1)
}
$sliced = @()

function  jellymosh(){
	rm postmosh.mp4
	rm result.mp4
	read-host "Start Processing?"
	doAsJobSync @"
 ."C:\Program Files\Python310\python.exe" C:\Users\r00t\source\repos\VideoIntersplicer\VideoIntersplicer\VideoIntersplicer.py
"@ "Getting Peaks" 
	$sliced = (. "$PSScriptRoot\arbislice.ps1" -projectfile "C:\Users\r00t\Videos\datamosh\Helen\helen.mp4")
	if($sliced -eq "Failed"){
		write-host "Failure to splice,returnung"
		return
	}
	read-host "done splicing"
	doAsJobSync (@"
ffedit -i "
"@+$sliced[2]+ @"
" -f mv -s C:\Users\r00t\Videos\datamosh\scripts\frameskip.js -o postmosh.mpg
"@) "Applying  Script"

	read-host "done applying  frameskip"
	doAsJobSync @"
	ffmpeg -i postmosh.mpg -i "C:\Users\r00t\Downloads\y2mate.com - Oliver Malcolm Helen.mp3" result.mp4
"@ "Cleaning Video"
	echo ([char]7)
	start ./result.mp4
}
jellymosh
