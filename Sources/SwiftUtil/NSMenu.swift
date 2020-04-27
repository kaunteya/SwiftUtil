import Cocoa

public extension NSMenu {
    @discardableResult
    func add(_ title: String, action: Selector? = nil, keyEquivalent char: String = "", target: AnyObject? = nil, submenu: NSMenu? = nil) -> NSMenuItem {
        let item = addItem(withTitle: title, action: action, keyEquivalent: char)
        item.target = target
        item.submenu = submenu
        return item
    }

    func add(_ items: NSMenuItem...) {
        for i in items {
            add(i)
        }
    }

    func add(_ item: NSMenuItem) {
        addItem(item)
    }

    func addSeperator() {
        addItem(.separator())
    }
}

