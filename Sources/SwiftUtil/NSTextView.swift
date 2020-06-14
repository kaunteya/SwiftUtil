import Cocoa

public extension NSTextView {
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

    var wrapsLines: Bool {
        get {
            return self.textContainer?.widthTracksTextView ?? false
        }
        set {
            guard
                newValue != self.wrapsLines,
                let scrollView = enclosingScrollView,
                let textContainer = self.textContainer
                else { return }

            scrollView.hasHorizontalScroller = !newValue
            isHorizontallyResizable = !newValue
            textContainer.widthTracksTextView = newValue

            if newValue {
                self.frame.size[keyPath: \NSSize.width] = scrollView.contentSize.width
                maxSize = NSSize(width: scrollView.contentSize.width, height: CGFloat.greatestFiniteMagnitude)
                textContainer.size.width = scrollView.contentSize.width
            } else {
                let infiniteSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
                maxSize = infiniteSize
                textContainer.size = infiniteSize
            }
        }
    }
}
