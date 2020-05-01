import Cocoa

public extension NSStackView {
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

    func setArrangedSubViews(_ views: [NSView]) {
        removeAllArrangedViews()
        views.forEach(addArrangedSubview)
    }
}

public class VStack: NSStackView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.orientation = .vertical
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.orientation = .vertical
    }
}

public class HStack: NSStackView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.orientation = .horizontal
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.orientation = .horizontal
    }
}

