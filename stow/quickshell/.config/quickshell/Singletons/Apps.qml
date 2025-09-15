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

        console.log("Launching app:", app.name);
        if (app.runInTerminal) {
            console.log("full cmd:", `/usr/bin/kitty --hold -e ${app.execString}`);
            Quickshell.execDetached(`/usr/bin/kitty --hold -e ${app.execString}`);
        } else {
            app.execute();
        }
    }

    function exec(cmd) {
        if (!cmd)
            return;

        console.log("Executing cmd:", cmd);
        Quickshell.execDetached(cmd);
    }
}
