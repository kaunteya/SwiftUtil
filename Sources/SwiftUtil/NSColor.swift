import Cocoa
public extension NSColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }

    static var random: NSColor {
        let red = UInt32.random(in: 0...255)
        let green = UInt32.random(in: 0...255)
        let blue = UInt32.random(in: 0...255)
        let color = NSColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
        return color
    }
}
