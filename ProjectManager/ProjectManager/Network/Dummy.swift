//
//  Dummy.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/03.
//

import Foundation

// MARK: test전용 Dummy
final class Dummy {
    static let shared = Dummy()
    
    func dummy(as tableViewType: TableViewType) -> [Memo] {
        switch tableViewType {
        case .todo:
            return Dummy.shared.todo
        case .doing:
            return Dummy.shared.doing
        case .done:
            return Dummy.shared.done
        }
    }
    
    func insert(
        tableViewType: TableViewType,
        cell: Memo,
        at index: Int
    ) {
        switch tableViewType {
        case .todo:
            todo.insert(
                cell,
                at: index
            )
        case .doing:
            doing.insert(
                cell,
                at: index
            )
        case .done:
            done.insert(
                cell,
                at: index
            )
        }
    }
    
    func remove(
        tableViewType: TableViewType,
        at index: Int
    ) {
        switch tableViewType {
        case .todo:
            todo.remove(at: index)
        case .doing:
            doing.remove(at: index)
        case .done:
            done.remove(at: index)
        }
    }
    // MARK: - todoDummy
    var todo: [Memo] = [
        Memo(
            title: "제목이 긴 경우 -> ㅣ무로ㅓㄴ돋림도나롬다노라ㅓㅁㄴ도리모다ㅕㄹㅎ모낟",
            content: "이런저런 내용이 있습니다.",
            date: 1624958921
        ),
        Memo(
            title: "내용이 3줄이 넘어가는 경우",
            content: "ㄴ마ㅓㄹ;ㅁ너럳님러ㅣ낟멀;ㄷㄴㅁ마러ㅣㅏㅈ덣미도리ㅑㅁㄷㅈㅈㄷ먀럳짐러미노리ㅑㅁ도랴ㅣ머디럳지ㅑㅗㅁㄹ미ㅑㄴㄷ리ㅑㅁ녿랴ㅣ몯랴ㅣㄷㄴㅁㄴㅇ라ㅓㅣㅁ넝리ㅏㅁㄴ오리ㅗㄴ미ㅏ론ㅇ미ㅏ롬나ㅣㅇ러ㅣㅏㅁ넝리ㅏㄴ머리ㅏ넝마ㅣ롬ㄴ이ㅏ롸ㅣㄴㅇ미랴ㅗㄴ이ㅏ로님ㅇ",
            date: 1224958922
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        )
    ]
    // MARK: - doingDummy
    var doing: [Memo] = [
        Memo(
            title: "doingDummy 제목이 긴 경우 -> ㅣ무로ㅓㄴ돋림도나롬다노라ㅓㅁㄴ도리모다ㅕㄹㅎ모낟",
            content: "이런저런 내용이 있습니다.",
            date: 1624958921
        ),
        Memo(
            title: "내용이 3줄이 넘어가는 경우",
            content: "doingDummydoingDummydoingDummydoingDummydoingDummydoingDummydoingDummydoingDummydoingDummydoingDummyㄴ마ㅓㄹ;ㅁ너럳님러ㅣ낟멀;ㄷㄴㅁ마러ㅣㅏㅈ덣미도리ㅑㅁㄷㅈㅈㄷ먀럳짐러미노리ㅑㅁ도랴ㅣ머디럳지ㅑㅗㅁㄹ미ㅑㄴㄷ리ㅑㅁ녿랴ㅣ몯랴ㅣㄷㄴㅁㄴㅇ라ㅓㅣㅁ넝리ㅏㅁㄴ오리ㅗㄴ미ㅏ론ㅇ미ㅏ롬나ㅣㅇ러ㅣㅏㅁ넝리ㅏㄴ머리ㅏ넝마ㅣ롬ㄴ이ㅏ롸ㅣㄴㅇ미랴ㅗㄴ이ㅏ로님ㅇ",
            date: 1224958922
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        )
    ]
    // MARK: - doneDummy
    var done: [Memo] = [
        Memo(
            title: "doneDummy 제목이 긴 경우 -> ㅣ무로ㅓㄴ돋림도나롬다노라ㅓㅁㄴ도리모다ㅕㄹㅎ모낟",
            content: "이런저런 내용이 있습니다.",
            date: 1624958921
        ),
        Memo(
            title: "내용이 doneDummy 3줄이 넘어가는 경우",
            content: "ㄴ마ㅓㄹ;ㅁ너럳님러ㅣ낟멀;ㄷㄴㅁ마러ㅣㅏㅈ덣미도리ㅑㅁㄷㅈㅈㄷ먀럳짐러미노리ㅑㅁ도랴ㅣ머디럳지ㅑㅗㅁㄹ미ㅑㄴㄷ리ㅑㅁ녿랴ㅣ몯랴ㅣㄷㄴㅁㄴㅇ라ㅓㅣㅁ넝리ㅏㅁㄴ오리ㅗㄴ미ㅏ론ㅇ미ㅏ롬나ㅣㅇ러ㅣㅏㅁ넝리ㅏㄴ머리ㅏ넝마ㅣ롬ㄴ이ㅏ롸ㅣㄴㅇ미랴ㅗㄴ이ㅏ로님ㅇ",
            date: 1224958922
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        ),
        Memo(
            title: "짧은 cell",
            content: "이런저런 내용이 있습니다.",
            date: 2624959999
        )
    ]
}
