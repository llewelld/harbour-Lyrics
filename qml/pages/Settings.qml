/*
  The MIT License (MIT)

  Copyright (c) 2014-2015 Andrea Scarpino <me@andreascarpino.it>

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

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    allowedOrientations: Orientation.All

    Column {
        width: parent.width

        PageHeader {
            title: qsTr("Settings")
        }

        ComboBox {
            id: provider
            width: parent.width
            label: qsTr("Provider")

            menu: ContextMenu {

                MenuItem {
                    text: "ChartLyrics"
                }

                MenuItem {
                    text: "Genius"
                }

                MenuItem {
                    text: "LyricsMania"
                }

                MenuItem {
                    text: "LyricsWiki"
                }
            }
        }
    }

    Component.onCompleted: {
        var api = manager.getProvider();
        if (api === "ChartLyrics") {
            provider.currentIndex = 0;
        } else if (api === "Genius") {
            provider.currentIndex = 1;
        } else if (api === "LyricsMania") {
            provider.currentIndex = 2;
        } else {
            provider.currentIndex = 3;
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Deactivating) {
            switch (provider.currentIndex) {
            case 0: manager.setProvider("ChartLyrics"); break;
            case 1: manager.setProvider("Genius"); break;
            case 2: manager.setProvider("LyricsMania"); break;
            case 3:
            default: manager.setProvider("LyricsWiki");
            }
        }
    }
}
