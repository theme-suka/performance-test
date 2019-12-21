#!/bin/sh
# Import 300 Posts

_SUBSTRUCTION () {
    echo | awk "{printf \"%.3f\", $1-$2}"
}

_MESSAGE_FORMATTER () {
    awk '{printf "| %-28s | %9s |\n",$1" "$2,$3}'
}

LOG_TABLE () {
    time_begin=$(date +%s -d "$(awk '/.*DEBUG Hexo version/{print $1}' build.log)")
    time_process_start=$(date +%s.%3N -d "$(awk '/.*INFO  Start processing/{print $1}' build.log)")
    time_render_start=$(date +%s.%3N -d "$(awk '/.*INFO  Files loaded in/{print $1}' build.log)")
    time_render_finish=$(date +%s.%3N -d "$(awk '/.*INFO.*generated in /{print $1}' build.log)")
    time_database_saved=$(date +%s.%3N -d "$(awk '/.*DEBUG Database saved/{print $1}' build.log)")

    memory_usage=$(awk '/.*Maximum resident set size/{print $6}' build.log)

    echo "Load Plugin/Scripts/Database $(_SUBSTRUCTION $time_process_start $time_begin)s" | _MESSAGE_FORMATTER
    echo "Process Source $(_SUBSTRUCTION $time_render_start $time_process_start)s" | _MESSAGE_FORMATTER
    echo "Render Files $(_SUBSTRUCTION $time_render_finish $time_render_start)s" | _MESSAGE_FORMATTER
    echo "Save Database $(_SUBSTRUCTION $time_database_saved $time_render_finish)s" | _MESSAGE_FORMATTER
    echo "Total time $(_SUBSTRUCTION $time_database_saved $time_begin)s" | _MESSAGE_FORMATTER
    echo "Memory Usage(RSS) $(echo | awk "{printf \"%.3f\", $memory_usage/1024}")MB" | _MESSAGE_FORMATTER

    total_time=$(_SUBSTRUCTION $time_database_saved $time_begin | xargs -0 printf "%.0f")
    line_number=$(wc -l build.log | cut -d" " -f1)
}

echo "- Set up dummy Hexo site"
cd $TRAVIS_BUILD_DIR
cd ..
git clone https://github.com/hexojs/hexo-theme-unit-test.git --depth=1 --quiet
cd hexo-theme-unit-test

echo "- Install hexo-theme-landscape"
git clone https://github.com/hexojs/hexo-theme-landscape --depth=1 --quiet themes/landscape

echo "- npm install"
npm install --silent

echo "- Import 300 posts"
git clone https://github.com/SukkaLab/hexo-many-posts.git source/_posts/hexo-many-posts --depth=1 --quiet
rm -rf source/_posts/hexo-many-posts/.git/

echo "- Install Hexo 3.2"
npm i hexo@3.2 --silent

echo "============ Hexo 3.2 Benchmark ============"

echo "------------- Cold processing --------------"
npx --no-install hexo clean > build.log
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE

echo "-------------- Hot processing --------------"
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE "HOT"

echo "--------------------------------------------"

echo "- Install Hexo 3.8"
npm i hexo@3.8 --silent

echo "============ Hexo 3.8 Benchmark ============"

echo "------------- Cold processing --------------"
npx --no-install hexo clean > build.log
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE

echo "-------------- Hot processing --------------"
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE "HOT"

echo "--------------------------------------------"

echo "- Install Hexo 4.2"
npm i hexo@4.2 --silent

echo "============ Hexo 4.2 Benchmark ============"

echo "------------- Cold processing --------------"
npx --no-install hexo clean > build.log
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE

echo "-------------- Hot processing --------------"
{ /usr/bin/time -v npx --no-install hexo g --debug > build.log 2>&1 ; } 2> build.log
LOG_TABLE "HOT"

echo "--------------------------------------------"

rm -rf build.log
