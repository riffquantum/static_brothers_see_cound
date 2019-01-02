# run every interval in seconds
timeinterval=1;

# Main files and folders
csoundfolder="./"

echo "Watching CSD files for changes"
echo "Folder=\"$csoundfolder\""

#create array of all csds
csd_file_list=()
while IFS= read -d $'\0' -r file ; do
 csd_file_list=("${csd_file_list[@]}" "$file")
done < <(find . -name "*.csd" -print0)

#create array of all orcs
orc_file_list=()
while IFS= read -d $'\0' -r file ; do
 orc_file_list=("${orc_file_list[@]}" "$file")
done < <(find . -name "*.orc" -print0)

last_rendered_file=${csd_file_list[0]}

#document all those modified times in an array whose indices correspond with those of the csd file list.
csd_modified_times=()
index=0
for file in "${csd_file_list[@]}"; do

    formatted_filename=`echo $file | tr -d . | tr -d /`

    modified_time=`stat -f %Sm $file | md5`;

    csd_modified_times[$index]=$modified_time

    index=$((index+1))
done

#document all those modified times in an array whose indices correspond with those of the orc file list.
orc_modified_times=()
index=0
for file in "${orc_file_list[@]}"; do

    formatted_filename=`echo $file | tr -d . | tr -d /`

    modified_time=`stat -f %Sm $file | md5`;

    orc_modified_times[$index]=$modified_time

    index=$((index+1))
done

#loop forever
while [[ true ]]; do

    #loop through the csd file list and check for new update times
    index=0
    for file in "${csd_file_list[@]}"; do

        formatted_filename=`echo $file | tr -d . | tr -d /`

        previous_modified_time=${csd_modified_times[$index]}
        modified_time=`stat -f %Sm $file | md5`;

        if [[ $previous_modified_time != $modified_time ]] ; then
            printf "Rendering Preview of ${file}...";
            csound $file -W -o previewer/preview.wav;
            #record the most recently rendered file
            last_rendered_file=$file;
            printf "Preview Rendered for ${file}. ";

            printf "Refreshing Browser Preview";
            touch previewer/index.html

            #update old record
            csd_modified_times[$index]=$modified_time
        fi

        index=$((index+1))
    done

    #loop through the orc file list and check for new update times
    index=0
    for file in "${orc_file_list[@]}"; do

        formatted_filename=`echo $file | tr -d . | tr -d /`

        previous_modified_time=${orc_modified_times[$index]}
        modified_time=`stat -f %Sm $file | md5`;

        if [[ $previous_modified_time != $modified_time ]] ; then
            #render the most recently rendered CSD
            printf "Rendering Preview of ${last_rendered_file}...";
            csound $last_rendered_file -W -o previewer/preview.wav;
            printf "Preview Rendered for ${last_rendered_file}. ";

            printf "Refreshing Browser Preview";
            touch previewer/index.html

            #update old record
            orc_modified_times[$index]=$modified_time
        fi

        index=$((index+1))
    done

    sleep $timeinterval;
done
