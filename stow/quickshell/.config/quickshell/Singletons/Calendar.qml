pragma Singleton

import Quickshell

import QtQuick

Singleton {
    id: root
    property int currentYear: new Date().getFullYear()
    property int currentMonth: new Date().getMonth()
    property int currentDay: new Date().getDate()

    property var monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    property var dayNamesShort: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

    property var grid: root.generateGrid()

    function daysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate();
    }

    function getFirstDayOfMonth(year, month) {
        return new Date(year, month, 1).getDay();
    }

    function generateGrid() {
        var days = daysInMonth(currentYear, currentMonth);
        var firstDayOfWeek = getFirstDayOfMonth(currentYear, currentMonth);

        var gridData = [];
        var dayCounter = 1;

        for (var i = 0; i < firstDayOfWeek; i++) {
            gridData.push("");
        }

        for (var j = 1; j <= days; j++) {
            gridData.push(j.toString());
        }

        return gridData;
    }

    function refresh() {
        const today = new Date();
        root.currentYear = today.getFullYear();
        root.currentMonth = today.getMonth();
        root.currentDay = today.getDate();
        root.grid = root.generateGrid();
    }
}
