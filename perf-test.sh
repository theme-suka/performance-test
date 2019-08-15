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

rm -rf themes/landscape/js
rm -rf source/assets

echo -n 'Done!
'

echo -n '
* Using hexo-theme-landscape ... '
../bin/yq w -i _config.yml theme landscape


echo "Install latest Hexo..."
npm uninstall hexo --save
npm install git+https://github.com/hexojs/hexo.git

echo '* Test performance ... '
echo '-------------------------------------'
echo '               Test A'
echo ' Baseline'
echo '-------------------------------------'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - meta_generator: off'
echo '-------------------------------------'

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false
../bin/yq w -i _config.yml meta_generator false

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
echo ' Remove open_graph() helper'
echo '-------------------------------------'
echo ' - hexo built in highlight.js'
echo '    - enable: false'
echo '    - line_number: false'
echo '    - auto_detect: false'
echo '    - tab_replace: false'
echo ' - meta_generator: off'
echo '-------------------------------------'

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml meta_generator false

sed -i "s|<%- open_graph({twitter_id: theme.twitter, fb_admins: theme.fb_admins, fb_app_id: theme.fb_app_id}) %>||g" themes/landscape/layout/_partial/head.ejs

echo -n 'Round 1: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'

echo -n 'Round 2: '
npm run clean > /dev/null
npm run generate > perf.log
cat perf.log | grep 'generated in'
