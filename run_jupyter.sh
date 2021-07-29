#!/bin/sh

ROOT_PATH=`pwd`
VENDOR_NAME="vendors"
PYTHON="${ROOT_PATH}/${VENDOR_NAME}/bin/python3"

install_requirements() {
	echo "Install pip"
	cd ${ROOT_PATH}
	${PYTHON} -m pip install -r requirements.txt
}

install_setup() {
	echo "Install setup"
	cd ${ROOT_PATH}
	${PYTHON} setup.py install
}

connect_to_server() {
    echo "Connect to server (install jupyter) from local"
    echo "Copy token from server: Example http://127.0.0.1:8888/?token=fa4622bd3d980141a02e5d3ffeea2abd579ea9bef4cd8830 to login from local"
    ssh -L 8888:localhost:8888 ubuntu@192.168.3.188
}

cleanup() {
    echo "Cleanup temp"
	cd ${ROOT_PATH}
	rm -rf ${ROOT_PATH}/build
	rm -rf ${ROOT_PATH}/dist
	rm -rf ${ROOT_PATH}/UNKNOWN.egg-info
}

source ${VENDOR_NAME}/bin/activate
install_setup
install_requirements
cleanup
# connect_to_server
jupyter notebook
