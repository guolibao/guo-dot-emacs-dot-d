find /home/guo/wkspace/bootloader -name *.h | sed -r 's|/[^/]+$||' | sort | uniq | sed -e 's/^/-I/' > .clang_complete
