#last change 4.2.2020
#
#Replacing label numbers, version 4.2.2020
#
#Andras Jakab, 2020, University of Zurich
#andras.jakab@kispi.uzh.ch

export OMP_NUM_THREADS=11
export USE_SIMPLE_THREADED_LEVEL3=1
basedir=/media/fsl/m-ssd1/feta/feta_1.2/derivatives

function doo {
echo "$1"
c3d $basedir/$1/anat/"$1"_T2w-SR_annotation_combined.nii.gz -replace 4 0 5 4 6 5 7 6 8 7 -o $basedir/$1/anat/"$1"_T2w-SR_annotation_combined.nii.gz
c3d $basedir/$1/anat/"$1"_T2w-SR_annotation_label5.nii.gz -replace 5 4 -o $basedir/$1/anat/"$1"_T2w-SR_annotation_label4.nii.gz
c3d $basedir/$1/anat/"$1"_T2w-SR_annotation_label6.nii.gz -replace 6 5 -o $basedir/$1/anat/"$1"_T2w-SR_annotation_label5.nii.gz
c3d $basedir/$1/anat/"$1"_T2w-SR_annotation_label7.nii.gz -replace 7 6 -o $basedir/$1/anat/"$1"_T2w-SR_annotation_label6.nii.gz
c3d $basedir/$1/anat/"$1"_T2w-SR_annotation_label8.nii.gz -replace 8 7 -o $basedir/$1/anat/"$1"_T2w-SR_annotation_label7.nii.gz
rm $basedir/$1/anat/"$1"_T2w-SR_annotation_label8.nii.gz
echo "completed $1"
}

#run nr. 1. 
doo sub-feta01 &
doo sub-feta02 &
doo sub-feta03 &
doo sub-feta04 &
doo sub-feta05 &
doo sub-feta06 &
doo sub-feta07 &
doo sub-feta08 &
wait
doo sub-feta09  &
doo sub-feta10  &
doo sub-feta11  &
doo sub-feta12 &
doo sub-feta13 &
doo sub-feta14 &
doo sub-feta15 &
doo sub-feta16 &
wait
doo sub-feta17 &
doo sub-feta18 &
doo sub-feta19 &
doo sub-feta20 &
doo sub-feta21 &
doo sub-feta22 &
doo sub-feta23 &
doo sub-feta24 &
wait
doo sub-feta25 &
doo sub-feta26 &
doo sub-feta27 &
doo sub-feta28 &
doo sub-feta29 &
doo sub-feta30 &
doo sub-feta31 &
doo sub-feta32 &
wait
doo sub-feta33 &
doo sub-feta34 &
doo sub-feta35 &
doo sub-feta36 &
doo sub-feta37 &
doo sub-feta38 &
doo sub-feta39 &
doo sub-feta40 &
exit 1


