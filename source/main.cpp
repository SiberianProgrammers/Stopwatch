#include "Stopwatch.h"
#include "Tray.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
#include <QIcon>

double dp()
{
    #if defined(Q_OS_MAC)
        static double const standardDPI = 72;
    #elif defined(Q_OS_WIN)
        static double const standardDPI = 96;
    #else
        static double const standardDPI = qApp->screens().first()->logicalDotsPerInch();
    #endif

    static const double dpi = qApp->screens().first()->logicalDotsPerInch() / standardDPI;
    return dpi;
}

//------------------------------------------------------------------------------
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/images/IdleIcon.png"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    auto context = engine.rootContext();
    context->setContextProperty("Stopwatch", Stopwatch::instance());
    context->setContextProperty("Tray", Tray::instance());
    context->setContextProperty("dp", dp());

    engine.load(url);

    return app.exec();
}
