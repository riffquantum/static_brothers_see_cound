# run every interval in seconds
timeinterval=1;

# Main files and folders
csoundfolder="./"

echo "Watching CSD files for changes"
echo "Folder=\"$csoundfolder\""

#create array of all csds
file_list=()
while IFS= read -d $'\0' -r file ; do
 file_list=("${file_list[@]}" "$file")
done < <(find . -name "*.csd" -print0)



#document all those modified times in an array whose indices correspond with those of the file list.
modified_times=()
index=0
for file in "${file_list[@]}"; do

    formatted_filename=`echo $file | tr -d . | tr -d /`

    modified_time=`stat -f %Sm $file | md5`;

    modified_times[$index]=$modified_time

    index=$((index+1))
done

#loop forever
while [[ true ]]; do

    #loop through the file list and check for
    index=0
    for file in "${file_list[@]}"; do

        formatted_filename=`echo $file | tr -d . | tr -d /`

        previous_modified_time=${modified_times[$index]}
        modified_time=`stat -f %Sm $file | md5`;

        if [[ $previous_modified_time != $modified_time ]] ; then
            printf "Rendering Preview of ${file}...";
            csound $file -W -o previewer/preview.wav
            printf "Preview Rendered. ";

            printf "Refreshing Browser Preview";
            touch previewer/index.html

            #update old record
            modified_times[$index]=$modified_time
        fi

        index=$((index+1))
    done

    sleep $timeinterval;
done
