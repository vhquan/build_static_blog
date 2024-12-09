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

(defun blog-header (info)
  "Generate the header with navigation tabs."
  (concat
   "<nav class=\"nav-header\">"
   "<a href=\"/\">Home</a>"
   "<a href=\"/profile/\">Profile</a>"
   "</nav>"))

(setq org-publish-project-alist
      '(("org"
         :base-directory "org/"
         :base-extension "org"
         :publishing-directory "~/Workspace/vhquan.github.io"
         :recursive t
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :html-head "<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Fira+Mono&family=Source+Code+Pro&display=swap\">
           <link rel=\"stylesheet\" href=\"/style.css\" type=\"text/css\"/>"
         :sitemap-sort-files anti-chronologically
         :auto-preamble nil
         :sitemap-title "Devlift's archives"
         :sitemap-filename "index.org"
         :sitemap-format-entry org-sitemap-custom-entry-format
         :sitemap-style list
         :sitemap-exclude "profile/.*"
         :author "quanvh9"
         :email "vuhongquanbk97@gmail.com"
         :with-creator nil
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-preamble blog-header
         :html-postamble nil)
        ("profile"
         :base-directory "profile/"
         :base-extension "org"
         :publishing-directory "~/Workspace/vhquan.github.io/profile"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :html-head "<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Fira+Mono&family=Source+Code+Pro&display=swap\">
           <link rel=\"stylesheet\" href=\"/style.css\" type=\"text/css\"/>"
         :html-preamble blog-header
         :html-postamble nil)
        ("static"
         :base-directory "org/"
         :base-extension "css\\|htaccess\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt"
         :publishing-directory "~/Workspace/vhquan.github.io"
         :publishing-function org-publish-attachment
         :recursive t)
        ("all" :components ("org" "profile" "static"))))
