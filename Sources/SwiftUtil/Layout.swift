import Cocoa

public class Layout {
    private let v: NSView
    // OtherView is nil because size constraints dont need it
    private let otherView: NSView?
    public init(_ v: NSView, _ otherView: NSView? = nil) {
        self.v = v
        self.v.translatesAutoresizingMaskIntoConstraints = false
        self.otherView = otherView ?? v.superview
    }

    var constraints = [NSLayoutConstraint]()
    @discardableResult public func top(_ i: CGFloat = 0) -> Self {
        constraints.append(v.topAnchor.constraint(equalTo: otherView!.topAnchor, constant: i))
        return self
    }
    @discardableResult public func right(_ i: CGFloat = 0) -> Self {
        constraints.append(v.rightAnchor.constraint(equalTo: otherView!.rightAnchor, constant: i))
        return self
    }
    @discardableResult public func bottom(_ i: CGFloat = 0) -> Self {
        constraints.append(v.bottomAnchor.constraint(equalTo: otherView!.bottomAnchor, constant: i))
        return self
    }
    @discardableResult public func left(_ i: CGFloat = 0) -> Self {
        constraints.append(v.leftAnchor.constraint(equalTo: otherView!.leftAnchor, constant: i))
        return self
    }
    @discardableResult public func width(_ i: CGFloat = 0) -> Self {
        constraints.append(v.widthAnchor.constraint(equalToConstant: i))
        return self
    }
    @discardableResult public func centerX(_ i: CGFloat = 0) -> Self {
        constraints.append(v.centerXAnchor.constraint(equalTo: otherView!.centerXAnchor, constant: i))
        return self
    }
    @discardableResult public func centerY(_ i: CGFloat = 0) -> Self {
        constraints.append(v.centerYAnchor.constraint(equalTo: otherView!.centerYAnchor, constant: i))
        return self
    }
    @discardableResult public func center() -> Self {
        self.centerX(0).centerY(0)
    }
    @discardableResult public func height(_ i: CGFloat) -> Self {
        constraints.append(v.heightAnchor.constraint(equalToConstant: i))
        return self
    }
    @discardableResult public func size(_ i: CGFloat) -> Self {
        self.width(i).height(i)
        return self
    }
    
    /// Other view can be superview
    @discardableResult public func equalViews(_ i: CGFloat = 0) -> Self {
        self.top(i).right(-i).bottom(-i).left(i)
    }
}

public extension NSView {
    func applyConstraints(layout: Layout) {
        assert(translatesAutoresizingMaskIntoConstraints == false)
        NSLayoutConstraint.activate(layout.constraints)
    }

    func applyConstraints(layout: (Layout) -> Layout) {
        applyConstraints(layout: layout(Layout(self)))
    }

    func addSubview(_ v: NSView, layout: (Layout) -> Layout) {
        addSubview(v)
        let edges = layout(Layout(v))
        NSLayoutConstraint.activate(edges.constraints)
    }

    func addSubview(_ v: NSView, handler: () -> Layout) {
        addSubview(v)
        let edges = handler()
        NSLayoutConstraint.activate(edges.constraints)
    }
}

public extension NSStackView {
    func addArrangedSubview(_ v: NSView, layout: (Layout) -> Layout) {
        self.addArrangedSubview(v)
        let edges = layout(Layout(v))
        NSLayoutConstraint.activate(edges.constraints)
    }
}
