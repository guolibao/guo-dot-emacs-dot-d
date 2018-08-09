;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil
  (eval progn
	(setq company-c-headers-path-user
	      (delete-dups
	       (append company-c-headers-path-user
		       (list "aa" "bb" "F:/Qt/Qt5.8.0/5.8/mingw53_32/include")))))))
