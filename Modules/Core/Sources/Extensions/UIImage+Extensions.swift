import UIKit

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let cgImage = UIGraphicsImageRenderer(size: size).image { renderer in
            renderer.cgContext.setFillColor(color.cgColor)
            renderer.fill(CGRect(origin: .zero, size: size))
        }.cgImage
        guard let cgImage = cgImage else { return nil }
        self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
    }

    var averageColor: UIColor? {
        func red(for pixelData: UInt32) -> UInt8 { UInt8((pixelData >> 16) & 255) }
        func green(for pixelData: UInt32) -> UInt8 { UInt8((pixelData >> 8) & 255) }
        func blue(for pixelData: UInt32) -> UInt8 { UInt8((pixelData >> 0) & 255) }

        guard let cgImage = cgImage else { return nil }
        let size = CGSize(width: 40, height: 40)
        let width = Int(size.width)
        let height = Int(size.height)
        let totalPixels = width * height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue |
            CGImageAlphaInfo.premultipliedFirst.rawValue
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else { return nil }
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let pixelBuffer = context.data else { return nil }
        let pointer = pixelBuffer.bindMemory(to: UInt32.self, capacity: width * height)
        var totalRed = 0
        var totalBlue = 0
        var totalGreen = 0
        for coordinateX in 0 ..< width {
            for coordinateY in 0 ..< height {
                let pixel = pointer[(coordinateY * width) + coordinateX]
                let red = red(for: pixel)
                let green = green(for: pixel)
                let blue = blue(for: pixel)
                totalRed += Int(red)
                totalBlue += Int(blue)
                totalGreen += Int(green)
            }
        }
        let averageRed: CGFloat
        let averageGreen: CGFloat
        let averageBlue: CGFloat
        averageRed = CGFloat(totalRed) / CGFloat(totalPixels)
        averageGreen = CGFloat(totalGreen) / CGFloat(totalPixels)
        averageBlue = CGFloat(totalBlue) / CGFloat(totalPixels)
        return UIColor(red: averageRed / 255.0, green: averageGreen / 255.0, blue: averageBlue / 255.0, alpha: 1.0)
    }
}
