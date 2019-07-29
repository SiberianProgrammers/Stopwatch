/// @author M. Serebrennikov
#include <QObject>
#include <QTimer>
#include <QString>

class Stopwatch: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text NOTIFY secondsChanged)
    Q_PROPERTY(int seconds READ seconds WRITE setSeconds NOTIFY secondsChanged)
    Q_PROPERTY(bool isActive READ isActive NOTIFY isActiveChanged)

    public:
        static Stopwatch* instance();

        //----------------------------------------------------------------------
        // Get
        //----------------------------------------------------------------------
        /** Возвращает текстовое значение таймера. */
        inline QString text() const { return _text; }

        /** Возвращает количество отмеренных секунд. */
        inline int seconds() const { return _seconds; }

        /** Возвращает true, если секундомер запущен. */
        inline bool isActive() const { return _timer.isActive(); }

        //----------------------------------------------------------------------
        // Set
        //----------------------------------------------------------------------
        /** Устанавливает количество отмеренных секунд. */
        void setSeconds(int seconds);

        //----------------------------------------------------------------------
        // Special
        //----------------------------------------------------------------------
        /** Запускает таймер. */
        Q_INVOKABLE void start();

        /** Останавливает таймер. */
        Q_INVOKABLE void stop();

        /** Включаети или останавливает таймер. */
        Q_INVOKABLE void toggle();

        /** Очищает таймер. */
        Q_INVOKABLE void clear();

    private:
        Stopwatch();

        void onTimeout();

        /** Обновляет текстовое представление таймера. */
        void updateText();

        /** Возвращает текст из двух чисел (00,05, 20 и т.п.). */
        static QString formatTwoDigits(int number);

    signals:
        void secondsChanged();
        void isActiveChanged();

    private:
        QTimer _timer;
        QString _text;
        int _seconds = 0.0;
};
