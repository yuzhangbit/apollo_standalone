#! /bin/bash
set -ev

SCRIPTS_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}


function run_all_test() {
    cd /apollo/bin
    ls
    source "${SCRIPTS_PATH}/scripts/cyber_setup.sh"
    declare -i file_count
    file_count=0
    declare -ar skip_file=("file_test"
                           "cyber_example_listener"
                           "cyber_example_service"
                           "cyber_example_talker"
                           "mainboard"
                           "record_file_test"
                           "record_reader_test"
                           "record_viewer_test"
                           "tcp_echo_client"
                           "tcp_echo_server"
                           "udp_echo_client"
                           "udp_echo_server"
                           )
    for file in `ls`
    do 
        echo -e "\033[43;35m >>>>>>>> testing file: $file \033[0m" 
        if [ $(contains "${skip_file[@]}" $file) == "y" ]; then
            echo 'skip file_test.....'
        else
            ./$file
            file_count=$file_count+1
        fi
    done
    echo "Test $file_count files Over"
}

function build_example() {
    echo "script path is $SCRIPTS_PATH"
    cd $SCRIPTS_PATH
    cd ../src/example_project
    rm -rf build
    mkdir build
    cd build
    cmake ..
    make
    echo "example build successfully!"
}

run_all_test
build_example
