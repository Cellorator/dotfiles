(setq package-enable-at-startup nil)

(setenv "PATH" (format "%s:%s" "/data/data/com.termux/files/usr/bin" (getenv "PATH")))
(push "/data/data/com.termux/files/usr/bin" exec-path)
