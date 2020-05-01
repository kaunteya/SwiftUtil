import Cocoa

public extension NSView {
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

    @discardableResult
    func hidden() -> Self {
        isHidden = true
        return self
    }

    @discardableResult
    func wantsLayer() -> Self {
        wantsLayer = true
        return self
    }

    func toolTip(_ s: String) -> Self {
        toolTip = s; return self
    }
}
