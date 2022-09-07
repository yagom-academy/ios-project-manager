//
//  SampleData.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import Foundation

struct SampleData {
    static let todoWorks: [Work] = [
        Work(title: "책상정리", content: "집중이 안될땐 역시나 책상정리", deadline: Date()),
        Work(title: "라자냐 재료사러 가기", content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadline: Date()),
        Work(title: "일기쓰기", content: "난... ㄱㅏ끔... 일ㄱㅣ를 쓴ㄷㅏ...", deadline: Date()),
        Work(title: "설거지하기", content: "밥을 먹었으면 응당 해야할 일", deadline: Date()),
        Work(title: "빨래하기", content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", deadline: Date())
    ]
    
    static let doingWorks: [Work] = [
        Work(title: "책상정리", content: "집중이 안될땐 역시나 책상정리", deadline: Date()),
        Work(title: "라자냐 재료사러 가기", content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadline: Date()),
        Work(title: "일기쓰기", content: "난... ㄱㅏ끔... 일ㄱㅣ를 쓴ㄷㅏ...", deadline: Date()),
        Work(title: "설거지하기", content: "밥을 먹었으면 응당 해야할 일", deadline: Date()),
        Work(title: "빨래하기", content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", deadline: Date())
    ]
    
    static let doneWorks: [Work] = [
        Work(title: "책상정리", content: "집중이 안될땐 역시나 책상정리", deadline: Date()),
        Work(title: "라자냐 재료사러 가기", content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadline: Date()),
        Work(title: "일기쓰기", content: "난... ㄱㅏ끔... 일ㄱㅣ를 쓴ㄷㅏ...", deadline: Date()),
        Work(title: "설거지하기", content: "밥을 먹었으면 응당 해야할 일", deadline: Date()),
        Work(title: "빨래하기", content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", deadline: Date())
    ]
}
