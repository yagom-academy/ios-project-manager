//
//  MemoListViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

protocol MemoListViewModelInput {
    func didTouchUpPlusButton()
    func didTouchUpDoneButton(_ memo: MemoViewModel) //모달
    func didSwipeCell(_ memo: MemoViewModel) //삭제
    func didTouchUpCell(_ memo: MemoViewModel)
    func didTouchUpPopoverButton(_ memo: MemoViewModel, newState: MemoState)
}

protocol MemoListViewModelOutput {
    var memoViewModels: [[MemoViewModel]] { get }
    var presentedMemo: MemoViewModel { get }
    var presentedMemoAccessMode: AccessMode { get }
}

final class MemoListViewModel: ObservableObject, MemoListViewModelOutput {
    @Published
    private(set) var memoViewModels: [[MemoViewModel]] = [[], [], []] 
    private(set) var presentedMemo = MemoViewModel()
    private(set) var presentedMemoAccessMode: AccessMode = .add
}

extension MemoListViewModel: MemoListViewModelInput {
    func didTouchUpPlusButton() {
        readyForAdd()
    }
    
    func didTouchUpDoneButton(_ memo: MemoViewModel) {
        switch presentedMemoAccessMode {
        case .read:
            break
        case .add:
            add(memo)
        case .write:
            modify(memo)
        }
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
    private func add(_ viewModel: MemoViewModel) {
        memoViewModels[viewModel.memoStatus.indexValue].append(viewModel)
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
        add(viewModel)
    }
    
    private func modify(_ viewModel: MemoViewModel) {
        guard let index = find(viewModel) else {
            return
        }
        memoViewModels[viewModel.memoStatus.indexValue][index].memoTitle = viewModel.memoTitle
        memoViewModels[viewModel.memoStatus.indexValue][index].memoDate = viewModel.memoDate
        memoViewModels[viewModel.memoStatus.indexValue][index].memoDescription = viewModel.memoDescription
    }
    
    private func readyForAdd() {
        presentedMemo = MemoViewModel()
        presentedMemoAccessMode = .add
    }

    private func readyForRead(_ viewModel: MemoViewModel) {
        presentedMemo = viewModel
        presentedMemoAccessMode = .read
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
