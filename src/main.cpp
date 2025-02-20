/*
  The MIT License (MIT)

  Copyright (c) 2015-2021 Andrea Scarpino <andrea@scarpino.dev>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/

#include <QApplication>
#include <QtQuick>

#include <sailfishapp.h>

#include "lyricsmanager.h"

int main(int argc, char *argv[])
{
    //QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    // Needed by QWebPage
    QScopedPointer<QApplication> app(new QApplication(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    QTranslator translator;
    translator.load(QLocale::system(), "harbour-lyrics", "-", SailfishApp::pathTo("translations").toLocalFile());
    app->installTranslator(&translator);

    QCoreApplication::setApplicationName(QStringLiteral("harbour-lyrics"));
    QCoreApplication::setOrganizationName(QStringLiteral("andreascarpino.it"));

    LyricsManager manager;
    view->rootContext()->setContextProperty("manager", &manager);

    view->setSource(SailfishApp::pathTo("qml/Lyrics.qml"));
    view->show();

    return app->exec();
}
