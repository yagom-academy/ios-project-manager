//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import UIKit
import RealmSwift

final class PopoverView: UIView {
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            moveToToDoButton,
            moveToDoingButton,
            moveToDoneButton
        ]).then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
    
    private(set) lazy var moveToToDoButton = generatePopoverButton(title: "Move to TODO")
    private(set) lazy var moveToDoingButton = generatePopoverButton(title: "Move to DOING")
    private(set) lazy var moveToDoneButton = generatePopoverButton(title: "Move to DONE")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func generatePopoverButton(title: String) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        return button
    }
}

final class PopoverViewController: UIViewController {
    private let popoverView = PopoverView(frame: .zero)
    private let realm = try? Realm()
    weak var delegate: DataReloadable?
    var task: Task?
    
    override func loadView() {
        super.loadView()
        view = popoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetButtons()
    }
    
    private func addTargetButtons() {
        popoverView.moveToToDoButton.addTarget(
            self,
            action: #selector(moveToToDo),
            for: .touchUpInside
        )
        popoverView.moveToDoingButton.addTarget(
            self,
            action: #selector(moveToDoing),
            for: .touchUpInside
        )
        popoverView.moveToDoneButton.addTarget(
            self,
            action: #selector(moveToDone),
            for: .touchUpInside
        )
    }
    
    func setPopoverAction() {
        guard let task = task else { return }
        switch task.taskType {
        case .todo:
            popoverView.moveToToDoButton.isHidden = true
        case .doing:
            popoverView.moveToDoingButton.isHidden = true
        case .done:
            popoverView.moveToDoneButton.isHidden = true
        }
    }
    
    @objc private func moveToToDo() {
        modifiedTaskType(taskType: .todo)
    }
    
    @objc private func moveToDoing() {
        modifiedTaskType(taskType: .doing)
    }
    
    @objc private func moveToDone() {
        modifiedTaskType(taskType: .done)
    }
    
    private func modifiedTaskType(taskType: TaskType) {
        guard let task = task else { return }
        try? realm?.write {
            task.taskType = taskType
            realm?.add(task, update: .modified)
        }
        dismiss(animated: true) { [weak self] in
            self?.delegate?.refreshData()
        }
    }
}
