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

// MARK: - Autolayout
public extension NSView {
    /// Sets height and width constraint
    func setSizeConstraints(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let w = width {
            widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = height {
            heightAnchor.constraint(equalToConstant: h).isActive = true
        }
    }

    /// Calls `setConstraints(left: 0, top: 0, right: 0, bottom: 0)`
    func setConstraintsEqualToSuperView() {
        setConstraints(left: 0, top: 0, right: 0, bottom: 0)
    }

    func setConstraints(inset: NSEdgeInsets) {
        setConstraints(left: inset.left, top: inset.top, right: inset.right, bottom: inset.bottom)
    }

    func setConstraints(left: CGFloat? = nil, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        precondition(superview != nil)

        translatesAutoresizingMaskIntoConstraints = false
        if let l = left {
            leftAnchor.constraint(equalTo: superview!.leftAnchor, constant: l).isActive = true
        }
        if let t = top {
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: t).isActive = true
        }
        if let r = right {
            rightAnchor.constraint(equalTo: superview!.rightAnchor, constant: r).isActive = true
        }
        if let b = bottom {
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: b).isActive = true
        }
        if let w = width {
            widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = height {
            heightAnchor.constraint(equalToConstant: h).isActive = true
        }
    }
}
