//
//  ViewController.swift
//  CustomSectionIndexTitlesTest
//
//  Created by Tim Even on 01-01-16.
//  Copyright © 2016 evenwerk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indexTitlesContainer: UIView!
    
    /* type to represent table items
    `section` stores a `UITableView` section */
    class User: NSObject {
        let name: String
        var section: Int?
        
        init(name: String) {
            self.name = name
        }
    }
    
    // custom type to represent table sections
    class Section {
        var users: [User] = []
        
        func addUser(user: User) {
            self.users.append(user)
        }
    }
    
    // raw user data
    let names = [
        "Clementine",
        "Tim",
        "Bessie",
        "Yolande",
        "Tynisha",
        "Ellyn",
        "Trudy",
        "Fredrick",
        "Letisha",
        "Ariel",
        "Bong",
        "Jacinto",
        "Dorinda",
        "Aiko",
        "Loma",
        "Augustina",
        "Margarita",
        "Jesenia",
        "Kellee",
        "Annis",
        "Charlena"
    ]
    
    // `UIKit` convenience class for sectioning a table
    let collation = UILocalizedIndexedCollation.currentCollation()
    
    
    // table sections
    var sections: [Section] {
        // return if already initialized
        if self._sections != nil {
            return self._sections!
        }
        
        // create users from the name list
        let users: [User] = names.map { name in
            let user = User(name: name)
            user.section = self.collation.sectionForObject(user, collationStringSelector: "name")
            return user
        }
        
        // create empty sections
        var sections = [Section]()
        for i in 0..<self.collation.sectionIndexTitles.count {
            sections.append(Section())
        }
        
        // put each user in a section
        for user in users {
            sections[user.section!].addUser(user)
        }
        
        // sort each section
        for section in sections {
            section.users = self.collation.sortedArrayFromArray(section.users, collationStringSelector: "name") as! [User]
        }
        
        self._sections = sections
        
        return self._sections!
        
    }
    var _sections: [Section]?
    
    var indexTitles: IndexTitles!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        indexTitles = IndexTitles(frame: CGRectZero, indexTitles: collation.sectionIndexTitles)
        
        indexTitles.addTarget(self, action: "indexViewValueChanged:", forControlEvents: .ValueChanged)
        indexTitlesContainer.addSubview(indexTitles)

    }
    
    func indexViewValueChanged(sender: IndexTitles) {
        print("perform function")
        var index = sender.index
        
        if self.sections[index].users.count == 0 {
            
            var shouldPerform = true
            
            for var i = index as Int; i < self.sections[index].users.count; i++ {
                if shouldPerform == true {
                    if self.sections[index].users.count != 0 {
                        shouldPerform = false
                        index = i
                    }
                }
            }
            
            for var i = index as Int; i > 0; i-- {
                if shouldPerform == true {
                    if self.sections[index].users.count != 0 {
                        shouldPerform = false
                        index = i
                    }
                }
            }
        }
        
        let path = NSIndexPath(forRow: 0, inSection: index)
        tableView.scrollToRowAtIndexPath(path, atScrollPosition: .Top, animated: false)
        
        let scrollPosition = tableView.contentOffset.y
        let collectionViewHeight = (tableView.contentSize.height - tableView.bounds.size.height) + 54
        
        if scrollPosition != collectionViewHeight {
            tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y - 22.0)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        let height = CGFloat(collation.sectionIndexTitles.count * 18)
        let y = (indexTitlesContainer.bounds.height - height) / 3
        indexTitles.frame = CGRectMake(0, y, indexTitlesContainer.bounds.width, height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].users.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collation.sectionIndexTitles[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let user = self.sections[indexPath.section].users[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = user.name
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}

