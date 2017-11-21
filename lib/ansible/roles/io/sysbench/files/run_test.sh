#!/bin/bash

if [ -z "$(which sysbench 2>/dev/null)" ] ; then
    echo "Please install sysbench firstly !"
    exit 0
fi
<<<<<<< HEAD

CUR_DIR=$(cd `dirname $0`; pwd)
mkdir -p ${CUR_DIR}/result
IOTEST_DIR="${CUR_DIR}/result"
echo "Start fio test......"

FILE_SIZE="20G"

TEST_MODE=("rndrw" "rndwr" "rndrd" "seqrd" "seqrewr") 
TIME=300

#seqwr seqrewr seqrd rndrd rndwr rndrw
=======
IP=`ifconfig eth0|sed -n 2p|awk  '{ print $2 }'|tr -d 'addr:'`;
CUR_DIR=$(cd `dirname $0`; pwd)
if [ -d "${CUR_DIR}/result" ]; then
  rm -f ${CUR_DIR}/result
fi
mkdir -p ${CUR_DIR}/result
IOTEST_DIR="${CUR_DIR}/result"
echo "Start sysbench test......"
FILE_SIZE="4G"
TEST_MODE=("rndrw" "rndwr" "rndrd" "seqrd" "seqrewr" "seqwr") 
TIME=60
WAIT_CLEANUP=65
>>>>>>> upstream/master
pushd ${IOTEST_DIR} > /dev/null

for var in "${TEST_MODE[@]}"
do 
	 sysbench fileio --file-total-size=${FILE_SIZE} prepare	
<<<<<<< HEAD
	 nohup sysbench fileio --file-total-size=${FILE_SIZE} --file-test-mode=$var --time=${TIME} --max-requests=0 run >$var.result  2>&1 &
	 sleep ${TIME}

=======
	 nohup sysbench fileio --file-total-size=${FILE_SIZE} --file-test-mode=$var --time=${TIME} --max-requests=0 run >>result_${IP}  2>&1 &
	 sleep ${WAIT_CLEANUP}
>>>>>>> upstream/master
done
sysbench fileio --file-total-size=${FILE_SIZE} cleanup
popd > /dev/null

