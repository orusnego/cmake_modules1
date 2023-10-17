function(add_qt)
	#Get QT libraries
	ExternalProject_Add(qt5_ext
		GIT_REPOSITORY    git://code.qt.io/qt/qt5.git
		GIT_TAG           v5.14.1
		SOURCE_DIR        ""
		GIT_SUBMODULES	  qtbase qtdeclarative qtcharts qtquickcontrols2 qtquickcontrols qtgraphicaleffects qtxmlpatterns qtsvg
		CONFIGURE_COMMAND ../qt5_ext/configure -prefix ../qt5_ext/installed -opensource -confirm-license -nomake examples -nomake tests -qt-zlib -qt-libjpeg -qt-libpng -qt-pcre -qt-harfbuzz -qt-doubleconversion -qtlibinfix RB -system-freetype -fontconfig -skip qtpim -skip qtlottie -skip qtwebchannel -skip qtscxml -skip qtqa -skip qtwayland -skip qtpurchasing -skip qtserialport -skip qtcanvas3d -skip qtlocation -skip qt3d -skip qttranslations -skip qtwebglplugin -skip qtx11extras -skip qtdoc -skip qtquicktimeline -skip qtrepotools -skip qtimageformats -skip qtquick3d -skip qtvirtualkeyboard -skip qtwinextras -skip qtmacextras -skip qtmultimedia -skip qtscript -skip qtremoteobjects -skip qtgamepad -skip qtandroidextras -skip qtwebengine -skip qtsystems -skip qtsensors -skip qtserialbus -skip qtnetworkauth -skip qtdocgallery -skip qtfeedback -skip qtwebsockets -skip qtwebview -skip qtactiveqt -skip qttools -skip qtspeech -skip qtdatavis3d -skip qtconnectivity
		BUILD_COMMAND     make
		INSTALL_COMMAND   make install
		TEST_COMMAND      ""
		UPDATE_COMMAND ""
		EXCLUDE_FROM_ALL TRUE
	)
#	ExternalProject_Add(qt5_ext
#		URL				  http://10.177.32.32/env/libraries/qt5/-/raw/master/qt-everywhere-src-5.14.1.tar.xz
#		SOURCE_DIR        ""
#		CONFIGURE_COMMAND ../qt5_ext/configure -prefix ../qt5_ext/installed -opensource -confirm-license -nomake examples -nomake tests -qt-zlib -qt-libjpeg -qt-libpng -qt-pcre -qt-harfbuzz -qt-doubleconversion -qtlibinfix RB -system-freetype -fontconfig -skip qtpim -skip qtlottie -skip qtwebchannel -skip qtscxml -skip qtqa -skip qtwayland -skip qtpurchasing -skip qtserialport -skip qtcanvas3d -skip qtlocation -skip qt3d -skip qttranslations -skip qtwebglplugin -skip qtx11extras -skip qtdoc -skip qtquicktimeline -skip qtrepotools -skip qtimageformats -skip qtquick3d -skip qtvirtualkeyboard -skip qtwinextras -skip qtmacextras -skip qtmultimedia -skip qtscript -skip qtremoteobjects -skip qtgamepad -skip qtandroidextras -skip qtwebengine -skip qtsystems -skip qtsensors -skip qtserialbus -skip qtnetworkauth -skip qtdocgallery -skip qtfeedback -skip qtwebsockets -skip qtwebview -skip qtactiveqt -skip qttools -skip qtspeech -skip qtdatavis3d -skip qtconnectivity
#		BUILD_COMMAND     make
#		INSTALL_COMMAND   make install
#		TEST_COMMAND      ""
#		UPDATE_COMMAND    ""
#		EXCLUDE_FROM_ALL  TRUE
#	)
	ExternalProject_Get_Property(qt5_ext SOURCE_DIR)
	create_qt_include_dir(${SOURCE_DIR} "installed/include" qt_include_dir)

	#===================================================================================================================

#	list(APPEND QT_PLUGIN_ARTIFACTS "${SOURCE_DIR}/installed/plugins/platforms")
#	list(APPEND QT_PLUGIN_ARTIFACTS "${SOURCE_DIR}/installed/plugins/imageformats")
#	list(APPEND QT_PLUGIN_ARTIFACTS "${SOURCE_DIR}/installed/plugins/sqldrivers")

#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5CoreRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5ChartsRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5DBusRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5EglFSDeviceIntegrationRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5GuiRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5NetworkRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QmlModelsRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QmlRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QmlWorkerScriptRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QuickRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5SqlRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5TestRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5WidgetsRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5XcbQpaRB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QuickControls2RB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5QuickTemplates2RB.so.5")
#	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5SvgRB.so.5")
	
	list(APPEND QT_LIBRARY_ARTIFACTS "${SOURCE_DIR}/installed/lib/libQt5*")
	list(APPEND QT_QML_ARTIFACTS "${SOURCE_DIR}/installed/qml")
	list(APPEND QT_PLUGIN_ARTIFACTS "${SOURCE_DIR}/installed/plugins")

	execute_process(
	COMMAND
		bash -c "echo \"${QT_LIBRARY_ARTIFACTS}\" > qt_library_artifacts; sed -i \"s/;/\\n/g\" qt_library_artifacts"
	WORKING_DIRECTORY
		${CMAKE_CURRENT_SOURCE_DIR}
	)

	execute_process(
	COMMAND
		bash -c "echo \"${QT_PLUGIN_ARTIFACTS}\" > qt_plugin_artifacts; sed -i \"s/;/\\n/g\" qt_plugin_artifacts"
	WORKING_DIRECTORY
		${CMAKE_CURRENT_SOURCE_DIR}
	)

	execute_process(
	COMMAND
		bash -c "echo \"${QT_QML_ARTIFACTS}\" > qt_qml_artifacts; sed -i \"s/;/\\n/g\" qt_qml_artifacts"
	WORKING_DIRECTORY
		${CMAKE_CURRENT_SOURCE_DIR}
	)

	#===================================================================================================================

	add_library(RuBackup::QtCore SHARED IMPORTED)
	set_property(TARGET RuBackup::QtCore APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtCore" qt_lib_include_dir)
	set_target_properties(RuBackup::QtCore
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtCore;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5CoreRB.so.5
	)
	set_target_properties(RuBackup::QtCore
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_CORE_LIB
	)
	add_dependencies(RuBackup::QtCore qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtQuick SHARED IMPORTED)
	set_property(TARGET RuBackup::QtQuick APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtQuick" qt_lib_include_dir)
	set_target_properties(RuBackup::QtQuick
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtQuick;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5QuickRB.so.5
	)
	set_target_properties(RuBackup::QtQuick
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_QUICK_LIB
	)
	add_dependencies(RuBackup::QtQuick qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtGui SHARED IMPORTED)
	set_property(TARGET RuBackup::QtGui APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtGui" qt_lib_include_dir)
	set_target_properties(RuBackup::QtGui
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtGui;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5GuiRB.so.5
	)
	set_target_properties(RuBackup::QtGui
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_GUI_LIB
	)
	add_dependencies(RuBackup::QtGui qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtTest SHARED IMPORTED)
	set_property(TARGET RuBackup::QtTest APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtTest" qt_lib_include_dir)
	set_target_properties(RuBackup::QtTest
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtTest;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5TestRB.so.5
	)
	set_target_properties(RuBackup::QtTest
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_TEST_LIB
	)
	add_dependencies(RuBackup::QtTest qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtQml SHARED IMPORTED)
	set_property(TARGET RuBackup::QtQml APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtQml" qt_lib_include_dir)
	set_target_properties(RuBackup::QtQml
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtQml;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5QmlRB.so.5
	)
	set_target_properties(RuBackup::QtQml
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_QML_LIB
	)
	add_dependencies(RuBackup::QtQml qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtQmlModels SHARED IMPORTED)
	set_property(TARGET RuBackup::QtQmlModels APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtQmlModels" qt_lib_include_dir)
	set_target_properties(RuBackup::QtQmlModels
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtQmlModels;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5QmlModelsRB.so.5
	)
	set_target_properties(RuBackup::QtQmlModels
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_QMLMODELS_LIB
	)
	add_dependencies(RuBackup::QtQmlModels qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtSql SHARED IMPORTED)
	set_property(TARGET RuBackup::QtSql APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtSql" qt_lib_include_dir)
	set_target_properties(RuBackup::QtSql
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtSql;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5SqlRB.so.5
	)
	set_target_properties(RuBackup::QtSql
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_SQL_LIB
	)
	add_dependencies(RuBackup::QtSql qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtWidgets SHARED IMPORTED)
	set_property(TARGET RuBackup::QtWidgets APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtWidgets" qt_lib_include_dir)
	set_target_properties(RuBackup::QtWidgets
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtWidgets;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5WidgetsRB.so.5
	)
	set_target_properties(RuBackup::QtWidgets
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_WIDGETS_LIB
	)
	add_dependencies(RuBackup::QtWidgets qt5_ext)

	#===================================================================================================================

	add_library(RuBackup::QtNetwork SHARED IMPORTED)
	set_property(TARGET RuBackup::QtNetwork APPEND PROPERTY INTERFACE_COMPILE_OPTIONS -fPIC)
	create_qt_include_dir(${SOURCE_DIR} "installed/include/QtNetwork" qt_lib_include_dir)
	set_target_properties(RuBackup::QtNetwork
	PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${qt_include_dir}/QtNetwork;${qt_include_dir}"
		IMPORTED_LOCATION ${SOURCE_DIR}/installed/lib/libQt5NetworkRB.so.5
	)
	set_target_properties(RuBackup::QtNetwork
	PROPERTIES
		INTERFACE_COMPILE_DEFINITIONS QT_NETWORK_LIB
	)
	add_dependencies(RuBackup::QtNetwork qt5_ext)

endfunction()

function(create_qt_include_dir ROOT_DIR DIR_PATH INC_DIR)
	execute_process(COMMAND mkdir -p ${DIR_PATH}
			WORKING_DIRECTORY ${ROOT_DIR}
			)
	set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()

function(fix_qt)
	execute_process(COMMAND sed -i "47i\#include <limits>" ./qt5_ext-prefix/src/qt5_ext/qtbase/src/corelib/global/qfloat16.h)
	execute_process(COMMAND sed -i "50i\#include <limits>" ./qt5_ext-prefix/src/qt5_ext/qtbase/src/corelib/global/qendian.h)
 	execute_process(COMMAND sed -i "44i\#include <limits>" ./qt5_ext-prefix/src/qt5_ext/qtbase/src/corelib/text/qbytearraymatcher.h)
	execute_process(COMMAND sed -i "52i\#include <limits>" ./qt5_ext-prefix/src/qt5_ext/qtdeclarative/src/qmldebug/qqmlprofilerevent_p.h)
endfunction()
