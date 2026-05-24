#! /bin/bash
echo "going to sleep for 3 seconds"
sleep 3 &
echo "$!"
wait $!
echo "slept 3 seconds"