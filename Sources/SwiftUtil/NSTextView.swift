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

    func wrapText(_ isWrapped: Bool) {
        guard let scrollView = enclosingScrollView else { return }
        scrollView.hasHorizontalScroller = !isWrapped
        isHorizontallyResizable = !isWrapped
        let width = isWrapped ? Int(scrollView.contentSize.width) : Int.max
        maxSize = NSSize(width: width, height: Int.max)
        textContainer?.size = NSSize(width: width, height: Int.max)
        textContainer?.widthTracksTextView = isWrapped
    }
}
