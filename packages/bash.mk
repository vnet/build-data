bash_make_parallel_fails = sometimes

bash_depend = ncurses
$(call pkgPhaseDependMacro,bash)

bash_configure_args = --without-bash-malloc --disable-multibyte

#this will cause getcwd to be picked up from glibc, not bash libraries.
bash_configure_env = bash_cv_getcwd_malloc=yes
 
# If you need a static bash uncomment the following line
#bash_configure_args += --enable-static-link

bash_image_exclude = bin/bashbug
bash_image_install = ln -sf /bin/bash bin/sh
