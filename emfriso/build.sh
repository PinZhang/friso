# !/bin/sh

EMSCRIPTEN_HOME=~/work/opensource/emscripten
echo "$EMSCRIPTEN_HOME"

mkdir data

echo "cp dict file"
cp ../dict/* data/

echo "Package dict data files"
python $EMSCRIPTEN_HOME/tools/file_packager.py emfriso_files.data \
       --preload friso.ini \
       data/friso.lex.ini \
       data/lex-admin.lex \
       data/lex-chars.lex \
       data/lex-cn-mz.lex \
       data/lex-cn-place.lex \
       data/lex-company.lex \
       data/lex-dname-1.lex \
       data/lex-dname-2.lex \
       data/lex-en-pun.lex \
       data/lex-festival.lex \
       data/lex-flname.lex \
       data/lex-food.lex \
       data/lex-lang.lex \
       data/lex-lna.lex \
       data/lex-lname.lex \
       data/lex-main.lex \
       data/lex-mixed.lex \
       data/lex-nation.lex \
       data/lex-net.lex \
       data/lex-org.lex \
       data/lex-sname.lex \
       data/lex-units.lex \
       --js-output=emfriso_files.js

echo "Build libfriso.js"
emcc ../src/fmem.c ../src/friso.c ../src/friso_array.c ../src/friso_hash.c \
     ../src/friso_lexicon.c ../src/friso_link.c ../src/friso_string.c ../src/friso_wrapper.c \
     -O2 --closure 0 -g3 -o libfriso.js -s LINKABLE=1 \
     --pre-js emfriso_files.js \
     -s ASM_JS=0 -s TOTAL_STACK=131072 -s TOTAL_MEMORY=67108864 -s EXPORTED_FUNCTIONS="['_fr_seg', \
     '_fr_next', '_fr_free']"


