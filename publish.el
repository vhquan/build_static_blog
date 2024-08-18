(require 'ox-publish)

;; OrgMode configs
(setq org-return-follows-link t)
(setq org-hide-emphasis-markers t)
(setq org-html-validation-link nil)

(defun org-sitemap-custom-entry-format (entry style project)
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
	(format "*%s*" entry)
      (format "%s   [[file:%s][%s]]"
	      (format-time-string "%Y.%m.%d" (org-publish-find-date entry project))
	      entry
	      filename))))

(setq org-publish-project-alist
      '(("org"
         :base-directory "org/"
         :base-extension "org"
         :publishing-directory "~/Workspace/vhquan.github.io"
         :recursive t
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :sitemap-sort-files anti-chronologically
	 :auto-preamble nil
         :sitemap-title "A stash of notes"
         :sitemap-filename "index.org"
         :sitemap-format-entry org-sitemap-custom-entry-format
         :sitemap-style list
         :author "quanvh9"
         :email "vuhongquanbk97@gmail.com"
         :with-creator nil
	 :html-head "<link rel=\"stylesheet\" href=\"https://vhquan.github.io/css/style.css\" type=\"text/css\"/>"
	 :html-head-include-default-style nil
	 :html-head-include-scripts nil
	 :html-preamble blog-header
     :html-postamble nil
	 :html-link-home "/")
        ("static"
         :base-directory "org/"
         :base-extension "css\\|htaccess\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt"
         :publishing-directory "~/Workspace/vhquan.github.io"
         :publishing-function org-publish-attachment
         :recursive t)
        ("all" :components ("org" "static"))))
