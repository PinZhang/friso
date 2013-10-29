# !/bin/sh

EMSCRIPTEN_HOME=~/work/opensource/emscripten
echo "$EMSCRIPTEN_HOME"

echo "Build libfriso.js"
emcc ../src/fmem.c ../src/friso.c ../src/friso_array.c ../src/friso_hash.c \
     ../src/friso_lexicon.c ../src/friso_link.c ../src/friso_string.c \
     -O2 --closure 0 -g3 -o libfriso.js -s LINKABLE=1 \
     -s ASM_JS=1 -s TOTAL_STACK=131072 -s TOTAL_MEMORY=4194304 -s EXPORTED_FUNCTIONS="['_friso_new', \
     '_friso_new_from_ifile', '_friso_free', '_friso_set_dic', '_friso_set_mode', \
     '_friso_new_task', '_friso_free_task', '_friso_new_hits', '_friso_free_hits', \
     '_friso_set_text', '_friso_next', '_friso_dic_load', '_friso_dic_get']"

mkdir data

echo "cp dict file"
cp ../dict/*.lex data/

echo "Package dict data files"
python $EMSCRIPTEN_HOME/tools/file_packager.py emfriso_files.data \
       --preload data/lex-admin.lex \
       --preload data/lex-chars.lex \
       --preload data/lex-cn-mz.lex \
       --preload data/lex-cn-place.lex \
       --preload data/lex-company.lex \
       --preload data/lex-dname-1.lex \
       --preload data/lex-dname-2.lex \
       --preload data/lex-en-pun.lex \
       --preload data/lex-festival.lex \
       --preload data/lex-flname.lex \
       --preload data/lex-food.lex \
       --preload data/lex-lang.lex \
       --preload data/lex-lna.lex \
       --preload data/lex-lname.lex \
       --preload data/lex-main.lex \
       --preload data/lex-mixed.lex \
       --preload data/lex-nation.lex \
       --preload data/lex-net.lex \
       --preload data/lex-org.lex \
       --preload data/lex-sname.lex \
       --preload data/lex-units.lex \
       --pre-run > emfriso_files.js

