#!/usr/bin/env bash
# trap 'echo "# $BASH_COMMAND"' DEBUG

#check if any old trace-script is running on netem 
process_id=$(ps aux | grep netem_start_trace)
to_kill=$(echo $process_id | awk '{print $2}')
if [[ !  -z  $to_kill  ]];then
        kill -9 $to_kill
        echo '-- Killed old trace script---'
fi

process_id=$(ps aux | grep netem_start_trace)
to_kill=$(echo $process_id | awk '{print $2}')
if [[ !  -z  $to_kill  ]];then
        kill -9 $to_kill
        echo '-- Killed old trace script---'
fi
