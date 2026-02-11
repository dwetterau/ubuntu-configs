import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export default class Extension {
    enable() {
        const dialog = Main.endSessionDialog;
        if (dialog)
            dialog._secondsLeft = 0;
    }

    disable() {}
}
