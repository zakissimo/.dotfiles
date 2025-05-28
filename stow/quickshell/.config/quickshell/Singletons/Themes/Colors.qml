pragma Singleton

import QtQuick

import Quickshell

Singleton {
    id: root

    property string activeTheme: "rosePine"

    QtObject {
        id: rosePineTheme
        property color base: "#191724"
        property color surface: "#1f1d2e"
        property color overlay: "#26233a"
        property color muted: "#6e6a86"
        property color text: "#e0def4"
        property color foam: "#9ccfd8"
        property color rose: "#ebbcba"
        property color pine: "#31748f"
        property color iris: "#c4a7e7"
        property color highlightLow: "#21202e"
        property color highlightMed: "#403d52"
        property color highlightHigh: "#524f67"
    }

    QtObject {
        id: darkTheme
        property color base: "#1e1e1e"
        property color surface: "#2d2d2d"
        property color overlay: "#3f3f3f"
        property color muted: "#7a7a7a"
        property color text: "#ffffff"
        property color foam: "#8be9fd"
        property color rose: "#ff79c6"
        property color pine: "#50fa7b"
        property color iris: "#bd93f9"
        property color highlightLow: "#282a36"
        property color highlightMed: "#44475a"
        property color highlightHigh: "#6272a4"
    }

    QtObject {
        id: lightTheme
        property color base: "#ffffff"
        property color surface: "#f0f0f0"
        property color overlay: "#e0e0e0"
        property color muted: "#8a8a8a"
        property color text: "#000000"
        property color foam: "#2196f3"
        property color rose: "#e91e63"
        property color pine: "#4caf50"
        property color iris: "#9c27b0"
        property color highlightLow: "#fafafa"
        property color highlightMed: "#e6e6e6"
        property color highlightHigh: "#cccccc"
    }

    readonly property QtObject theme: {
        switch (activeTheme) {
        case "dark":
            return darkTheme;
        case "light":
            return lightTheme;
        default:
            return rosePineTheme;
        }
    }

    property color base: theme.base
    property color surface: theme.surface
    property color overlay: theme.overlay
    property color muted: theme.muted
    property color text: theme.text
    property color foam: theme.foam
    property color rose: theme.rose
    property color pine: theme.pine
    property color iris: theme.iris
    property color highlightLow: theme.highlightLow
    property color highlightMed: theme.highlightMed
    property color highlightHigh: theme.highlightHigh
}
