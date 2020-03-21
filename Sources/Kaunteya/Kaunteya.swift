extension Collection {
    var secondLast: Element? { dropLast().last }
    var isNotEmpty: Bool { !isEmpty }
}

#if os(macOS)
import Cocoa
extension NSView {
    // Avoid using isHidden on NSView. Use an enum instead
    enum Visibility { case visible, hidden }
    var visiblity: Visibility {
        get {
            return isHidden ? .hidden : .visible
        }
        set {
            isHidden = (newValue == .hidden)
        }
    }
}

extension NSMenuItem {
    convenience init(
        _ string: String = "",
        image: NSImage? = nil,
        action selector: Selector? = nil,
        keyEquivalent charCode: String = "",
        target: AnyObject? = nil,
        submenu: NSMenu? = nil
        ) {
        self.init(title: string, action: selector, keyEquivalent: charCode)
        self.image = image
        self.target = target
        self.submenu = submenu
    }
}

extension NSMenu {
    func add(_ title: String, action: Selector? = nil, keyEquivalent char: String = "", target: AnyObject? = nil, submenu: NSMenu? = nil) {
        let item = addItem(withTitle: title, action: action, keyEquivalent: char)
        item.target = target
        item.submenu = submenu
    }

    func add(_ item: NSMenuItem) {
        addItem(item)
    }

    func addSeperator() {
        addItem(.separator())
    }
}
#endif
