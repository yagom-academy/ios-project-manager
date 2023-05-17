//
//  TodoView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit

protocol TodoViewDelegate: AnyObject {
    func dismiss()
}

final class TodoView: UIView {
    
    weak var delegate: TodoViewDelegate?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        configureView()
        configureNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
   
    private func configureNavigationBar() {
        let title = "TODO"
        let done = "Done"
        let cancel = "Cancel"
        
        let doneButton = UIBarButtonItem(title: done, style: .done, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationBar.items = [navigationItem]
        
        self.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
                                         
    @objc private func doneButtonTapped() {
        delegate?.dismiss()
    }
    
    @objc private func cancelButtonTapped() {
        delegate?.dismiss()
    }
    
}
