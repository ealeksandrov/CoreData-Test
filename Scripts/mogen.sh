#!/bin/sh
#  mogen.sh
#
#  Created by Jean-Denis Muys on 24/02/11.
#  Modified by Ryan Rounkles on 15/5/11 to use correct model version and to account for spaces in file paths
#  Modified by Vyacheslav Artemev on 7/12/11 to use separate folders for machine and human
#  Modified by Evgeny Aleksandrov on 13/04/13 to use ARC

#  baseClass = DOManagedObject
#  --base-class $baseClass

/usr/local/bin/mogenerator --model "${INPUT_FILE_PATH}" --machine-dir "${PROJECT_DIR}/Classes/CoreDataModels/Private/" --human-dir "${PROJECT_DIR}/Classes/CoreDataModels/" --template-var arc=true

${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"

echo "Mogen.sh is done"
