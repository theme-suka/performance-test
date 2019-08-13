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

echo '* Test performance ... '
echo '-------------------------------------'
echo '               Test A'
echo ' Best performance'
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
echo ' Disable fragment_cache'
echo '-------------------------------------'
echo ' - fragment_fache: off'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache false

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'


echo '-------------------------------------'
echo '               Test C'
echo ' Enable highlight alone'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: true'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable true
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'


echo '-------------------------------------'
echo '               Test D'
echo ' Enable highlight & line_number'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: true'
echo '    - line_number: true'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable true
../bin/yq w -i _config.yml highlight.line_number true
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'


echo '-------------------------------------'
echo '               Test E'
echo ' Enable highlight & tab_replace'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: true'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: true'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable true
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace true

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'



echo '-------------------------------------'
echo '               Test F'
echo ' Enable highlight, line_number & tab_replace'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: true'
echo '    - line_number: true'
echo '    - auto_detect: false'
echo '    - tab_replace: true'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: off'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable true
../bin/yq w -i _config.yml highlight.line_number true
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace true

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable false

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'


echo '-------------------------------------'
echo '               Test G'
echo ' Enable local-search'
echo '-------------------------------------'
echo ' - fragment_fache: on'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - suka theme prism highlight: off'
echo ' - suka theme local-search: on'
echo '-------------------------------------'

../bin/yq w -i themes/suka/_config.yml fragment_cache true

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false

../bin/yq w -i _config.yml suka_theme.search.enable true

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo '-------------------------------------'
echo '               Test H'
echo ' Test hexo-renderer-extended-ejs'
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

npm uninstall hexo-renderer-ejs --save
npm i hexo-renderer-extended-ejs --save

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'