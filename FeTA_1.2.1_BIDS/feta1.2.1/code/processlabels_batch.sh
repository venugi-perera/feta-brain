#last change 4.2.2020
#
#Script for processing all labels of FetA dataset, version 4.2.2020
#
#Andras Jakab, 2020, University of Zurich
#andras.jakab@kispi.uzh.ch

export OMP_NUM_THREADS=11
export USE_SIMPLE_THREADED_LEVEL3=1

function doo {
echo "$1"
bash /media/m-ssd1/feta/Processlabels.sh /media/m-ssd1/feta/all/$1/ /media/m-ssd1/feta/all/$1/"$1"_processed.nii.gz
echo "completed $1"
}

function doo_manual_correct {
echo "$1"
bash /media/m-ssd1/feta/Processlabels_manual_corrected.sh /media/m-ssd1/feta/all/$1/ /media/m-ssd1/feta/all/$1/"$1"_processed.nii.gz
echo "completed $1"
}

function doodoo {
echo "$1"
bash /media/m-ssd1/feta/Processlabels.sh /media/m-ssd1/feta/all/$1/ /media/m-ssd1/feta/all/$1/"$1"_fetal_processed.nii.gz
echo "completed $1"
}

#run nr. 2. Post processing of manually corrected combined labels
doo_manual_correct 10085_PREOP &
#script truncated due to anonymization ....
