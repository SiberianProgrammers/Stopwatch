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
            "include/Settings.h",
            "images/images.qrc",
            "source/Stopwatch.cpp",
            "source/Tray.cpp",
            "source/main.cpp",
            "source/Settings.cpp",
            "qml/qml.qrc",
        ]

        cpp.cxxLanguageVersion: "c++17"
        cpp.includePaths: ["include"]

        Depends { name: "Qt.quick" }
        Depends { name: "Qt.widgets" }

        Group {
            fileTagsFilter: "application"
            qbs.install: true
            qbs.installDir: "bin"
        }
    }
}
