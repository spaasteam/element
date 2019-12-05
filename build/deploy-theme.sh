#! /bin/sh
mkdir temp_web
git config --global user.name "barretem"
git config --global user.email "1178310248@qq.com"

if [ "$ROT_TOKEN" = "" ]; then
  echo "Bye~"
  exit 0
fi
# spaas-theme-chalk SPAAS_THEME_CHALK_VERSION
# release
if [ "$SPAAS_THEME_CHALK_VERSION" ]; then
  # build site
  npm run build:file
  npm run deploy:build
  cd temp_web
  git clone --depth 1 -b gh-pages --single-branch https://$ROT_TOKEN@github.com/spaasteam/element.git && cd element
  # build sub folder
  echo $SPAAS_THEME_CHALK_VERSION

  FOLDER=$SPAAS_THEME_CHALK_VERSION
  SUB_FOLDER=${FOLDER%.*}
  mkdir $SUB_FOLDER
  rm -rf *.js *.css *.map static
  rm -rf $SUB_FOLDER/**
  cp -rf ../../examples/element-ui/** .
  cp -rf ../../examples/element-ui/** $SUB_FOLDER/
  git add -A .
  git commit -m "feat: SPaaS主题版本已经更新至${SPAAS_THEME_CHALK_VERSION}"
  git push origin gh-pages
  cd ../..

  echo "DONE, Bye~"
  exit 0

elif [ "$DR_THEME_CHALK_VERSION" ]
then
  # build site
  npm run build:file
  npm run deploy:build
  cd temp_web
  git clone --depth 1 -b gh-pages --single-branch https://$ROT_TOKEN@github.com/spaasteam/element.git && cd element
  # build sub folder
  echo $DR_THEME_CHALK_VERSION

  FOLDER=$DR_THEME_CHALK_VERSION
  SUB_FOLDER=${FOLDER%.*}
  mkdir -p "dr/${SUB_FOLDER}"
  cd ./dr
  rm -rf *.js *.css *.map static
  rm -rf $SUB_FOLDER/**
  cp -rf ../../../examples/element-ui/** .
  cp -rf ../../../examples/element-ui/** $SUB_FOLDER/
  git add -A .
  git commit -m "feat: DR主题版本已经更新至${DR_THEME_CHALK_VERSION}"
  git push origin gh-pages
  cd ../../..

  echo "DONE, Bye~"
  exit 0
fi
