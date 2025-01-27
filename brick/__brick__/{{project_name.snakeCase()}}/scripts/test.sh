#!/bin/sh
# create a helper file to make coverage work for all dart files except the generated files 
sh scripts/import_files_coverage.sh {{project_name.snakeCase()}}

# run tests and generate a coverage file (at /coverage/lcov.info)
flutter test --coverage --test-randomize-ordering-seed random

# remove all generated files in lcov.info
sh scripts/remove_gen_files_in_lcov.sh 

# generate coverage info
genhtml -o coverage coverage/lcov.info 

# open to see coverage info
open coverage/index.html
