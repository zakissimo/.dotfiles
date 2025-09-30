import Quickshell
pragma Singleton

Singleton {
    readonly property var list: Array.from(DesktopEntries.applications.values).sort((a, b) => {
        return a.name.localeCompare(b.name);
    })

    function getIcon(iconName) {
        if (!iconName || iconName.length == 0)
            return false;

        return Quickshell.iconPath(iconName, true);
    }

    function launch(app) {
        if (!app)
            return ;

        if (app.runInTerminal)
            Quickshell.execDetached(`/usr/bin/kitty --hold -e ${app.execString}`);
        else
            app.execute();
    }

    function exec(cmd) {
        if (!cmd)
            return ;

        Quickshell.execDetached(cmd);
    }

}
