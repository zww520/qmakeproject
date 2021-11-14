CONFIG += c++14
CONFIG += debug

defineReplace(LibraryTargetName) {
   unset(LIBRARY_NAME)
   LIBRARY_NAME = $$1
   CONFIG(debug, debug|release) {
      !debug_and_release|build_pass {
          mac:RET = $$member(LIBRARY_NAME, 0)_debug
              else:win32:RET = $$member(LIBRARY_NAME, 0)d
      }
   }
   isEmpty(RET):RET = $$LIBRARY_NAME
   return($$RET)
}

defineReplace(LibraryName) {
   RET = $$LibraryTargetName($$1)
   return($$RET)
}

#获取生成makefile的相对路径
defineReplace(stripSrcDir) {
    return($$relative_path($$absolute_path($$1, $$OUT_PWD), $$_PRO_FILE_PWD_))
}

#应用源目录
APP_SOURCE_TREE = $$PWD

#应用构建目录(中间文件等)
isEmpty(APP_BUILD_TREE) {
    sub_dir = $$_PRO_FILE_PWD_
    sub_dir ~= s,^$$re_escape($$PWD),,
    APP_BUILD_TREE = $$clean_path($$OUT_PWD)
    APP_BUILD_TREE ~= s,$$re_escape($$sub_dir)$,,
}

# target output path if not set manually
isEmpty(APP_OUTPUT_PATH): \
    APP_OUTPUT_PATH = $$APP_BUILD_TREE

APP_TARGET_NAME = qmakeproject

#指定源码输出库路径
APP_LIBRARY_PATH = $$APP_OUTPUT_PATH/lib

#指定可执行文件输出路径
APP_BIN_PATH     = $$APP_OUTPUT_PATH/bin

#指定源码库路径
APP_LIB_DIRS += $$APP_SOURCE_TREE/src/libs

win32: \
    APP_LIBEXEC_PATH = $$APP_OUTPUT_PATH/bin
else: \
    APP_LIBEXEC_PATH = $$APP_OUTPUT_PATH/libexec/

#当前源目录为非输出目录，则复制
!isEqual(APP_SOURCE_TREE, $$APP_OUTPUT_PATH):copydata = 1

#链接库路径
LINK_LIBRARY_PATH = $$APP_BUILD_TREE/lib

#存放库路径
INSTALL_LIBRARY_PATH = $$APP_OUTPUT_PATH/lib

#存放可执行文件路径
INSTALL_BIN_PATH     = $$APP_BIN_PATH


INCLUDEPATH += \
    $$APP_BUILD_TREE/src \ # for <app/app_version.h> in case of actual build directory
    $$APP_SOURCE_TREE/src \ # for <app/app_version.h> in case of binary package with dev package
    $$APP_SOURCE_TREE/src/libs

#win32:exists($$APP_SOURCE_TREE/lib) {
#    # for .lib in case of binary package with dev package
#    LIBS *= -L$$APP_SOURCE_TREE/lib
#}

LIBS *= -L$$LINK_LIBRARY_PATH

qt {
    contains(QT, core): QT += concurrent
    contains(QT, gui): QT += widgets
}


# recursively resolve library deps
done_libs =
for(ever) {
    isEmpty(APP_LIB_DEPENDS): \
        break()
    done_libs += $$APP_LIB_DEPENDS
    for(dep, APP_LIB_DEPENDS) {
        dependencies_file =
        for(dir, APP_LIB_DIRS) {
            exists($$dir/$$dep/$${dep}_dependencies.pri) {
                dependencies_file = $$dir/$$dep/$${dep}_dependencies.pri
                break()
            }
        }
        isEmpty(dependencies_file): \
            error("Library dependency $$dep not found")
        include($$dependencies_file)
        LIBS += -l$$LibraryName($$APP_LIB_NAME)
    }
    APP_LIB_DEPENDS = $$unique(APP_LIB_DEPENDS)
    APP_LIB_DEPENDS -= $$unique(done_libs)
}

