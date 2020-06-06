import Cocoa

public extension NSControl {
    func action(_ a: Selector) -> Self {
        self.action = a
        return self
    }

    func tag(_ a: Int) -> Self {
        self.tag = a
        return self
    }

    func ignoresMultiClick(_ a: Bool) -> Self {
        self.ignoresMultiClick = a
        return self
    }

    func isContinuous(_ a: Bool) -> Self {
        self.isContinuous = a
        return self
    }

    func isEnabled(_ a: Bool) -> Self {
        self.isEnabled = a
        return self
    }

    func refusesFirstResponder(_ a: Bool) -> Self {
        self.refusesFirstResponder = a
        return self
    }

    func isHighlighted(_ a: Bool) -> Self {
        self.isHighlighted = a
        return self
    }

    func controlSize(_ a: NSControl.ControlSize) -> Self {
        self.controlSize = a
        return self
    }

    func stringValue(_ a: String) -> Self {
        stringValue = a; return self
    }
}

public extension NSControl.StateValue {
    var isOn: Bool { self == .on }

    var isOff: Bool { self == .off }

    mutating func toggle() {
        self = (self == .on) ? .off : .on
    }
}
