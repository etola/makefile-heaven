#!/bin/bash

# echo
# echo
# echo input:"$@"


library=''
src=''
out=''
var=$1

while [ 1 ]; do
    case $var in
        "-l")
            while [ 1 ]; do
                shift
                var=$1
                if [ ${#var} -eq 0 ];then
                    break
                fi
                if [ ${var:0:1} == '-' ]; then
                    break
                fi
                tag_file=`pkg-config --variable=tagfile $var`
                if [ ${#tag_file} -ne 0 ]; then
                    library=$library" ""-i $tag_file"
                fi
            done
            ;;

        "-f")
            while [ 1 ]; do
                shift
                var=$1
                if [ ${#var} -eq 0 ];then
                    break
                fi
                if [ ${var:0:1} == '-' ]; then
                    break
                fi
                src=$src" "$var
            done
            ;;

        "-o")
            var=$1
            if [ ${#var} -eq 0 ];then
                break
            fi
            shift
            out=$var
            ;;

        *)
            break
    esac
done
# echo libraries: $library
# echo src      : $src
# echo out      : $out
echo "etags ${library} ${src} -o ${out}"
etags ${library} ${src} -o ${out}
