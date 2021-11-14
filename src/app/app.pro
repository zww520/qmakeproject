include(../../qmakeproject-global.pri)

TEMPLATE = app

TARGET = $$APP_TARGET_NAME

DESTDIR = $$APP_BIN_PATH

RPATH_BASE = $$APP_BIN_PATH

include(../rpath.pri)

SOURCES += \
    main.cpp

LIBS *= -l$$LibraryName(test)
