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
    private func add() {
        memoUseCase.add(presentedMemo.memo) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let memo):
                self.memoViewModels[memo.status.indexValue].append(MemoViewModel(memo: memo))
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    @discardableResult
    private func delete(_ viewModel: MemoViewModel) -> MemoViewModel? {
        guard let index = find(viewModel) else {
            return nil
        }
        return memoViewModels[viewModel.memoStatus.indexValue].remove(at: index)
    }
    
    private func moveColumn(viewModel: MemoViewModel, to newState: MemoState) {
        guard var viewModel = delete(viewModel) else {
            return
        }
        viewModel.memoStatus = newState
        memoViewModels[viewModel.memoStatus.indexValue].append(viewModel)
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
