#! /bin/bash
set -e
function run_all_test() {
    cd /apollo/bin
    file_count=0
    for file in `ls`
    do 
        echo -e "\033[43;35m >>>>>>>> testint file: $file \033[0m"
        ./$file
        file_count=$file_count+1
    done
    echo "Test $file_count files Over"
}

run_all_test
