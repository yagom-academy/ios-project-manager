//
//  MemoListViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/04.
//

import Foundation

protocol MemoListViewModelInput {
}

protocol MemoListViewModelOutput {
    var memoViewModels: [[MemoViewModel]] { get }
    var presentedMemo: MemoViewModel { get }
    var presentedMemoAccessMode: AccessMode { get }
}

final class MemoListViewModel: ObservableObject {
    @Published
    private(set) var memoViewModels: [[MemoViewModel]] = [[], [], []] 
    private(set) var presentedMemo = MemoViewModel()
    private(set) var presentedMemoAccessMode: AccessMode = .add
    
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

extension MemoListViewModel {
    func add(_ viewModel: MemoViewModel) {
        memoViewModels[viewModel.memoStatus.indexValue].append(viewModel)
    }
    
    func delete(_ viewModel: MemoViewModel) -> MemoViewModel? {
        guard let index = find(viewModel) else {
            return nil
        }
        return memoViewModels[viewModel.memoStatus.indexValue].remove(at: index)
    }
    
    func moveColumn(viewModel: MemoViewModel, to newState: MemoState) {
        guard var viewModel = delete(viewModel) else {
            return
        }
        viewModel.memoStatus = newState
        add(viewModel)
    }
    
    func modify(_ viewModel: MemoViewModel) {
        guard let index = find(viewModel) else {
            return
        }
        memoViewModels[viewModel.memoStatus.indexValue][index].memoTitle = viewModel.memoTitle
        memoViewModels[viewModel.memoStatus.indexValue][index].memoDate = viewModel.memoDate
        memoViewModels[viewModel.memoStatus.indexValue][index].memoDescription = viewModel.memoDescription
    }
    
    func readyForAdd() {
        presentedMemo = MemoViewModel()
        presentedMemoAccessMode = .add
    }

    func readyForRead(_ viewModel: MemoViewModel) {
        presentedMemo = viewModel
        presentedMemoAccessMode = .read
    }
}
