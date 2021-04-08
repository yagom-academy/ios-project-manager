//
//  Todos.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/04/02.
//
import UIKit

class Todos {
    private init() { }
    static var common = Todos()
    
    var todoList: [Todo] = [Todo(title: "라자냐 만들기", description: "어렵다", deadline: 1611123563.719116)]
    var doingList: [Todo] = [Todo(title: "볼펜 사기 사기 사기 사기 사기 사기 당했어 ", description: "문구점에서 볼펜을 12091203 8 10984 50 9382503 50596 45 69 자루 사요 사요 사요 사요 사요 사요 129038098529859045 9012389085928359048504534", deadline: 1611123563.712932)]
    var doneList: [Todo] = [Todo(title: "저녁 재료사기", description: "마트에서", deadline: 1611123563.702304)]
}
