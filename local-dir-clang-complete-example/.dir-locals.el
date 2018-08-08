;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil
  (eval progn
	(setq company-c-headers-path-user
	      (delete-dups
	       (append company-c-headers-path-user
		       (list "aa" "bb" "cc")))))))
