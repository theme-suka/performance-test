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

rm -rf themes/suka/source/css/highlight
rm -rf themes/suka/source/lib/prettify/themes
rm -rf themes/suka/source/lib/prism
rm -rf source/assets

echo -n 'Done!
'

npm uninstall hexo --save
npm install git+https://github.com/hexojs/hexo.git

echo '-------------------------------------'
echo '* Test performance ... '
echo '-------------------------------------'
echo '               Test A'
echo ' Baseline'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

../bin/yq w -i _config.yml meta_generator false
../bin/yq w -i _config.yml external_link true

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo '-------------------------------------'
echo '               Test B'
echo ' Disable external link'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

../bin/yq w -i _config.yml meta_generator false
../bin/yq w -i _config.yml external_link false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'
