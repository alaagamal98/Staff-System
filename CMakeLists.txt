cmake_minimum_required(VERSION 3.16)

set(STAFF_SYSTEM_APP_VERSION 1.0.0 CACHE STRING "" FORCE)
project(staff-system-app VERSION ${STAFF_SYSTEM_APP_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_BUILD_RPATH "$ORIGIN")
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "$ORIGIN")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING
	    "Default build type: Release" FORCE)
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

message(STATUS "staff-system-app version: ${PROJECT_VERSION}")

# generate separate debug info (pdb)
if(USER_RELEASE AND MSVC)
	add_compile_options(-Zi)
	add_link_options(-DEBUG -OPT:REF -OPT:ICF)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.6 QUIET REQUIRED
	COMPONENTS
		Core
		Network
		PrintSupport
		Qml
		Quick
		Widgets
		WebSockets
		QuickControls2
		ShaderTools
		Svg
		SvgWidgets
)

set(OS_RESOURCES_FILES
${CMAKE_CURRENT_SOURCE_DIR}/StaffSystem.rc
)

find_package(SQLite3 REQUIRED)

qt_add_executable(StaffSystem)

set_source_files_properties(resources/Globals.qml
	PROPERTIES
		QT_QML_SINGLETON_TYPE TRUE
)

set_source_files_properties(resources/StatusBar.qml
	PROPERTIES
		QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(StaffSystem
	URI StaffSystem
	VERSION 1.0
	RESOURCE_PREFIX /
	QML_FILES
		resources/main.qml
		resources/Globals.qml
		resources/HomePage.qml
		resources/HomeSideBar.qml
		resources/LoadingPage.qml
		resources/ProgressDialog.qml
		resources/Notification.qml
		resources/NotificationManager.qml
		resources/EmployeeDialog.qml
		resources/ToolBar.qml
		resources/AddEmployeeButton.qml
		resources/StaffList.qml
		resources/UserItem.qml
		resources/LoginItem.qml
	SOURCES
		${OS_RESOURCES_FILES}
		include/StaffSystem/SystemDriver.h
		include/StaffSystem/LoginDriver.h
		include/StaffSystem/StaffDriver.h
		include/StaffSystem/StaffList.h
		include/StaffSystem/Parser.h
		src/StaffSystem/main.cpp
		src/StaffSystem/SystemDriver.cpp
		src/StaffSystem/LoginDriver.cpp
		src/StaffSystem/StaffDriver.cpp
		src/StaffSystem/StaffList.cpp
		src/StaffSystem/Parser.cpp
	RESOURCES
		icons/siemens.svg
		icons/plus-circle-on.svg
		icons/plus-circle.svg
		icons/wide.svg
		icons/info.svg
		icons/tip.svg
		icons/note.svg
		icons/success.svg
		icons/warning.svg
		icons/error.svg
		icons/account-circle.svg
		icons/logout.svg
)

target_include_directories(StaffSystem
PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/include
		${CMAKE_CURRENT_SOURCE_DIR}/include/StaffSystem
)

set(QT_LIBS
	Qt6::Quick
	Qt6::Widgets
	Qt6::WebSockets
)

target_link_libraries(StaffSystem
	PRIVATE
		${QT_LIBS}
		SQLite::SQLite3
)