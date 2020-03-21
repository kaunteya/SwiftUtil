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

extension NSColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
}

extension NSMutableParagraphStyle {
    convenience init(lineSpacing: CGFloat) {
        self.init()
        self.lineSpacing = lineSpacing
    }
}

extension NSStoryboard {
    static var main: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }

    func viewController<T>(_ id: String) -> T where T: NSViewController {
        return instantiateController(withIdentifier: id) as! T
    }

    func windowController<T>(_ id: String) -> T where T: NSWindowController {
        return instantiateController(withIdentifier: id) as! T
    }
}

extension NSSplitView {
    // TODO: Get rid of this. Find alternatives
    var dividerView: NSView {
        let view = subviews.first { $0.className == "NSSplitDividerView" }
        if view == nil {
        }
        return view!
    }

    var dividerViewPosition: CGFloat {
        dividerView.convert(CGPoint.zero, to: self).x
    }
}

extension NSStackView {
    func removeAllArrangedViews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    func spacing(_ val: CGFloat) -> NSStackView {
        self.spacing = val
        return self
    }

    func orientation(_ val: NSUserInterfaceLayoutOrientation) -> NSStackView {
        self.orientation = val
        return self
    }

    func alignment(_ val: NSLayoutConstraint.Attribute) -> NSStackView {
        self.alignment = val
        return self
    }

    func distribution(_ val: NSStackView.Distribution) -> NSStackView {
        self.distribution = val
        return self
    }
}

class VStack: NSStackView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.orientation = .vertical
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.orientation = .vertical
    }
}

class HStack: NSStackView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.orientation = .horizontal
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.orientation = .horizontal
    }
}


extension NSTextView {
    var contentSize: CGSize {
        guard let layoutManager = layoutManager, let textContainer = textContainer else {
            print("textView no layoutManager or textContainer")
            return .zero
        }

        layoutManager.ensureLayout(for: textContainer)
        return layoutManager.usedRect(for: textContainer).size
    }

    func clearSelection() {
        setSelectedRange(NSRange(location: 0, length: 0))
    }

    var selectedText: String {
        String(string[selectedRange()])
    }
}

extension NSWindow {
    func removeStandardButtons(buttons: [NSWindow.ButtonType]) {
        buttons.forEach {
            standardWindowButton($0)?.removeFromSuperview()
        }
    }
}
