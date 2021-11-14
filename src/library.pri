#添加库
include($$replace(_PRO_FILE_PWD_, ([^/]+$), \\1/\\1_dependencies.pri))
TARGET = $$APP_LIB_NAME

include(../qmakeproject-global.pri)

win32 {
    DLLDESTDIR = $$APP_BIN_PATH
}

DESTDIR = $$APP_LIBRARY_PATH

RPATH_BASE = $$APP_LIBRARY_PATH
include(rpath.pri)

TARGET = $$LibraryTargetName($$TARGET)

TEMPLATE = lib
CONFIG += shared dll

contains(QT_CONFIG, reduce_exports):CONFIG += hide_symbols

win32 {
    dlltarget.path = $$INSTALL_BIN_PATH
    INSTALLS += dlltarget
} else {
    target.path = $$INSTALL_LIBRARY_PATH
    INSTALLS += target
}
