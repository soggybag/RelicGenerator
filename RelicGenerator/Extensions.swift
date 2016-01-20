//
//  Extensions.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 11/13/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit
import GameplayKit

// MARK:
extension Int {
    // Make this a static function for Int
    static func randomRange(range: Int) -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
    }
}




// MARK: TabBar Helper For icon image

// Add anywhere in your app
extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}






// MARK: String Extensions

extension String {
    func stringToAttributedStringWithFontFamily(fontFamily: String, and fontSize: String) -> NSAttributedString {
        var html = self
        while let range = html.rangeOfString("\n") {
            html.replaceRange(range, with: "</br>")
        }
        
        html = "<span style='font-family: \(fontFamily); font-size:\(fontSize)'>"+html+"</span>"
        let data = html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)
        let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        return attrStr
    }
}

extension String {
    func stringToAttributedString() -> NSAttributedString {
        var html = self
        while let range = html.rangeOfString("\n") {
            html.replaceRange(range, with: "</br>")
        }
        
        html = "<span style='font-family: Helvetica; font-size:14pt'>"+html+"</span>"
        let data = html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)
        let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        return attrStr
    }
}



// MARK: Layer Extensions

extension CAGradientLayer {
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
        let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
    
    /*
    func simpleGradientWithColors(colors: [CGColor], and locations: [Float]) -> CAGradientLayer {
    let gradientColors: [CGColor] = colors
    let gradientLocations: [Float] = locations
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.colors = gradientColors
    gradientLayer.locations = gradientLocations
    
    return gradientLayer
    }
    */
}


// MARK: Int Extension 

extension Int {
    func toBool() -> Bool? {
        switch self {
        case 0:
            return false
        case 1:
            return true
        default :
            return nil
        }
    }
}


// MARK: Array Extension 

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}