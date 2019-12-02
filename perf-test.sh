#!/bin/sh
# Import 300 Posts
echo -n '
* Import 300 posts ... '

cd hexo-theme-unit-test/source/_posts/
git clone https://github.com/SukkaLab/hexo-many-posts.git --depth=1 --quiet
rm -rf .git
cd ../..

echo -n 'Done!'

# Run Clean up
echo -n '
* Run clean up ... '

rm -rf source/assets

echo -n 'Done!
'

npm uninstall hexo --save
npm install git+https://github.com/hexojs/hexo.git

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false
../bin/yq w -i _config.yml theme yilla

echo '-------------------------------------'
echo '* Test performance ... '
echo '-------------------------------------'
echo '               Test A'
echo ' Hexo master branch'
echo '-------------------------------------'

echo -n 'Round 1: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"

echo -n 'Round 2: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"


npm uninstall hexo --save
npm install git+https://github.com/sukkaw/hexo.git#feat_enhance_cache

echo '-------------------------------------'
echo '               Test B'
echo ' Use sukkaw:feat_enhance_cache'
echo '-------------------------------------'

echo -n 'Round 1: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"

echo -n 'Round 2: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"

../bin/yq w -i _config.yml enhance_cache true

echo '-------------------------------------'
echo '               Test C'
echo 'Enable enhance cache'
echo '-------------------------------------'

echo -n 'Round 1: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"

echo -n 'Round 2: '
npm run clean > /dev/null
time -v npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"
cat build.log | grep "Maximum resident set size"