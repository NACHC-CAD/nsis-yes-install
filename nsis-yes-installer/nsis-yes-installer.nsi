# ---
#
# This script creates the installer for the _YES Eclipse environment.  
# Documentation for the _YES Eclipse environment is available at:
# https://nachc-cad.github.io/fhir-to-omop/pages/navbar/how-tos/developer-how-tos/install-eclipse/InstallEclipse.html
#
# For this script to work you will need to install the EnVar plug in.  
# https://nsis.sourceforge.io/EnVar_plug-in 
#
# Documentation for the EnVar API is here:
# https://github.com/GsNSIS/EnVar
#
# Instructions for plugin install
# From: https://nsis.sourceforge.io/How_can_I_install_a_plugin 
#
#   After downloading and unpacking a plugin one needs to accept the license agreement (residing in the "license.txt" file if applicable). 
#   Then the ".dll" files must be put into the "NSIS\Plugins[\platform]" subfolder and the ".nsh" file into the "NSIS\Include" subfolder.
#   NSIS v2 only supports ANSI plug-ins and they are stored in "NSIS\Plugins". 
#   NSIS v3 supports multiple targets and plugins are stored in subfolders under "NSIS\Plugins\".
#
# WriteEnvStr.nsh was downloaded from the following url (put the .nsh file in <NSIS>/Include folder):
# https://github.com/rasa/nsislib/blob/master/WriteEnvStr.nsh
# 
# ---

# includes
!include WriteEnvStr.nsh


#
# defines
#

# env variables
!define JAVA_HOME "C:\_YES\tools\java\jdk-11.0.11"
!define JAVA_VERSION "C:\_YES\tools\java\jdk-11.0.11\bin"

# path additions/modifications
!define JAVA_PATH "C:\_YES\tools\java\jdk-11.0.11\bin;"
!define GIT_PATH "C:\_YES\tools\git\Git-2.27.0\bin;"
!define MVN_PATH "C:\_YES\tools\mvn\apache-maven-3.6.3\bin;"


# definitions
Outfile "YesEclipseEnvironmentInstaller.exe"
InstallDir "C:\_YES"

Page Directory
Page InstFiles

#
# Main section
#

Section

    #
    # create environment variables
    #

	# JAVA_HOME
    DetailPrint ""
    DetailPrint "Updating JAVA_HOME Environment Variable (this takes a few seconds)..."
	Push JAVA_HOME
	Push '${JAVA_HOME}'
	Call WriteEnvStr
	
	# JAVA_VERSION
    DetailPrint ""
    DetailPrint "Updating JAVA_VERSION Environment Variable (this takes a few seconds)..."
	Push JAVA_VERSION
	Push '${JAVA_VERSION}'
	Call WriteEnvStr

	#
	# modifications to path env variable
	#

    # remove ${JAVA_PATH} from path
    DetailPrint ""
    DetailPrint "Removing existing instance of $JAVA_PATH from Path"
    EnVar::DeleteValue "Path" "$JAVA_PATH"
    Pop $0
    DetailPrint "EnVar::Check returned=|$0| (should be 0)"  
    
    # add our ${JAVA_PATH} to the path env variable
    DetailPrint ""
    DetailPrint "Adding our ${JAVA_VERSION} to the path env variable..."
    EnVar::AddValue "Path" "${JAVA_VERSION}"
    Pop $0
    DetailPrint "EnVar::Check returned=|$0| (should be 0)"  
    


#	# Create the variable.  
#    DetailPrint ""
#    DetailPrint "..."
#    EnVar::SetHKCU
#    EnVar::AddValue "DELETE_ME" "C:\existing_path_1;C:\existing_path_2;C:\existing_path_3;"
#
#    # check to see if the variable was created
#    EnVar::Check "DELETE_ME" "NULL"
#    Pop $0
#    DetailPrint "EnVar::Check returned=|$0| (should be 0)"  
#
#    # add a new string to the existing variable
#    DetailPrint ""
#    DetailPrint "Appending new path to DELETE_ME..."
#    EnVar::AddValue "DELETE_ME" "D:\NEW_PATH;"
#    Pop $0
#    DetailPrint "EnVar::Check returned=|$0| (should be 0)"  
#
#    # remove a string from the existing variable
#    DetailPrint ""
#    DetailPrint "Deleting C:\existing_path_3"
#    EnVar::DeleteValue "DELETE_ME" "C:\existing_path_3;"
#    Pop $0
#    DetailPrint "EnVar::Check returned=|$0| (should be 0)"  
#
#    #
#    # done
#    #
#    
#    DetailPrint ""
#    DetailPrint "Done."
#
#    # copy files
#    DetailPrint ""
#    DetailPrint "Copying files to $InstDir..."
#    DetailPrint ""
#    SetOutPath "$InstDir\resources"
#    File /a /r "resources\"
#

SectionEnd