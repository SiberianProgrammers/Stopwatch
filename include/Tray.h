/// @author M. Serebrennikov

#include <QObject>

class QAction;
class QMenu;
class QSystemTrayIcon;

class Tray: public QObject
{
    Q_OBJECT

    public:
        static Tray* instance();

    private:
        Tray();

        void createMenu();
        void createTrayIcon();

    signals:
        void clicked();
        void doubleClicked();

    private:
        QSystemTrayIcon *_trayIcon;
        QAction *_quitAction;
        QAction *_toggleAction;
        QMenu *_trayIconMenu;
};
