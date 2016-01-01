//
//  IndexTitles.swift
//  CustomSectionIndexTitlesTest
//
//  Created by Tim Even on 01-01-16.
//  Copyright © 2016 evenwerk. All rights reserved.
//

import UIKit

class IndexTitles: UIControl,UIGestureRecognizerDelegate {
    
    var indexTitles:NSArray!
    var visualEffect: UIVisualEffectView!
    var index:Int!
    
    func translate(touch:CGFloat) {
        let selectedIndex = Int(touch / 18)
        let indexCount = indexTitles.count - 1
        
        if selectedIndex < 0 {
            index = 0
        }
        else if selectedIndex > indexCount {
            index = indexCount
        }
        else {
            index = selectedIndex
        }
        
        sendActionsForControlEvents(.ValueChanged)
    }
    
    //Sets the right index when the label is selected.
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        translate(touch.locationInView(self).y)
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        translate(touch.locationInView(self).y)
        return true
    }
    
    //Setup for when the view is being initialized.
    init(frame: CGRect, indexTitles:NSArray) {
        super.init(frame: frame)
        self.indexTitles = indexTitles
        
        let multiplier = 18
        
        visualEffect = UIVisualEffectView(frame: CGRectMake(0, 0, 18, CGFloat(multiplier * indexTitles.count)))
        visualEffect.effect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .ExtraLight))
        self.addSubview(visualEffect)
        
        for var i = 0; i < indexTitles.count; i++ {
            let label = UILabel(frame: CGRectMake(0, CGFloat(multiplier * i) , 20 , 18))
            label.font = UIFont.systemFontOfSize(12, weight: UIFontWeightSemibold)
            label.numberOfLines = 0
            label.textAlignment = .Center
            label.text = indexTitles[i] as? String
            visualEffect.contentView.addSubview(label)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

