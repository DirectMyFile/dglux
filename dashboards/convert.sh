#!/usr/bin/env bash
files=${*}

if [ -z ${files} ]
then
  files=$(find . -type f -name '*.dg5')
fi

echo $files | while read src
do
  dest=$(echo ${src} | awk '{gsub(".dg5", ".yaml"); print}')
  echo "${src} => ${dest}"
  ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))' < ${src} | tee ${dest} > /dev/null
done
