//
//  RelicIconManager.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/30/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import UIKit

class RelicIconManager {
    static let sharedInstance = RelicIconManager()
    
    // Public vars
    var count: Int {
        get {
            return iconArray.count
        }
    }
    
    
    // Private Vars
    private var iconArray = [UIImage]()
    
    func iconImageAtIndex(index: Int) -> UIImage {
        return iconArray[index]
    }
    
    
    init() {
        iconArray.append(RelicStyleKit.imageOfCanvas1())
        iconArray.append(RelicStyleKit.imageOfCanvas2())
        iconArray.append(RelicStyleKit.imageOfCanvas3())
        iconArray.append(RelicStyleKit.imageOfCanvas4())
        iconArray.append(RelicStyleKit.imageOfCanvas5())
        iconArray.append(RelicStyleKit.imageOfCanvas6())
        iconArray.append(RelicStyleKit.imageOfCanvas7())
        iconArray.append(RelicStyleKit.imageOfCanvas8())
        iconArray.append(RelicStyleKit.imageOfCanvas9())
        iconArray.append(RelicStyleKit.imageOfCanvas10())
        iconArray.append(RelicStyleKit.imageOfCanvas11())
        iconArray.append(RelicStyleKit.imageOfCanvas12())
        iconArray.append(RelicStyleKit.imageOfCanvas13())
        iconArray.append(RelicStyleKit.imageOfCanvas14())
        iconArray.append(RelicStyleKit.imageOfCanvas15())
        iconArray.append(RelicStyleKit.imageOfCanvas16())
        iconArray.append(RelicStyleKit.imageOfCanvas17())
        iconArray.append(RelicStyleKit.imageOfCanvas18())
        iconArray.append(RelicStyleKit.imageOfCanvas19())
        iconArray.append(RelicStyleKit.imageOfCanvas20())
        iconArray.append(RelicStyleKit.imageOfCanvas21())
        iconArray.append(RelicStyleKit.imageOfCanvas22())
        iconArray.append(RelicStyleKit.imageOfCanvas23())
        iconArray.append(RelicStyleKit.imageOfCanvas24())
        iconArray.append(RelicStyleKit.imageOfCanvas25())
        iconArray.append(RelicStyleKit.imageOfCanvas26())
        iconArray.append(RelicStyleKit.imageOfCanvas27())
        iconArray.append(RelicStyleKit.imageOfCanvas28())
    }
}
