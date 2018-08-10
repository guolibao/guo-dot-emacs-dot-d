find $PWD -name "*.h" | sed -r 's|/[^/]+$||' | sort | uniq | sed -r 's|^/.+$|"&"|' | sed '1i\
((nil\
(eval progn\
(setq company-c-headers-path-user\
(delete-dups\
(append company-c-headers-path-user\
(list' | sed '$a\
)))))))
' > .dir-locals.el

