import Cocoa

public extension NSMutableParagraphStyle {
    convenience init(lineSpacing: CGFloat) {
        self.init()
        self.lineSpacing = lineSpacing
    }
}
