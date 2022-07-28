//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class MainViewController: UIViewController {
    private let todoHeaderView = HeaderView(ListType.todo)
    private let doingHeaderView = HeaderView(ListType.doing)
    private let doneHeaderView = HeaderView(ListType.done)
    
    private lazy var todoTableView = listTableView()
    private lazy var doingTableView = listTableView()
    private lazy var doneTableView = listTableView()
    
    private let viewModel: MainViewModelInOut
    private let container: Container
    private var disposebag = DisposeBag()
    
    init(viewModel: MainViewModelInOut, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
    }
    
    private func setInitialView() {
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(navigationStackView)
        self.view.addSubview(mainStackView)
        self.view.addSubview(bottomStackView)
        
        navigationStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        historyButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        stateImage.snp.makeConstraints {
            $0.width.equalTo(13)
            $0.height.equalTo(13)
        }
        
        addButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(navigationStackView.snp.bottom).inset(-5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(bottomStackView.snp.top).inset(-20)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        bindView()
    }
    
    private func bindView() {
        bindTableView()
        
        addButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchAddButton()
            })
            .disposed(by: disposebag)
        
        historyButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchHistoryButton()
            })
            .disposed(by: disposebag)
        
        viewModel.showAddView.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.present(self.container.makeAddViewController(), animated: true)
        })
        .disposed(by: disposebag)
        
        viewModel.showHistoryView.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            
            let historyVC = self.container.makeHistoryViewController(sourceView: self.view,
                                                                     bounds: self.historyButton.bounds)
            self.present(historyVC, animated: true)
            print($0) // 추후 삭제 예정
        }).disposed(by: disposebag)
        
        viewModel.showErrorAlert.bind(onNext: { [weak self] in
            self?.showErrorAlert(messege: $0)
        })
        .disposed(by: disposebag)
        
        viewModel.showNetworkErrorAlert.bind(onNext: { [weak self] in
            self?.showNetworkErrorAlert()
        })
        .disposed(by: disposebag)
        
        viewModel.isConnectedInternet.bind(onNext: { [weak self] in
            self?.networkLabel.text = $0 ? "Online" : "Offline"
            self?.stateImage.tintColor = $0 ? .green : .red
        })
        .disposed(by: disposebag)
    }
    
    private func bindTableView() {
        bindTableView(todoTableView,
                      list: viewModel.todoList,
                      headerView: todoHeaderView,
                      type: .todo)
        bindTableView(doingTableView,
                      list: viewModel.doingList,
                      headerView: doingHeaderView,
                      type: .doing)
        bindTableView(doneTableView,
                      list: viewModel.doneList,
                      headerView: doneHeaderView,
                      type: .done)
    }
    
    private func bindTableView(_ tableView: UITableView, list: Driver<[ListItem]>, headerView: HeaderView, type: ListType) {
        list
            .drive(tableView.rx.items(cellIdentifier: "\(ListTableViewCell.self)", cellType: ListTableViewCell.self)) { [weak self] index, item, cell in
                guard let self = self else {
                    return
                }
                
                cell.setViewContents(item, isOver: self.viewModel.isOverDeadline(listItem: item))
            }
            .disposed(by: disposebag)
        
        viewModel.listCount(type)
            .drive(headerView.countLabel.rx.text)
            .disposed(by: disposebag)
        
        tableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCell(index: $0.row, type: type)
                tableView.deselectRow(at: $0, animated: true)
            })
            .disposed(by: disposebag)
        
        viewModel.showEditView
            .bind(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.present(self.container.makeEditViewController($0), animated: true)
            })
            .disposed(by: disposebag)
        
        tableView.rx.itemDeleted
            .bind(onNext: {
                self.viewModel.deleteCell(index: $0.row, type: type)
            })
            .disposed(by: disposebag)
        
        tableView.rx.longPressGesture()
            .when(.began)
            .bind(onNext: { [weak self] in
                let location = $0.location(in: tableView)
                
                self?.showAlert(location: location, tableView: tableView, type: type)
            })
            .disposed(by: disposebag)
    }
    
    private func makeAlert(index: Int, type: ListType) -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: type.firstDirection.title,
                                        style: .default) { [weak self] _ in
            self?.viewModel.changeItemType(index: index,
                                           type: type,
                                           to: type.firstDirection.type)
        }
        
        let secondAction = UIAlertAction(title: type.secondDirection.title,
                                         style: .default) { [weak self] _ in
            self?.viewModel.changeItemType(index: index,
                                           type: type,
                                           to: type.secondDirection.type)
        }
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        return alert
    }
    
    private func showAlert(location: CGPoint, tableView: UITableView, type: ListType) {
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let alert = makeAlert(index: indexPath.row, type: type)
        
        guard let popoverPresentationController = alert.popoverPresentationController else {
            return
        }
        
        popoverPresentationController.sourceView = cell
        
        let shouldShowBelow = location.y < UIScreen.main.bounds.height * 3 / 5
        let yPosition = cell.bounds.height / 2
        
        popoverPresentationController.sourceRect = CGRect(x: 0,
                                                          y: shouldShowBelow ? -yPosition : yPosition,
                                                          width: cell.bounds.width,
                                                          height: cell.bounds.height)
        popoverPresentationController.permittedArrowDirections = shouldShowBelow ? .up : .down
        
        self.present(alert, animated: true)
    }
    
    // MARK: - UI Components
    
    // MARK: - navigationStackView
    private lazy var navigationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [historyButton, titleLabel, addButton])
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.setTitle("History", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Project Manager"
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    // MARK: - mainStackView
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[listStackView(headerView: todoHeaderView,
                                                                    tableView: todoTableView),
                                                      listStackView(headerView: doingHeaderView,
                                                                    tableView: doingTableView),
                                                      listStackView(headerView: doneHeaderView,
                                                                    tableView: doneTableView)])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    private func listStackView(headerView: HeaderView, tableView: UITableView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [headerView,
                                                       tableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }
    
    private func listTableView() -> UITableView {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tableView.backgroundColor = .systemGray6
        tableView.register(ListTableViewCell.self)
        
        return tableView
    }
    
    // MARK: - bottomStackView
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [networkStackView, rightButtonStackView])
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var networkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [networkLabel, stateImage, UILabel()])
        
        return stackView
    }()
    
    private lazy var networkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.text = "Offline"
        
        return label
    }()
    
    private lazy var stateImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "circle.fill"))
        imageView.tintColor = .red
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        
        return imageView
    }()
    
    private lazy var rightButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [undoButton, redoButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
    
    private lazy var redoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Redo", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
}
