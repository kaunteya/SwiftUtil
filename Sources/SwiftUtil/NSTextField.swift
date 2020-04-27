import Cocoa

public extension NSTextField {
    func placeholderString(_ a: String) -> Self {
        placeholderString = a; return self
    }

    func backgroundColor(_ a: NSColor) -> Self {
        backgroundColor = a; return self
    }

    func textColor(_ a: NSColor) -> Self {
        textColor = a; return self
    }

    func bordered(_ a: Bool) -> Self {
        isBordered = a; return self
    }

    func bezeled(_ a: Bool) -> Self {
        isBezeled = a; return self
    }

    func editable(_ a: Bool) -> Self {
        isEditable = a; return self
    }

    func selectable(_ a: Bool) -> Self {
        isSelectable = a; return self
    }
}
