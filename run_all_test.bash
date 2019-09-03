#! /bin/bash
set -e
function run_all_test() {
    cd /apollo/bin
    declare -i file_count
    file_count=0
    skip_file="file_test"
    for file in `ls`
    do 
        echo -e "\033[43;35m >>>>>>>> testint file: $file \033[0m"
        if [ $file = $skip_file ]; then
            echo 'skip file_test.....'
        else
            ./$file
            file_count=$file_count+1
        fi
    done
    echo "Test $file_count files Over"
}

run_all_test
