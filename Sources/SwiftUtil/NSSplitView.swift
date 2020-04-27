import Cocoa

public extension NSSplitView {
    // TODO: Get rid of this. Find alternatives
    var dividerView: NSView {
        let view = subviews.first { $0.className == "NSSplitDividerView" }
        if view == nil {
        }
        return view!
    }

    var dividerViewPosition: CGFloat {
        dividerView.convert(CGPoint.zero, to: self).x
    }
}

