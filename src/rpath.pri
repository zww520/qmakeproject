# set RPATH_BASE to the APP_..._PATH of the target

#指定RPATH，用于添加搜索依赖库路径
isEmpty(RPATH_BASE): \
    error("You must set RPATH_BASE before including rpath.pri")

REL_PATH_TO_LIBS = $$relative_path($$APP_LIBRARY_PATH, $$RPATH_BASE)

macos {
    QMAKE_LFLAGS += -Wl,-rpath,@loader_path/$$REL_PATH_TO_LIBS
} else:linux-* {
    QMAKE_RPATHDIR += \$\$ORIGIN
    QMAKE_RPATHDIR += \$\$ORIGIN/$$REL_PATH_TO_LIBS

    APP_RPATH = $$join(QMAKE_RPATHDIR, ":")
    QMAKE_LFLAGS += -Wl,-z,origin \'-Wl,-rpath,$${APP_RPATH}\'
    QMAKE_RPATHDIR =
}
