#last change 4.2.2020
#
#
#bash /media/m-ssd1/feta/processlabels_cs5.sh /media/m-ssd1/feta/all/$1/ /media/m-ssd1/feta/all/$1/"$1"_processed.nii.gz
#
#Requirements: C3D, FSL, python, ITK
#
#Andras Jakab, 2020, University of Zurich
#andras.jakab@kispi.uzh.ch

function logo { 
	echo " "
	echo "----------------------------------------------------------------------------------------------"
	echo "|     Processing of manually annotated labels, FetA2020 dataset   Step 2. Manual correction   |"
	echo "|                                                                                             |"
	echo "|                                           Andras Jakab,  University of Zurich               |"
	echo "----------------------------------------------------------------------------------------------"
	echo " "
}

function Usage { 
    logo
    echo "Requirements: Requirements: C3D, FSL, python, ITK" 
    echo " " 
    echo "-----------------------------------------------------------------------------------------------------------"                             
    echo "Usage:"
    echo " "  
    echo "Processlabels_manual_corrected.sh (1) (2)"
    echo " "  
    echo "(1): input directory where annotated labels are found, full path "  
    echo " "  
    echo " "  
    echo "Usage notes: "  
    echo " "  
    echo "More documentation: andras.jakab@kispi.uzh.ch"  
    echo "-----------------------------------------------------------------------------------------------------------" 
    exit 1
}

[ "$1" = "" ] && Usage
[ "$1" = "-help" ] && Usage
[ "$1" = "-h" ] && Usage
[ "$1" = "--help" ] && Usage

#c3d install directory, change when migrating system
export PATH=$PATH:/usr/local/c3d/
export PATH=$PATH:/usr/local/c3d/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/c3d/

dir=$1
cd $1 

#Important that labels are saved accordingly, and the naming contains -label as shown below
#check if manual correction has been performed

if [ -f "$1/combined_corrected.nii.gz" ]; 
	then
	echo "Manually corrected file found in $1"
	mv $1/combined.nii.gz $1/combined_old.nii.gz
	mv $1/combined_corrected.nii.gz $1/combined.nii.gz
		#creates separate label files
		echo "Separating label maps of $1"
		label=1; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=2; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=3; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=4; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=5; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=6; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=7; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		label=8; fslmaths combined.nii.gz -thr $label -uthr $label label_$label.nii.gz &
		wait
		echo "Separating labels of $1 done"
	else
	echo "No manual corrections found in $1. Leaving files as they were."
	exit 1
fi

exit 1

