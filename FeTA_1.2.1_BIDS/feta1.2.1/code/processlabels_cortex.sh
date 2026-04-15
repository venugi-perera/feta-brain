#last change 12.12.2019
#process manual labels - fetal segmentation
# $1 is directory name
# $2 is the grayscale image

export PATH=$PATH:/usr/local/c3d/
export PATH=$PATH:/usr/local/c3d/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/c3d/

dir=$1

mkdir $dir/cortex 
rm $dir/cortex/*.* 
cd $1 

echo "1"

#renames according to label value
for file in $(ls *processed*-label*.nii.gz); do 
	echo $file; p=$(fslstats $file -M)
	fname=$(echo $p | awk '{print int($1+0.5)}')
	cp $file $dir/cortex/label_"$fname".nii.gz
done &> /dev/null

for file in $(ls *processed*_label*.nii.gz); do 
	echo $file; p=$(fslstats $file -M)
	fname=$(echo $p | awk '{print int($1+0.5)}')
	cp $file $dir/cortex/label_"$fname".nii.gz 
done &> /dev/null

for file in $(ls 7.nii.gz); do 
	echo $file; p=$(fslstats $file -M)
	fname=$(echo $p | awk '{print int($1+0.5)}')
	cp $file $dir/cortex/label_"$fname".nii.gz
done &> /dev/null

#creates background image (every voxel)
fslmaths $2 -thr 0.01 -bin -mul 4 $dir/cortex/label_background

echo "2"

function checkfile {
	if [ -f $1 ]; 
		then
		#schlafen!
		sleep 0
		else
		echo "Previous pre-processing step did not complete successfully. File $1 for case in $dir is missing. Exiting."
		#exit 1
	fi
}

checkfile $dir/cortex/label_1.nii.gz
checkfile $dir/cortex/label_2.nii.gz
checkfile $dir/cortex/label_3.nii.gz
checkfile $dir/cortex/label_5.nii.gz
checkfile $dir/cortex/label_6.nii.gz
checkfile $dir/cortex/label_7.nii.gz
checkfile $dir/cortex/label_8.nii.gz

#annotated cortex label
function label2 {
python /media/m-ssd1/feta/morphologicalcontourinterpolation.py $dir/cortex/label_2.nii.gz $dir/cortex/label_2_proc.nii.gz 
fslmaths $dir/cortex/label_2_proc.nii.gz -bin -s 1 -thr 0.5 -bin -mul 2 $dir/cortex/label_2_proc.nii.gz
}

#white matter label
function label3 {
python /media/m-ssd1/feta/morphologicalcontourinterpolation.py $dir/cortex/label_3.nii.gz $dir/cortex/label_3_proc.nii.gz 
fslmaths $dir/cortex/label_3_proc.nii.gz -bin -s 1 -thr 0.5 -bin -mul 3 $dir/cortex/label_3_proc.nii.gz
}

label2 
echo "3"
label3 
echo "4"

checkfile $dir/cortex/label_2_proc.nii.gz
checkfile $dir/cortex/label_3_proc.nii.gz

#creates rough cortex inclusion mask (large)
fslmaths $dir/cortex/label_2_proc.nii.gz -dilM -dilM -bin $dir/cortex/include_outside.nii.gz 
echo "5"
fslmaths $dir/cortex/label_3_proc.nii.gz -bin $dir/cortex/include_inside.nii.gz 
echo "6"
fslmaths $dir/cortex/include_outside.nii.gz -sub $dir/cortex/include_inside.nii.gz $dir/cortex/cortex_large_mask.nii.gz
echo "7"

#creates distance map based cortex from WM and then masks it
c3d $dir/cortex/label_3_proc.nii.gz -sdt $dir/cortex/distancemap.nii.gz
echo "8"
fslmaths $dir/cortex/distancemap.nii.gz -uthr 4 -bin $dir/cortex/cortex_4mm_band.nii.gz
fslmaths $dir/cortex/distancemap.nii.gz -uthr 2.2 -bin $dir/cortex/cortex_2mm_band.nii.gz
echo "9"
fslmaths $dir/cortex/cortex_2mm_band.nii.gz -mas $dir/cortex/cortex_large_mask.nii.gz $dir/cortex/cortex_2mm_band.nii.gz 
fslmaths $dir/cortex/cortex_4mm_band.nii.gz -mas $dir/cortex/cortex_large_mask.nii.gz $dir/cortex/cortex_4mm_band.nii.gz 
echo "10"

fslmaths $2 -mas $dir/cortex/cortex_4mm_band.nii.gz $dir/cortex/image_4mm.nii.gz
echo "11"
