pam_radius_configure_depend = pam-install

pam_radius_CPPFLAGS = $(call installed_includes_fn, pam)
pam_radius_LDFLAGS = $(call installed_libs_fn, pam)

