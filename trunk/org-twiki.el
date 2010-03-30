;;
;; File   : org-twiki.el
;; Author : Baoqiu Cui <cbaoqiu AT yahoo DOT com>
;;
;; This is a sample Emacs Lisp function that converts an Org file to
;; TWiki format.  It first converts the Org file into DocBook format,
;; and then use ``xsltproc'' and docbook2twiki.xsl to convert the
;; DocBook XML file into TWiki format.
;;
;; $Id$
;;

(defvar org-export-docbook2twiki-xsl-file
  "docbook2twiki.xsl"
  "The full path of file docbook2twiki.xsl.
The default value is ``docbook2twiki.xsl'', which assumes that
the file exists in the current working directory, where your Org
files to be exported exist.")

;; Set org-export-docbook2twiki-xsl-file based on where you saved
;; docbook2twiki.xsl.
(setq org-export-docbook2twiki-xsl-file
      "/Users/bcui/docbook2twiki/docbook2twiki.xsl")

(defun org-export-as-twiki ()
  "Export Org file to TWiki."
  (interactive)
  (message "Exporting to TWiki...")
  (let* ((wconfig (current-window-configuration))
	 (docbook-buf (org-export-as-docbook))
	 (filename (buffer-file-name docbook-buf))
	 (base (file-name-sans-extension filename))
	 (twiki-file (concat base ".twiki")))
    (and (file-exists-p twiki-file) (delete-file twiki-file))
    (message "Processing DocBook XML file...")
    (shell-command
     (format "xsltproc --output %s %s %s"
	     twiki-file
	     org-export-docbook2twiki-xsl-file
	     (shell-quote-argument filename)))
    (message "Processing DocBook file...done")
    (if (not (file-exists-p twiki-file))
	(error "TWiki file was not produced")
      (set-window-configuration wconfig)
      (message "Exporting to TWiki...done")
      twiki-file)))
