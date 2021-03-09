//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let listTableViews = [UITableView(), UITableView(), UITableView()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: SheetViewController.identifier) else {
            return
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        self.present(sheetViewController, animated: true, completion: nil)
    }
}
extension ViewController: UICollectionViewDelegate {
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTableViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidth = collectionView.frame.width / 3.08
        let collectionViewCellHeight = collectionView.frame.height
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
}

class CollectionViewCell: UICollectionViewCell {
    
}

class SheetViewController: UIViewController {
    @IBOutlet weak var modeButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier = "SheetViewController"
    
    private enum Mode {
        static let cancel = "Cancel"
        static let edit = "Edit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modeButtonItem.title = Mode.cancel
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        // 새로운 글 등록 or 기존의 글 수정 -> 내용 저장하기
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedModeButton(_ sender: UIBarButtonItem) {
        if sender.title == Mode.cancel {
            self.dismiss(animated: true, completion: nil)
        } else {
            sender.title = Mode.cancel
            //기존의 글 수정 및 Done -> update 내용 저장하기
        }
    }
}
