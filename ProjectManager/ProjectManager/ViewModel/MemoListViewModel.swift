//
//  MemoListViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

enum AccessMode {
    case add
    case read
    case write
    
    var isEditable: Bool {
        switch self {
        case .add, .write:
            return true
        case .read:
            return false
        }
    }
}

protocol MemoListViewModelInput {
    func viewOnAppear()
    func didTouchUpPlusButton()
    func didTouchUpDetailViewLeftButton()
    func didTouchUpDoneButton()
    func didSwipeCell(_ memo: MemoViewModel)
    func didTouchUpCell(_ memo: MemoViewModel)
    func didTouchUpPopoverButton(_ memo: MemoViewModel, newState: MemoState)
}

protocol MemoListViewModelOutput {
    var memoViewModels: [[MemoViewModel]] { get }
    var presentedMemo: MemoViewModel { get }
    var isDetaileViewPresented: Bool { get }
    var detailViewLeftButtonTitle: String { get }
    var isDetailViewEditable: Bool { get }
}

final class MemoListViewModel: ObservableObject, MemoListViewModelOutput {
    @Published
    private(set) var memoViewModels: [[MemoViewModel]] = [[], [], []]
    @Published
    var presentedMemo = MemoViewModel()
    @Published
    var isDetaileViewPresented = false
    @Published
    var detailViewLeftButtonTitle = ""
    @Published
    private(set) var isDetailViewEditable = false
    private var presentedMemoAccessMode: AccessMode = .add
    private let memoUseCase: UseCase
    
    init(memoUseCase: UseCase = MemoUseCase()) {
        self.memoUseCase = memoUseCase
    }
}

extension MemoListViewModel: MemoListViewModelInput {
    func viewOnAppear() {
        fetch()
    }
    
    func didTouchUpPlusButton() {
        readyForAdd()
    }
    
    func didTouchUpDetailViewLeftButton() {
        switch presentedMemoAccessMode {
        case .add, .write:
            isDetaileViewPresented = false
        case .read:
            presentedMemoAccessMode = .write
            isDetailViewEditable = true
            detailViewLeftButtonTitle = "Cancel"
        }
    }
    
    func didTouchUpDoneButton() {
        switch presentedMemoAccessMode {
        case .read:
            break
        case .add:
            add()
        case .write:
            modify()
        }
        isDetaileViewPresented = false
    }
    
    func didSwipeCell(_ memo: MemoViewModel) {
        delete(memo)
    }
    
    func didTouchUpCell(_ memo: MemoViewModel) {
        readyForRead(memo)
    }
    
    func didTouchUpPopoverButton(_ memo: MemoViewModel, newState: MemoState) {
        moveColumn(viewModel: memo, to: newState)
    }
}

extension MemoListViewModel {
    private func fetch() {
        memoUseCase.fetch { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let memos):
                DispatchQueue.main.async {
                    memos
                        .map { MemoViewModel(memo: $0) }
                        .forEach { self.memoViewModels[$0.memoStatus.indexValue].append($0) }
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func add() {
        memoUseCase.add(presentedMemo.memo) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let memo):
                DispatchQueue.main.async {
                    self.memoViewModels[memo.status.indexValue].append(MemoViewModel(memo: memo))
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func delete(_ viewModel: MemoViewModel) {
        memoUseCase.delete(viewModel.memo) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let memo):
                guard let index = self.find(MemoViewModel(memo: memo)) else {
                    return
                }
                DispatchQueue.main.async {
                    self.memoViewModels[memo.status.indexValue].remove(at: index)
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func moveColumn(viewModel: MemoViewModel, to newState: MemoState) {
        var newViewModel = viewModel
        newViewModel.memoStatus = newState
        memoUseCase.modify(newViewModel.memo) { result in
            switch result {
            case .success(let memo):
                guard let oldViewModelIndex = self.find(viewModel) else {
                    return
                }
                DispatchQueue.main.async {
                    self.memoViewModels[viewModel.memoStatus.indexValue].remove(at: oldViewModelIndex)
                    self.memoViewModels[memo.status.indexValue].append(MemoViewModel(memo: memo))
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func modify() {
        guard let index = find(presentedMemo) else {
            return
        }
        memoViewModels[presentedMemo.memoStatus.indexValue][index].memoTitle = presentedMemo.memoTitle
        memoViewModels[presentedMemo.memoStatus.indexValue][index].memoDate = presentedMemo.memoDate
        memoViewModels[presentedMemo.memoStatus.indexValue][index].memoDescription = presentedMemo.memoDescription
    }
    
    private func readyForAdd() {
        presentedMemo = MemoViewModel()
        presentedMemoAccessMode = .add
        isDetaileViewPresented = true
        detailViewLeftButtonTitle = "Cancel"
        isDetailViewEditable = true
    }

    private func readyForRead(_ viewModel: MemoViewModel) {
        presentedMemo = viewModel
        presentedMemoAccessMode = .read
        isDetaileViewPresented = true
        detailViewLeftButtonTitle = "Edit"
        isDetailViewEditable = false
    }
    
    private func find(_ viewModel: MemoViewModel) -> Int? {
        let specificStateViewModelList = memoViewModels[viewModel.memoStatus.indexValue]
        for index in specificStateViewModelList.indices {
            if specificStateViewModelList[index].memoId == viewModel.memoId {
                return index
            }
        }
        return nil
    }
}
