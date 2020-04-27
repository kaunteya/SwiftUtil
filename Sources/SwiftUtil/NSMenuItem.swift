import Cocoa

public extension NSMenuItem {
    convenience init(
        _ string: String = "",
        image: NSImage? = nil,
        action selector: Selector? = nil,
        keyEquivalent charCode: String = "",
        target: AnyObject? = nil,
        representedObject: Any? = nil,
        submenu: NSMenu? = nil
        ) {
        self.init(title: string, action: selector, keyEquivalent: charCode)
        self.image = image
        self.target = target
        self.submenu = submenu
        self.representedObject = representedObject
    }

    func title(_ str: String) -> NSMenuItem {
        self.title = str
        return self
    }

    func image(_ image: NSImage) -> Self {
        self.image = image
        return self
    }

    func action(_ s: Selector) -> Self {
        self.action = s
        return self
    }

    func target(_ t: AnyObject) -> Self {
        self.target = t
        return self
    }

    func keyEquivalent(_ k: String) -> Self {
        self.keyEquivalent = k
        return self
    }

    func subMenu(_ s: NSMenu) -> Self {
        self.submenu = s
        return self
    }

    func representedObject(_ a: Any) -> Self {
        self.representedObject = a
        return self
    }

    func tag(_ t: Int) -> Self {
        self.tag = t
        return self
    }

    func state(_ s: NSControl.StateValue) -> Self {
        self.state = s
        return self
    }
}
