import Cocoa

public final class NSToast: NSView {
    public enum Location { case topLeft, topMiddle, topRight, middle, bottomLeft, bottomMiddle, bottomRight}

    enum `Type` {
        case info, success, warning, error
        static let dict: [Type: NSColor] = [.error: .systemRed, .info: .systemGray, .success: .systemGreen, .warning: .systemOrange]

        var color: NSColor { Self.dict[self]! }
    }
    public enum Expiry { case timed(TimeInterval), indefinite}

    public static var (maxWidth, minWidth) = (CGFloat(500), CGFloat(200.0))
    public static var detailViewMaxHeight: CGFloat = 100
    public static var maxLinesInDetailView = 5
    private static var viewStack = NSStackView()
    public static var defaultExpiryTime: Expiry = .timed(4)
    public static var contentView = NSApplication.shared.mainWindow?.contentView
    public static var location: Location = .bottomRight {
        didSet {
            addButtonStackToContentView()
            let constraints = constraintsForLocation(location)
            NSLayoutConstraint.activate(constraints)
        }
    }

    private var closeButton: NSButton!
    var action: (() -> ())?

    private init(type: Type, title: String, detail: String? = nil, primaryAction: String? = nil, onAction: (() -> ())? = nil, expiry: Expiry) {
        super.init(frame: .zero)
        wantsLayer = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: Self.minWidth).isActive = true
        self.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor

        let messageTypeIndicatorBar = NSView(frame: .zero)
        messageTypeIndicatorBar.wantsLayer = true
        messageTypeIndicatorBar.layer?.backgroundColor = type.color.cgColor
        self.addSubview(messageTypeIndicatorBar) { $0.top(1).left(1).bottom(-1).width(1)}

        let titleLabel = NSTextField(labelWithString: title)
        let stack = NSStackView(views: [titleLabel])
        stack.alignment = .leading
        stack.orientation = .vertical
        stack.spacing = 3

        if let detail = detail, detail.isEmpty == false {
            let detTextField = NSTextField(labelWithString: detail)
                .textColor(.secondaryLabelColor)
                .fontSize(NSFont.smallSystemFontSize)
                .maxLines(Self.maxLinesInDetailView)
                .lineBreakingMode(.byWordWrapping)

            detTextField.preferredMaxLayoutWidth = Self.maxWidth
            detTextField.cell?.isScrollable = false
            stack.addArrangedSubview(detTextField) { $0.left(0).right(0)}
        }

        addSubview(stack) { $0.left(10).top(5).right(-22).bottom(-5)}

        if let primaryButtonString = primaryAction, primaryButtonString.isEmpty == false {
            let button = NSButton(title: primaryButtonString, target: self, action: #selector(primaryButtonTap(_:)))
            button.controlSize = .small
            button.font = .systemFont(ofSize: NSFont.smallSystemFontSize)
            stack.addArrangedSubview(button)
            action = onAction
        }

        if case Expiry.timed(let time) = expiry {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
                self?.removeFromSuperview()
            }
        }
        closeButton = NSButton(image: NSImage(named: NSImage.stopProgressTemplateName)!, target: self, action: #selector(self.closeButtonTap))
        closeButton.bezelStyle = .regularSquare
        closeButton.isTransparent = true
        addSubview(closeButton) { $0.top(3).right(-3).size(13)}
    }

    required init?(coder decoder: NSCoder) {
        fatalError()
    }


    @objc private func closeButtonTap(_ sender: NSButton) {
        removeFromSuperview()
    }

    @objc private func primaryButtonTap(_ sender: NSButton) {
        action?()
        removeFromSuperview()
    }

    public static func info(_ title: String, detail: String? = nil, primaryAction: String? = nil, onAction: (() -> ())? = nil, uniqueDisplayId: String? = nil, expiry: Expiry = defaultExpiryTime) {
        show(type: .info, title: title, detail: detail, primaryAction: primaryAction, onAction: onAction, uniqueDisplayId: uniqueDisplayId, expiry: expiry)
    }
    public static func success(_ title: String, detail: String? = nil, primaryAction: String? = nil, onAction: (() -> ())? = nil, uniqueDisplayId: String? = nil, expiry: Expiry = defaultExpiryTime) {
        show(type: .success, title: title, detail: detail, primaryAction: primaryAction, onAction: onAction, uniqueDisplayId: uniqueDisplayId, expiry: expiry)
    }
    public static func warning(_ title: String, detail: String? = nil, primaryAction: String? = nil, onAction: (() -> ())? = nil, uniqueDisplayId: String? = nil, expiry: Expiry = defaultExpiryTime) {
        show(type: .warning, title: title, detail: detail, primaryAction: primaryAction, onAction: onAction, uniqueDisplayId: uniqueDisplayId, expiry: expiry)
    }
    public static func error(_ title: String, detail: String? = nil, primaryAction: String? = nil, onAction: (() -> ())? = nil, uniqueDisplayId: String? = nil, expiry: Expiry = defaultExpiryTime) {
        show(type: .error, title: title, detail: detail, primaryAction: primaryAction, onAction: onAction, uniqueDisplayId: uniqueDisplayId, expiry: expiry)
    }

    private static func show(type: Type, title: String, detail: String?, primaryAction: String?, onAction: (() -> ())?, uniqueDisplayId: String?, expiry: Expiry) {
        if let uniqueDisplayId = uniqueDisplayId {
            let key = "NSToast \(uniqueDisplayId)"
            if UserDefaults.standard.string(forKey: key) != nil {
                return
            } else {
                UserDefaults.standard.set(true, forKey: key)
            }
        }

        addButtonStackToContentView()

        let toast = NSToast(type: type, title: title, detail: detail?.trimmingCharacters(in: .whitespacesAndNewlines), primaryAction: primaryAction, onAction: onAction, expiry: expiry)
        toast.shadow = NSShadow()
        toast.layer?.shadowOpacity = 0.3
        toast.layer?.shadowColor = NSColor.gray.cgColor
        toast.layer?.shadowRadius = 1

        viewStack.addArrangedSubview(toast)
    }

    private static func addButtonStackToContentView() {
        if viewStack.superview == nil {
            if let contentView = contentView {
                contentView.addSubview(viewStack)
                viewStack.orientation = .vertical
                viewStack.alignment = .trailing
                viewStack.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate(constraintsForLocation(self.location))
            }
        }
    }

    private static func constraintsForLocation(_ location: Location) -> [NSLayoutConstraint] {
        guard viewStack.arrangedSubviews.isEmpty else {
            print("Location cannot be changed unless stack is empty")
            return []
        }

        contentView?.constraints.forEach(contentView!.removeConstraint)
        switch location {
        case .bottomLeft:
            return [
                viewStack.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 10),
                viewStack.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -10)
            ]

        case .bottomMiddle:
            return [
            viewStack.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor),
            viewStack.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -10)
                ]

        case .bottomRight:
            return [
            viewStack.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -10),
            viewStack.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -10)
                ]

        case .middle:
            return [
            viewStack.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor),
            viewStack.centerYAnchor.constraint(equalTo: contentView!.centerYAnchor)
                ]

        case .topLeft:
            return [
            viewStack.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 10),
            viewStack.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 10)
                ]

        case .topMiddle:
            return [
            viewStack.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor),
            viewStack.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 10)
                ]

        case .topRight:
            return [
            viewStack.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -10),
            viewStack.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 10)
                ]
        }
    }
}
