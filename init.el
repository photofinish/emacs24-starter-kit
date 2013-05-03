;;; init.el --- 魔法从这儿开始
;;
;; Emacs 起步套件的一部分
;;
;; 这是首先要加载的东西。
;;

;; 如果设置了环境变量 ORG_HOME, 则尝试从此位置载入 Org-mode.
(when (getenv "ORG_HOME")
  (let ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME"))))
    (when (file-directory-p org-lisp-dir)
      (add-to-list 'load-path org-lisp-dir)
      (require 'org))))

;; 从 `after-init-hook' 载入起步套件，然后是所有其它的包
(add-hook 'after-init-hook
 `(lambda ()
    ;; remember this directory --  记住此目录
    (setq starter-kit-dir
          ,(file-name-directory (or load-file-name (buffer-file-name))))
    ;; only load org-mode later if we didn't load it just now
    ;; 如果现在还没有载入 org-mode, 赶紧加载吧
    ,(unless (and (getenv "ORG_HOME")
                  (file-directory-p (expand-file-name "lisp"
                                                      (getenv "ORG_HOME"))))
       '(require 'org))
    ;; load up the starter kit -- 载入起步套件
    (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))))

;;; init.el ends here
