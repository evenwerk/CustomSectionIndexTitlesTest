//
//  SplitViewController.swift
//  CustomSectionIndexTitlesTest
//
//  Created by Tim Even on 01-01-16.
//  Copyright © 2016 evenwerk. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    override func viewDidLoad() {
        self.presentsWithGesture = false
        self.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
}
