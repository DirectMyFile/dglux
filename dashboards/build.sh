#!/usr/bin/env bash
files=${*}

if [ -z ${files} ]
then
  files=$(find . -type f -name '*.yaml')
fi

echo $files | while read src
do
  dest=$(echo ${src} | awk '{gsub(".yaml", ".dg5"); print}')
  echo "${src} => ${dest}"
  ruby -ryaml -rjson -e 'puts JSON.stringify(YAML.parse(STDIN.read))' < ${src} | tee ${dest} > /dev/null
done
