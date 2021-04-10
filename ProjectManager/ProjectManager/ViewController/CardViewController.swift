//
//  CardViewController.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/09.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionsTextView: UITextView!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    
    var card: Card?
    private let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let card = card {
            navigationBar.topItem?.leftBarButtonItem = editButton
            titleTextView.text = card.title
            if let descriptions = card.descriptions {
                descriptionsTextView.text = descriptions
            } else {
                descriptionsTextView.text = ""
            }
            if let deadlineDate = card.deadlineDate {
                deadlineDatePicker.date = deadlineDate
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
