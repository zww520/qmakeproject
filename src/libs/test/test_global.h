#ifndef TEST_GLOBAL_H
#define TEST_GLOBAL_H

#include <QtGlobal>

#if defined(TEST_LIBRARY)
#  define TEST_EXPORT Q_DECL_EXPORT
#else
#  define TEST_EXPORT Q_DECL_IMPORT
#endif

#endif // TEST_GLOBAL_H
