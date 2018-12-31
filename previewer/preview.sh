# run every interval in seconds
timeinterval=1;

# Main files and folders
csoundfolder="./"

echo "Watching CSD files for changes"
echo "Folder=\"$csoundfolder\""

#document the file's last update time
chksum2=`stat -f %Sm $1 | md5`;

#store update time again for future comparison
chksum1=$chksum2

#The commented out code below is some in-progress work to make this script monitor all CSD files in the repo and not just the specified file. The thing holding me back at the moment is the lack of associative arrays in bash 3. I could upgrade bash or alternatively figure out how to dynamically name variables.

# #create array of all csds
# file_list=()
# while IFS= read -d $'\0' -r file ; do
#  file_list=("${file_list[@]}" "$file")
# done < <(find . -name "*.csd" -print0)

# echo "${file_list[@]}"


# #document all those modified times
# modified_times=()
# modified_times2=()
# index=0
# for file in "${file_list[@]}"; do



#     formatted_filename=`echo $file | tr -d . | tr -d /`


#     chksum2=`stat -f %Sm $file | md5`;

#     declare "modified_times_${formatted_filename}"=$chksum2
#     declare "modified_times2_${formatted_filename}"=$chksum2

#     echo "$modified_times_${formatted_filename}"
#     index+=1
# done

# echo "${modified_times[@]}"


#loop forever
while [[ true ]]; do
    #check file's last update time
    chksum2=`stat -f %Sm $1 | md5`;

    #compare against old record
    if [[ $chksum1 != $chksum2 ]] ; then
        printf "Rendering Preview...";
        csound $1 -W -o previewer/preview.wav
        printf "Preview Rendered. ";

        printf "Refreshing Browser Preview";
        touch previewer/index.html

        #update old record
        chksum1=$chksum2
    fi

    sleep $timeinterval;
done
