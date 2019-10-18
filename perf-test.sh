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

../bin/yq w -i _config.yml highlight.enable false
../bin/yq w -i _config.yml highlight.line_number false
../bin/yq w -i _config.yml highlight.auto_detect false
../bin/yq w -i _config.yml highlight.tab_replace false

../bin/yq w -i _config.yml suka_theme.prism.enable false
../bin/yq w -i _config.yml suka_theme.prism.line_number false
../bin/yq w -i themes/suka/_config.yml fragment_cache true
../bin/yq w -i _config.yml suka_theme.search.enable false

../bin/yq w -i _config.yml external_link false
../bin/yq w -i _config.yml meta_generator false

npm uninstall hexo --save
npm install hexojs/hexo

echo '-------------------------------------'
echo '               Test A'
echo ' Warehouse current version'
echo '-------------------------------------'

echo -n 'Round 1: '
npm run clean > /dev/null
npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"

echo -n 'Hot process: '
npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"

echo '-------------------------------------'
echo '               Test B'
echo ' Warehouse Streaming'
echo '-------------------------------------'

rm -rf node_modules/warehouse
git clone -b "warehouse#save-streaming" https://github.com/segayuu/warehouse node_modules/warehouse
echo -n 'Round 1: '
npm run clean > /dev/null
npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"

echo -n 'Hot process: '
npx --no-install hexo g --debug > build.log
cat build.log | grep "Hexo version"
cat build.log | grep "Start processing"
cat build.log | grep "loaded in"
cat build.log | grep "generated in"
cat build.log | grep "Database saved"

echo '-------------------------------------'

