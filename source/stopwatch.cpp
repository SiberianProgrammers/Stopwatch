/// @author M. Serebrennikov
#include "Stopwatch.h"

#include <QStringBuilder>
#include <QTimer>
#include <QDebug>

Stopwatch* Stopwatch::instance()
{
    static Stopwatch stopwatch;
    return &stopwatch;
}

//------------------------------------------------------------------------------
QString Stopwatch::formatTwoDigits(int number)
{
    return number > 9
           ? QString::number(number)
           : "0" % QString::number(number);
}

//------------------------------------------------------------------------------
Stopwatch::Stopwatch()
{
    _timer.setInterval(1000);
    connect(&_timer, &QTimer::timeout, this, &Stopwatch::onTimeout);
}

//------------------------------------------------------------------------------
void Stopwatch::start()
{
    qDebug() << "start";
    _timer.start();
    emit isActiveChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::stop()
{
    qDebug() << "stop";
    _timer.stop();
    emit isActiveChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::toggle()
{
    if (_timer.isActive()) {
        stop();
    } else {
        start();
    }
}

//------------------------------------------------------------------------------
void Stopwatch::clear()
{
    _seconds = 0.0;
    updateText();
    emit secondsChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::onTimeout()
{
    _seconds++;
    updateText();
    emit secondsChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::updateText()
{
    int sec = _seconds % 60;
    int min = _seconds % 3600 / 60;
    int hours = _seconds / 3600;

    if (hours > 0) {
        _text =  QString::number(hours) % ":"
                 % formatTwoDigits(min) % ":"
                 % formatTwoDigits(sec);
    } else if (min > 0) {
        _text =  QString::number(min) % ":"
                 % formatTwoDigits(sec);
    } else {
        _text =  QString::number(sec);
    }
}

//------------------------------------------------------------------------------
void Stopwatch::setSeconds(int seconds)
{
    if (_seconds != seconds) {
        _seconds = seconds;
        updateText();
        emit secondsChanged();
    }
}
