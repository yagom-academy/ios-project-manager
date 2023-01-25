//
//  CustomTableHeader.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/18.
//

import UIKit

class CustomTableHeader: UIView {
    @IBOutlet var contentsView: UIView!
    @IBOutlet weak var taskStatusLabel: UILabel!
    @IBOutlet weak var taskCountView: UIView!
    @IBOutlet weak var taskCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setHeaderViewColor()
        setContentsViewShape()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib(nib: "CustomTableHeader") else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self,
                               options: nil).first as? UIView
    }
    
    private func setHeaderViewColor() {
        contentsView.backgroundColor = Preset.defaultBackground
    }
    
    private func setContentsViewShape() {
        taskCountView.layer.cornerRadius = taskCountView.frame.width / 2
    }
    
    func setTaskCountLabel(_ viewModel: TaskListViewModel,
                           status: Status) {
        taskStatusLabel.text = status.rawValue
        switch status {
        case .todo:
            taskCountLabel.text = String(viewModel.todoTasks.count)
        case .doing:
            taskCountLabel.text = String(viewModel.doingTasks.count)
        case .done:
            taskCountLabel.text = String(viewModel.doneTasks.count)
        }
    }
}
