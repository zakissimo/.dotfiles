pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root
    // Today's date for highlighting
    property int todayYear: new Date().getFullYear()
    property int todayMonth: new Date().getMonth()
    property int todayDay: new Date().getDate()

    property int currentYear: todayYear
    property int currentMonth: todayMonth
    property int currentDay: todayDay

    property var monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    property var dayNamesShort: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

    property var grid: []

    property bool isCurrentMonth: currentYear === todayYear && currentMonth === todayMonth

    Process {
        id: calProcess
        command: ["cal", (currentMonth + 1).toString(), currentYear.toString()]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.parseCalOutput(text);
            }
        }

        onExited: {
            if (exitCode !== 0) {
                console.error("cal command failed with exit code:", exitCode);
                // Fallback to old method if cal fails
                root.generateGridFallback();
            }
        }
    }

    onCurrentMonthChanged: {
        calProcess.running = false;
        calProcess.running = true;
        isCurrentMonth = currentYear === todayYear && currentMonth === todayMonth;
    }

    onCurrentYearChanged: {
        calProcess.running = false;
        calProcess.running = true;
        isCurrentMonth = currentYear === todayYear && currentMonth === todayMonth;
    }

    function parseCalOutput(output) {
        var lines = output.split('\n');
        if (lines.length < 3) {
            generateGridFallback();
            return;
        }

        // Skip the header (month year) and day names
        var calendarLines = lines.slice(2);

        var gridData = [];
        for (var i = 0; i < calendarLines.length; i++) {
            var line = calendarLines[i];
            // Each day is 3 characters, but line might be shorter
            for (var j = 0; j < 7; j++) {
                var start = j * 3;
                if (start >= line.length) {
                    gridData.push("");
                } else {
                    var dayStr = line.substr(start, 3).trim();
                    gridData.push(dayStr === "" ? "" : dayStr);
                }
            }
        }

        // Remove trailing empty rows
        while (gridData.length >= 7) {
            var lastWeekStart = gridData.length - 7;
            var isEmptyWeek = true;
            for (var k = lastWeekStart; k < gridData.length; k++) {
                if (gridData[k] !== "") {
                    isEmptyWeek = false;
                    break;
                }
            }
            if (isEmptyWeek) {
                gridData.splice(lastWeekStart, 7);
            } else {
                break;
            }
        }

        root.grid = gridData;
    }

    function generateGridFallback() {
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

        // Calculate number of weeks needed
        var totalCells = Math.ceil((firstDayOfWeek + days) / 7) * 7;
        while (gridData.length < totalCells) {
            gridData.push("");
        }

        // Remove trailing empty rows
        while (gridData.length >= 7) {
            var lastWeekStart = gridData.length - 7;
            var isEmptyWeek = true;
            for (var k = lastWeekStart; k < gridData.length; k++) {
                if (gridData[k] !== "") {
                    isEmptyWeek = false;
                    break;
                }
            }
            if (isEmptyWeek) {
                gridData.splice(lastWeekStart, 7);
            } else {
                break;
            }
        }

        root.grid = gridData;
    }

    function daysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate();
    }

    function getFirstDayOfMonth(year, month) {
        return new Date(year, month, 1).getDay();
    }

    function nextMonth() {
        if (currentMonth === 11) {
            currentYear++;
            currentMonth = 0;
        } else {
            currentMonth++;
        }
        calProcess.running = false;
        calProcess.running = true;
    }

    function prevMonth() {
        if (currentMonth === 0) {
            currentYear--;
            currentMonth = 11;
        } else {
            currentMonth--;
        }
        calProcess.running = false;
        calProcess.running = true;
    }

    function refresh() {
        const today = new Date();
        root.todayYear = today.getFullYear();
        root.todayMonth = today.getMonth();
        root.todayDay = today.getDate();
        root.currentYear = today.getFullYear();
        root.currentMonth = today.getMonth();
        root.currentDay = today.getDate();
        calProcess.running = false;
        calProcess.running = true;
    }
}
