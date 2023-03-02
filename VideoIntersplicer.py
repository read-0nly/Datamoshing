# Beat tracking example
import librosa
import  numpy  as np
import datetime

fps=30
# 1. Get the file path to an included audio example
print('Loading Audio')
filename = ".\\glitchtrack.wav"
y, sr = librosa.load(filename)
duration = librosa.get_duration(y=y)
print("File duration(s): ", str(datetime.timedelta(seconds=duration)))
onset_env = librosa.onset.onset_strength(y=y, sr=sr,aggregate=np.median,fmin=0,fmax=8000, n_mels=5)
onset_frames = librosa.onset.onset_detect(onset_envelope=onset_env, sr=sr)
onset_peak = [onset_env[index] for index in onset_frames]
onset_pairs = None

for index in onset_frames:
	thisPair = np.array([[(int(round(librosa.frames_to_time([index], sr=sr)[0]*fps))),int(onset_env[index])]],dtype=object)
	afterPair = np.array([[(int(round(librosa.frames_to_time([index], sr=sr)[0]*fps)))+1,-int(onset_env[index])]],dtype=object)
	if(onset_pairs is None):
		onset_pairs=thisPair
		onset_pairs = np.append(onset_pairs,afterPair, 0)
	else:
		found = False
		foundidx=-1;
		findCounter = 0;
		for pair in onset_pairs:
			firstInt = pair[0]
			secondInt = thisPair[0]
			if((firstInt==secondInt).any()):
				found=True
				onset_pairs[findCounter][1]=int(onset_env[index])
				foundidx=findCounter
				break
			findCounter+=1
		if(foundidx==-1):
			onset_pairs = np.append(onset_pairs,thisPair, 0)
			
		found = False
		foundidx=-1;
		findCounter = 0;
		for pair in onset_pairs:
			firstInt = pair[0]
			secondInt = afterPair[0]
			if((firstInt==secondInt).any()):
				found=True
				onset_pairs[findCounter][1]=-int(onset_env[index])
				foundidx=findCounter
				break
			findCounter+=1
		if(foundidx==-1):
			onset_pairs = np.append(onset_pairs,afterPair, 0)


#peak_times = librosa.frames_to_time(onset_frames, sr=sr)
# Print peaks list to console
#print('Peaks count: '+str(len(peak_times)))
#print('Peaks detected at: '+str([(round(n*fps)) for n in peak_times]))


js   = "var vectors = ["
for pair in onset_pairs:
	js+="["+str(pair[0])+","+str(pair[1])+"],"
	
js+='''[-1,-1]]
var n_frames = 0;

function glitch_frame(frame) {
	let fwd_mvs = frame["mv"]["forward"];
	if (!fwd_mvs) {
		n_frames++;
		return;
	}
	let foundIdx=-1;
	let foundLastIdx=-1;
	for(let findIdx=0;findIdx<vectors.length;findIdx++){
		if(vectors[findIdx][0]==n_frames)	{
			foundIdx=findIdx	
			break;
		}
	}
    if(foundIdx>-1){
		for ( let i = 0; i < fwd_mvs.length; i++ ) {
			let row = fwd_mvs[i];
			for ( let j = 0; j < row.length; j++ ) {
				let mv = row[j];
				try {
					let factor = vectors[foundIdx][1]
					
					mv[0]-=(factor+10)*((j-(row.length/2))/(row.length/2))
					mv[1]-=(factor+10)*((i-(fwd_mvs.length/2))/(fwd_mvs.length/2))
					if(mv[0]<-128){mv[0]=-128}
					if(mv[0]>128){mv[0]=128}
					if(mv[1]<-128){mv[1]=-128}
					if(mv[1]>128){mv[1]=128}
				} catch {
				
				}
			}
		}
	}

	n_frames++;
}'''

f = open("C:\\Users\\r00t\\Videos\\datamosh\\scripts\\frameskip.js", "w")
f.write(js)
f.close()



print('Loading Audio')
filename = "stabletrack\\drums2.wav"
y, sr = librosa.load(filename)
duration = librosa.get_duration(y=y)
print("File duration(s): ", str(datetime.timedelta(seconds=duration)))
onset_env=None
onset_env = librosa.onset.onset_strength(y=y, sr=sr,aggregate=np.median,fmin=0,fmax=1000, n_mels=5)
onset_frames=None
onset_frames = librosa.onset.onset_detect(onset_envelope=onset_env, sr=sr)
onset_times=None
onset_times=librosa.frames_to_time(onset_frames);
iIdx =  "$SliceFrames = @(0"
addComma=False
i=0;
for time in onset_times:
	iIdx+=","
	iIdx+=str((round(time*fps)) )	
	i+=1

iIdx+=")";

f = open("C:\\Users\\r00t\\Videos\\datamosh\\scripts\\iList.ps1", "w")
f.write(iIdx)
f.close()