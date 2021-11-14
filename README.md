## 使用QMAKE构建项目

### 项目基本布局

qmakeproject-global.pri  # 全局定义

qmakeproject.pro  

src    # 源目录

-- app   # 应用目录

​	-- app.pro

​	-- main.cpp

-- libs  #库目录

​	-- test

​		-- test-lib.pri

​		-- test.pro  

​		-- test_dependencies.pri  # 库依赖

​	-- util

​		-- util-lib.pri

​		-- util.pro  

​		-- util_dependencies.pri  # 库依赖

​	--libs.pro

-- src.pro

-- rpath.pri  # 指定rpath路径

-- library.pri  # 指定库编译方式
