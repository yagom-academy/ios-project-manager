# 📑 프로젝트 관리 앱
> 프로젝트 기간: 2022-07-04 ~ 2022-07-15
> 
> 팀원: [malrang](https://github.com/malrang-malrang), [Eddy](https://github.com/kimkyunghun3)
> 
> 리뷰어: [Lucas](https://github.com/innocarpe)

## 🔎 프로젝트 소개

프로젝트 관리 앱

## 📺 프로젝트 실행화면

## 👀 PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/119)
- STEP 2
    - [STEP 2-1](https://github.com/yagom-academy/ios-project-manager/pull/127)
    - [STEP 2-2](https://github.com/yagom-academy/ios-project-manager/pull/134)

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.0-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.0-blue)]()
- [![Realm](https://img.shields.io/badge/Realm-10.2-brown)]()
- [![Firebase](https://img.shields.io/badge/Firebase-9.0.0-yellow)]()
- [![Rxswift](https://img.shields.io/badge/Rxswift-6.5-hotpink)]()


## 🔑 키워드
- Swift Package Manager
- Realm
- Firebase
- Rxswift
- MVVM

## ✨ 구현내용
- Swift Package Manager를 통해 라이브러리를 관리
- 로컬 DB로 Realm, remote DB로 Firebase 설치
- MVVM + Rxswift를 활용하여 TodoList TableView UI 구현
- 하나의 View로 mode에 따라 Tableview 구분

## 🤔 해결한 방법 및 조언받고 싶은 부분

## [STEP 1] 
### 로컬DB/원격DB 라이브러리 사용

✅ **선택한 라이브러리**
로컬DB는 `Realm`/ 원격DB는 `Firebase Realtime Database` 로 결정했다.

**🤔 하위 버전 호환성에는 문제가 없는가?**  
✅ 선택한 `Firebase Realtime Database`는 iOS 10, `Realm`는 iOS 8 부터 지원한다.
[iOS 및 IPad 사용현황](https://developer.apple.com/kr/support/app-store/)을 보게되면 IPad를 사용하는 유저의 90% 이상이 iOS 14 버전 이상을 사용하는것을 알수 있었고 하위 버전 호환성에 문제가 없다고 판단했다.

<img src = "https://i.imgur.com/YXe7g8z.png" width = "200">

**🤔 안정적으로 운용 가능한가?**  
✅ Realm은 MongoDB의 서비스로 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할것으로 판단한다.

또한 Realm은 기존의 정형화된 데이터 베이스와 다르게 NoSQL 데이터베이스를 지향하며 Realm API를 사용해 좀더 직관적인 사용이 가능하며 데이터 처리 속도가 향상된 장점이 있다.
* Realm과 다른 DataBase의 성능비교 그래프

<img src = "https://i.imgur.com/wps0N9Q.png" width = "300"><img src = "https://i.imgur.com/5RBdKIF.png" width = "370">

[자료 출처](https://hesam-kamalan.medium.com/database-benchmark-realm-vs-snappydb-f4b89711f424)

✅ Firebase는 Google의 서비스로 Realm과 같이 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할 것으로 판단한다.

**🤔 미래 지속 가능성이 있는가?**  
⚠️ Realm은 MongoDB에서 서비스 하고 있는 Third - Party 이므로 언제든 서비스가 종료될 위험을 가지고 있으나 충분한 성과를 내고 있는 라이브러리이며 지속적인 유지보수가 이루어지고 있기 때문에 지속 가능성이 있다고 판단한다.

⚠️ Firebase는 Google에서 서비스 하고 있는 Third - Party 이므로 언제든 서비스가 종료될 위험을 가지고 있으나 충분한 성과를 내고 있는 라이브러리이며 지속적인 유지보수가 이루어지고 있기 때문에 지속 가능성이 있다고 판단한다.

**🤔 리스크를 최소화 할 수 있는가? 알고 있는 리스크는 무엇인가?**  
✅ Realm 사용 시 main thread가 아닌 다른 thread 접근하면 에러가 나는 리스크가 있다. 
해당 리스크를 해결하기 위해 Realm 접근 및 사용시 main thread에서 작업하도록 지정 해주어야한다.

⚠️ Firebase 사용 시 데이터베이스에 접근할 때 서버가 해외에 구축되어 있기 때문에 응답 시간이 조금 지연되는 경우 가 발생한다. 

## [STEP 2]
### 3개의 다른 mode 가진 TableView 구현
`Model`에 `todo`, `doing`, `done`를 가진 프로퍼티를 활용하여 각 `TableView`에 다른 `mode`를 가지도록 구현

```swift
// Todo.swift
struct Todo {
    let mode: Mode
    let identifier: UUID = UUID()
    let title: String
    let description: String
    let date: String
}
```

`ListView`에서 `ViewModel`에 있는 `tableViewData`를 활용하여 `items`와 `bind`하여 셀에 보여지도록 구현 

```swift
// ListView.swift
private func bind() {
    self.viewModel.tableViewData?
        .bind(to: self.tableView.rx.items) { tabelView, row, element in
            guard let cell = tabelView.dequeueReusableCell(
                withIdentifier: TodoListCell.identifier,
                for: IndexPath(row: row, section: .zero)) as? TodoListCell
            else {
                return UITableViewCell()
            }
            cell.configure(element)

            return cell
        }
        .disposed(by: disposeBag)
}
```

내부 `TodoList`는 공통된 것을 가리키고 있으므로 공통의 `Cell`를 통해 구현
`tableViewData`에는 초기값이 필요하다고 판단하여 `BehaviorSubject`로 구현
```swift
// TodoListViewModel.swift 
let tableViewData: BehaviorSubject<[Todo]>?

...

init() {
        self.tableViewData = BehaviorSubject(value: self.mockData)
    }
```

### 셀 간의 구분선 구현
`layoutSubViews`를 `override`하여 `contentView.frame`에 `inset`를 주면 셀의 경계선을 `custom`할 수 있다.
```swift
override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
```

<img src="https://i.imgur.com/hKzYFSw.png" width="500">
