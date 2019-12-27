#!/usr/bin/env bash
initMain(){
  project=$(projectName)
  version=$(version)
  organization=$(organization)
  functionNames=${getFunctionNames}
  printf "$(cat 'skeleton/bash/main.sk')" "$functionName" "$USER" "$(date)" "$(projectName)" "$(version)" "$functionDescription" "$spectedParameters" "$resultFields" "$functionName" "$stepName" "$functionName"
}
# mainLines(){
#
# }
# endMain(){
#
# }
# initReadme(){
#
# }
# readmeLines(){
#
# }
# endReadme(){
#
# }
log(){
  echo "[$(date)] $1" >> "$(folder)/log/$(date +%F).log"
}
folder(){
  project=$(projectName)
  version=$(version)
  folder=$(camelize "$project$version")
  echo "$folder"
}
projectName(){
  getProperty 'PROJECT_NAME' steps.dat
}
version(){
  getProperty 'VERSION' steps.dat
}
organization(){
  getProperty 'ORGANIZATION' steps.dat
}
labels(){
  getProperty 'LABELS' steps.dat
}
projectDescription(){
  getBetweenText 'PROJECT DESCRIPTION' 'END PROJECT DESCRIPTION' steps.dat | applyComments
}
steps(){
  getBetweenText 'STEPS' 'END STEPS' steps.dat | cleanBlanc | applyComments
}
filenamefrompath(){
  echo $1|rev|cut -d/ -f1|rev
}
getProperty(){
  sed -n -e "/^$1/p" $2 | applyComments | cleanBlanc | cut -d':' -f2 | tr -s '^[[:space:]]' | tr -s '[[:space:]]$'
}
getFunctionContent(){
  spectedParameters=$(getExpectedParametersComment "$1")
  resultFields=$(getResultFieldsComment "$1")
  stepName=$(getStepName "$1")
  functionName=$(getFunctionName "$1")
  functionDescription=$(getFunctionDescription "$1")
  printf "$(cat 'skeleton/bash/function.sk')" "$functionName" "$USER" "$(date)" "$(projectName)" "$(version)" "$functionDescription" "$spectedParameters" "$resultFields" "$functionName" "$stepName" "$functionName"
}
getFunctionNames(){
  echo $(steps) | cut -d':' -f1 | tr -s ' ' | sed -r 's/\s([[:alpha:]])/\U\1/g' | tr '\n' ' '
}
getFunctionName(){
  echo $1 | cut -d':' -f1 | tr -s ' ' | sed -r 's/\s([[:alpha:]])/\U\1/g'
}
getExpectedParametersComment(){
  echo $1 | cut -d':' -f2 | sed -r 's/\<([[:alpha:]])/\n\#\t\t\1/g'
}
getStepName(){
  echo $1 | cut -d':' -f1
}
getExpectedParameters(){
  echo $1| cut -d':' -f2 |sed -r 's/\<([[:alpha:]])/\n\1/g' | cleanBlanc
}
getResultFields(){
  echo $1 | cut -d':' -f3|sed -r 's/\<([[:alpha:]])/\n\1/g' | cleanBlanc
}
getResultFieldsComment(){
  echo $1 | cut -d':' -f3 | sed -r 's/\<([[:alpha:]])/\n\#\t\t\1/g'
}
getFunctionDescription(){
  echo $1 | cut -d':' -f4
}
applyComments(){
  sed -n -E -e '/^([[:space:]])*#/!p' | sed -e 's/#.*$/ /'
}
cleanBlanc(){
  sed -n -e '/^[[:space:]]*$/!p'
}
getBetweenText(){
  sed -n -E -e "/^$1/,/^$2/p" $3 | sed -e '1d'| sed -e '$d'
}
uppercase(){
  echo $1 |sed -r 's/([[:graph:]])/\U\1/g'
}
lowercase(){
  echo $1 |sed -r 's/([[:graph:]])/\l\1/g'
}
capitalize(){
  echo $1 |sed -r 's/\<([[:graph:]])/\U\1/g'
}
camelize(){
  echo "$1" |tr -s ' ' | sed -r 's/\s([[:graph:]])/\U\1/g'
}
snakeize(){
  echo $1 |tr -s ' ' | sed -r 's/\s([[:graph:]])/_\l\1/g'
}
midleize(){
  echo $1 |tr -s ' ' | sed -r 's/\s([[:graph:]])/-\l\1/g'
}
uncamelize(){
  echo $1 |sed -r 's/([[:graph:]])/ \l\1/g'
}
unsnakeize(){
  echo $1 |sed -r 's/_([[:graph:]])/ \1/g'
}
unmidleize(){
  echo $1 |sed -r 's/-([[:graph:]])/ \1/g'
}
