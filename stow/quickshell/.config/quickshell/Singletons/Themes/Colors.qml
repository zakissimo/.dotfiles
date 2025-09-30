import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    property string activeTheme: "rosePine"
    readonly property Theme theme: {
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

    Theme {
        id: rosePineTheme

        base: "#191724"
        surface: "#1f1d2e"
        overlay: "#26233a"
        muted: "#6e6a86"
        text: "#e0def4"
        foam: "#9ccfd8"
        rose: "#ebbcba"
        pine: "#31748f"
        iris: "#c4a7e7"
        highlightLow: "#21202e"
        highlightMed: "#403d52"
        highlightHigh: "#524f67"
    }

    Theme {
        id: darkTheme

        base: "#1e1e1e"
        surface: "#2d2d2d"
        overlay: "#3f3f3f"
        muted: "#7a7a7a"
        text: "#ffffff"
        foam: "#8be9fd"
        rose: "#ff79c6"
        pine: "#50fa7b"
        iris: "#bd93f9"
        highlightLow: "#282a36"
        highlightMed: "#44475a"
        highlightHigh: "#6272a4"
    }

    Theme {
        id: lightTheme

        base: "#ffffff"
        surface: "#f0f0f0"
        overlay: "#e0e0e0"
        muted: "#8a8a8a"
        text: "#000000"
        foam: "#2196f3"
        rose: "#e91e63"
        pine: "#4caf50"
        iris: "#9c27b0"
        highlightLow: "#fafafa"
        highlightMed: "#e6e6e6"
        highlightHigh: "#cccccc"
    }

    component Theme: QtObject {
        property color base
        property color surface
        property color overlay
        property color muted
        property color text
        property color foam
        property color rose
        property color pine
        property color iris
        property color highlightLow
        property color highlightMed
        property color highlightHigh
    }

}
