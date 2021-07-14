#!/bin/sh

ROOT_PATH=`pwd`
VENDOR_NAME="vendors"
PYTHON="${ROOT_PATH}/${VENDOR_NAME}/bin/python3"

install_python3_venv() {
    echo "Create venv jupyter"
    OS_TARGET=`uname -s`
	if [ "${OS_TARGET}" == "Linux" ]; then
		# sudo apt update
        sudo apt install -y python3-pip python3-dev
	fi

    cd ${ROOT_PATH}
    python3 -m venv ${VENDOR_NAME}
}

install_jupyter() {
    echo "Install jupyter"
    cd ${ROOT_PATH}
	${PYTHON} -m pip install jupyter
}

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

install_nltk_data() {
	echo "Load nltk data"
	${PYTHON} -m nltk.downloader -d "${ROOT_PATH}/${VENDOR_NAME}/nltk_data" stopwords
	${PYTHON} -m nltk.downloader -d "${ROOT_PATH}/${VENDOR_NAME}/nltk_data" punkt
}

cleanup() {
    echo "Cleanup temp"
	cd ${ROOT_PATH}
	rm -rf ${ROOT_PATH}/build
	rm -rf ${ROOT_PATH}/dist
	rm -rf ${ROOT_PATH}/UNKNOWN.egg-info
}

install_python3_venv
source ${VENDOR_NAME}/bin/activate
install_jupyter
install_setup
install_nltk_data
cleanup