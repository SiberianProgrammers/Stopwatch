import qbs

CppApplication {
    files: [
        "include/Stopwatch.h",
        "include/Tray.h",
        "qml/images.qrc",
        "source/Stopwatch.cpp",
        "source/Tray.cpp",
        "source/main.cpp",
        "qml/qml.qrc",
    ]

    cpp.cxxLanguageVersion: "c++11"
    cpp.includePaths: "include"
    Depends { name: "Qt.quick" }
    Depends { name: "Qt.widgets" }

    Group {
        fileTagsFilter: "application"
        qbs.install: true
        qbs.installDir: "bin"
    }
}
