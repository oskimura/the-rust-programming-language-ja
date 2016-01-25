#!/bin/sh
VERSION=$1

build() {
    make RUSTBOOK=${RUSTBOOK}
}

watch_linux(){    
    while  inotifywait -r -e modify "$1"; do
        make RUSTBOOK=${RUSTBOOK}
    done
}

watch_mac(){
    fswatch -r "$1" | while read _; do
        build
    done

}

watch(){
    case "$(uname -s)" in
        Darwin) watch_mac "$1";;
        Linux) watch_linux "$1";;
    esac
}


watch ./${VERSION}/ja
