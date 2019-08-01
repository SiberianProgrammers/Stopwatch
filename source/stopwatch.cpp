/// @author M. Serebrennikov
#include "Stopwatch.h"
#include "Settings.h"

#include <QStringBuilder>
#include <QTimer>
#include <QTime>

Stopwatch* Stopwatch::instance()
{
    static Stopwatch stopwatch;
    return &stopwatch;
}

//------------------------------------------------------------------------------
Stopwatch::Stopwatch()
    : _seconds(sp::Settings::get("currentTimer", 0).toInt())
{
    _timer.setInterval(1000);
    connect(&_timer, &QTimer::timeout, this, &Stopwatch::onTimeout);
}

//------------------------------------------------------------------------------
Stopwatch::~Stopwatch()
{
    sp::Settings::set("currentTimer", _seconds);
}

//------------------------------------------------------------------------------
void Stopwatch::start()
{
    _timer.start();
    emit isActiveChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::stop()
{
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
    emit secondsChanged();
}

//------------------------------------------------------------------------------
void Stopwatch::onTimeout()
{
    QTime _time;
    _time.start();
    _time.elapsed();

    _seconds++;
    emit secondsChanged();
}

//------------------------------------------------------------------------------
QString Stopwatch::text() const
{
    int sec = _seconds % 60;
    int min = _seconds % 3600 / 60;
    int hours = _seconds / 3600;

    if (hours > 0) {
        return QString::number(hours) % "h "
               % formatTwoDigits(min) % "m "
               % formatTwoDigits(sec) % "s";
    } else if (min > 0) {
        return QString::number(min)   % "m "
               % formatTwoDigits(sec) % "s";
    } else {
        return QString::number(sec)   % "s";
    }
}

//------------------------------------------------------------------------------
void Stopwatch::setSeconds(int seconds)
{
    if (_seconds != seconds) {
        _seconds = seconds;
        emit secondsChanged();
    }
}

//------------------------------------------------------------------------------
QString Stopwatch::formatTwoDigits(int number)
{
    return number > 9
           ? QString::number(number)
           : "0" % QString::number(number);
}
