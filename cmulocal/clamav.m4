dnl
dnl macros for configure.in to detect clamav library
dnl

AC_DEFUN([CMU_CLAMAV], [
AC_REQUIRE([CMU_FIND_LIB_SUBDIR])
AC_ARG_WITH(clamav,
	[AS_HELP_STRING([--with-clamav=DIR], [use ClamAV - DIR to clamav-config (yes)])],
	with_clamav=$withval, with_clamav=yes)
  have_clamav=no
  if test "$with_clamav" != no; then
	
	if test -d $with_clamav; then
		clamav_path=${with_clamav}:${with_clamav}/bin
	else
		clamav_path=/usr/local/bin:/usr/bin:$PATH
	fi
	AC_PATH_PROG(CLAMAV_CONFIG,clamav-config,,[$clamav_path])

	if test -x "$CLAMAV_CONFIG"; then
		LIB_CLAMAV="`$CLAMAV_CONFIG --libs` -lclamav"
		CFLAGS_CLAMAV=`$CLAMAV_CONFIG --cflags`

		if test -n "$LIB_CLAMAV"; then
			have_clamav=yes
			test -n "$CFLAGS_CLAMAV" && CPPFLAGS="$CPPFLAGS $CFLAGS_CLAMAV"
			AC_DEFINE(HAVE_CLAMAV,[],[Do we have ClamAV?])
			AC_SUBST(LIB_CLAMAV)
		fi
	fi
   fi

   AC_MSG_CHECKING(ClamAV support)
   AC_MSG_RESULT($have_clamav)
])
