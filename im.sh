#!/bin/sh

# Usage Info
show_help() {
cat << EOF
Usage: ${0##*/} [-t TYPE] [FILENAME]
Create an immut.io blob from FILENAME and write the blob URI to standard output.
With no [FILENAME], read standard input.

    -h        display this help and exit
    -t TYPE   Use the specified TYPE when uploading

EOF
}

# Initialize our own variables:
filename=""
type=""

OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts "ht:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        t)  type=$OPTARG
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

filename="$1"

# Read the mimetype from the file, or use text/plain as the default
if [ -f "$filename" ] && [ "$type" = "" ]
  then
    type=$(file --mime-type -b "$filename")
elif [ "$type" = "" ]
  then
    type="text/plain"
fi


# Upload the data and get the resulting relative path
if [ -f "$filename" ]
  then
    # Upload the file
    path=$(curl -sX POST http://immut.io/blobs --upload-file "$filename" -H "Content-Type: $type")
elif [ -t 0 ]
  then 
    # Unrecognized input
    show_help
    exit 0
else
  # Upload contents of stdin
  input=$(cat)
  path=$(curl -sX POST http://immut.io/blobs -H "Content-Type: $type" -d "$input")
fi 

printf 'http://immut.io%s' "$path"

# End of file
