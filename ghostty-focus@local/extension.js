import Gio from 'gi://Gio';

const IFACE = `
<node>
  <interface name="org.gnome.Shell.Extensions.GhosttyRaise">
    <method name="Focus">
      <arg type="b" direction="out" name="found"/>
    </method>
  </interface>
</node>`;

export default class Extension {
    enable() {
        this._dbus = Gio.DBusExportedObject.wrapJSObject(IFACE, this);
        this._dbus.export(Gio.DBus.session, '/org/gnome/Shell/Extensions/GhosttyRaise');
    }

    disable() {
        this._dbus?.unexport();
        this._dbus = null;
    }

    Focus() {
        const win = global.get_window_actors()
            .map(a => a.meta_window)
            .find(w => w.get_wm_class()?.toLowerCase().includes('ghostty'));

        if (win) {
            win.activate(global.get_current_time());
            return true;
        }
        return false;
    }
}
