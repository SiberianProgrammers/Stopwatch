/// @author M. Serebrennikov
#include "Tray.h"
#include "Stopwatch.h"

#include <QApplication>
#include <QAction>
#include <QSystemTrayIcon>
#include <QMenu>
#include <QDebug>

Tray *Tray::instance()
{
    static Tray tray;
    return &tray;
}

//------------------------------------------------------------------------------
Tray::Tray()
{
    createMenu();
    createTrayIcon();

    connect(Stopwatch::instance(), &Stopwatch::isActiveChanged, this, [=]() {
        if (Stopwatch::instance()->isActive()) {
            _toggleAction->setText(tr("&Стоп"));
            _trayIcon->setIcon(QIcon(":/images/ActiveIcon.png"));
        } else {
            _toggleAction->setText(tr("&Старт"));
            _trayIcon->setIcon(QIcon(":/images/IdleIcon.png"));
        }
    });
}

//------------------------------------------------------------------------------
void Tray::createMenu()
{
    _quitAction = new QAction(tr("&Выход"), this);
    connect(_quitAction, &QAction::triggered, qApp, &QCoreApplication::quit);

    _toggleAction = new QAction(tr("&Старт"), this);
    connect(_toggleAction, &QAction::triggered, Stopwatch::instance(), &Stopwatch::toggle);

    // Добаляем в меню действия
    _trayIconMenu = new QMenu();
    _trayIconMenu->addSeparator();
    _trayIconMenu->addAction(_quitAction);
    _trayIconMenu->addAction(_toggleAction);
}

//------------------------------------------------------------------------------
void Tray::createTrayIcon()
{
    _trayIcon = new QSystemTrayIcon(this);
    _trayIcon->setContextMenu(_trayIconMenu);
    _trayIcon->setIcon(QIcon(":/images/IdleIcon.png"));
    _trayIcon->show();

    // Запускаем/останавливаем таймер по нажатию на иконку трея
    connect(_trayIcon, &QSystemTrayIcon::activated, this, [=](QSystemTrayIcon::ActivationReason reason) {
        switch (reason) {
            case QSystemTrayIcon::Trigger:
                emit clicked();
                break;

            case QSystemTrayIcon::DoubleClick:
                emit doubleClicked();
                break;

            default:
                break;
        }
    });

    connect(Stopwatch::instance(), &Stopwatch::secondsChanged, this, [=]() {
        if (Stopwatch::instance()->seconds()) {
            _trayIcon->setToolTip(tr("Отсчитано времени: ") + Stopwatch::instance()->text());
        } else {
            _trayIcon->setToolTip("");
        }
    });
}
