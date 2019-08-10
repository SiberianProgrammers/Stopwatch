import qbs

Project {
    QtApplication {
        property pathList qmlImportPaths: [
            sourceDirectory + "/qml",
        ]

        files: [
            "Stopwatch.rc",
            "include/Stopwatch.h",
            "include/Tray.h",
            "images/images.qrc",
            "source/Stopwatch.cpp",
            "source/Tray.cpp",
            "source/main.cpp",
            "qml/qml.qrc",
            "sp_qt_libs/include/Settings.h",
            "sp_qt_libs/source/Settings.cpp",
        ]

        cpp.cxxLanguageVersion: "c++17"
        cpp.includePaths: ["include", "sp_qt_libs/include"]

        Depends { name: "Qt.quick" }
        Depends { name: "Qt.widgets" }

        Group {
            fileTagsFilter: "application"
            qbs.install: true
            qbs.installDir: "bin"
        }
    }
}
