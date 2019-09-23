#!/usr/bin/env bash
SCRIPTS_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

export LD_LIBRARY_PATH=/usr/local/fast-rtps/lib:$LD_LIBRARY_PATH

export CYBER_PATH="{SCRIPTS_PATH}/../../src/apollo/cyber"

export CYBER_DOMAIN_ID=80
export CYBER_IP=127.0.0.1

export GLOG_log_dir=/apollo/data/log
export GLOG_alsologtostderr=0
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0

export cyber_trans_perf=0
export cyber_sched_perf=0

# for DEBUG log
#export GLOG_minloglevel=-1
#export GLOG_v=4
