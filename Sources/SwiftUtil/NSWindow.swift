import Cocoa

public extension NSWindow {
    func removeStandardButtons(buttons: [NSWindow.ButtonType]) {
        buttons.forEach {
            standardWindowButton($0)?.removeFromSuperview()
        }
    }
}
