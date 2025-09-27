pragma Singleton

import Quickshell

Singleton {

    readonly property list<DesktopEntry> list: Array.from(DesktopEntries.applications.values).sort((a, b) => a.name.localeCompare(b.name))

    function getIcon(iconName) {
        if (!iconName || iconName.length == 0)
            return false;
        return Quickshell.iconPath(iconName, true);
    }

    function launch(app) {
        if (!app)
            return;

        if (app.runInTerminal) {
            Quickshell.execDetached(`/usr/bin/kitty --hold -e ${app.execString}`);
        } else {
            app.execute();
        }
    }

    function exec(cmd) {
        if (!cmd)
            return;

        Quickshell.execDetached(cmd);
    }
}
