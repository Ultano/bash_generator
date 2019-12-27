#!/usr/bin/env bash
source ./sources/assets.sh
 # getBetweenText 'STEPS' 'END STEPS' steps.dat
# steps
# echo projectName: $(projectName)
# echo version: $(version)
# echo organization: $(organization)
# echo labels: $(labels)
# echo '#####'
# echo projectDescription:
# echo $(projectDescription)
# echo '#####'
# echo steps: $(steps)
# echo $(steps)
project=$(projectName)
version=$(version)
folder=$(folder)
echo "Creating folder $folder ..."
mkdir -p "$folder"
# initMain
# initReadme
configfile="$folder/config.dat"
echo "Creating file $configfile ..."
touch "$configfile"
logfolder="$folder/log"
echo "Creating folder $logfolder ..."
mkdir -p "$logfolder"
logfile="$logfolder/$(date +%F).log"
log "Create Project $project $version"
sourcesfolder="$folder/sources"
echo "Creating folder $sourcesfolder ..."
mkdir -p "$sourcesfolder"
log "Create folder $sourcesfolder"
echo "project: $project"
log "Project: $project"
echo "version: $version"
log "version: $version"
echo "folder: $folder"
echo "config file: $configfile"
echo "log folder: $logfolder"

steps | while read step; do
  functionname=$(getFunctionName "$step")
  filename="$functionname.sh"
  sourcespath="$sourcesfolder/$filename"
  echo "Creating file $sourcespath"
  getFunctionContent "$step" > $sourcespath
  # mainLines "$step" >>
  log "Create $sourcespath"
done
# endMain
# endReadme
