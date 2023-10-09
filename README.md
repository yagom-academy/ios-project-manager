# 🗓️ 프로젝트 매니저 

- **프로젝트 기간** : 2023.09.18~2023.10.06
- **프로젝트 팀원** : Zion♏️, Karen♉️ (팀명: ✨카시온페어💫)
- **프로젝트 리뷰어** : delma

## 🔖 목차 
1. [프로젝트 소개](#1.)
2. [실행 화면](#2.)
3. [시각적 프로젝트 구조](#3.)
4. [트러블 슈팅](#4.)
5. [참고 링크](#5.)
6. [about TEAM](#6.)


---
</br>


<a id="1."></a>
## 1. 💬 프로젝트 소개
> `CoreData`와 `FireBase`로 데이터를 관리하여 자신만의 계획을 정해놓은 날짜에 맞춰 계획 실행 여부를 손쉽게 관리할 수 있는 프로젝트 관리앱입니다.

---
</br>



<a id="2."></a>

## 2.📱실행 화면

| 일정 추가 |
| :--------: |
|<img src="https://github.com/karenyang835/pr-exercise/assets/124643896/fcd1f6c0-bc18-459a-9605-184750bd821e" style="zoom:70%;" />|



| 일정 수정 및 삭제 |
| :--------: |
|<img src="https://github.com/karenyang835/pr-exercise/assets/124643896/354b1644-eaf5-4219-967b-fb8731810aba" style="zoom:70%;" />| 

    
| 일정 이동 (deadLine) |
| :--------: |
|<img src="https://github.com/karenyang835/pr-exercise/assets/124643896/570e9115-7f6c-4e93-99eb-e7bb125c9d1c" style="zoom:70%;" />|

---

</br>



</br>

<a id="3."></a>

## 3.📊 시각적 프로젝트 구조
</br>

### 📂 폴더 구조

```swift
┌── ProjectManager
│   ├── UseCase
│   │   ├── MainViewControllerUseCase
│   │   └── ListViewControllerUseCase
│   ├── Util
│   │   └── Protocol
│   │       ├── AlertControllerShowable
│   │       └── ToastShowable
│   ├── Model
│   │   ├── Task
│   │   └── TaskDTO
│   ├── View
│   │   ├── LaunchScreen
│   │   ├── ListCollectionViewCell
│   │   └── ListCollectionHeaderView
│   ├── Resource
│   │   └── Assets
│   ├── Controller
│   │   ├── MainViewController
│   │   ├── TaskViewController
│   │   └── ListViewController
│   └── App
│       ├── AppDelegate
│       └── SceneDelegate
│
└── README.md
```


### 🎨 Class Diagram
![image](https://github.com/karenyang835/pr-exercise/assets/124643896/3a8ca668-3a11-4250-9b8c-fe5589b8d23f)


---

</br>



<a id="4."></a>

## 4.🚨 트러블 슈팅

### 1️⃣ 잔상이 남는 문제
#### ⛔️ 문제점
- Swiped로 Delete시 잔상이 남는 문제가 발생했습니다. 
- 살펴보니 Delete뿐 아니라 셀이 이동하는 경우에도 이와 같은 문제가 발생되는 것을 확인했습니다. 
![프젝메-잔상](https://github.com/karenyang835/pr-exercise/assets/124643896/f5420f0b-0e30-4599-8659-beee1b963215)


#### ✅ 해결 방법
- reloadSections을 할 경우 이전에 가지고 있던 indexPath가 문제가 되면서 발생되어지는 현상이었습니다.
- reloadSections명령어를 사용하지 않으면 현재 작성했던 코드에서는 headerView를 갱신할 수가 없어서 HeadView를 ListViewController가 가지고 있게하여 갱신해야될 때 headerView에 직접적으로 컨텐츠를 넣어주어 추가적으로 발생한 문제점도 해결해 주었습니다.

<details>
<summary>코드 상세</summary>   

#### 수정 전
```swift
func setUpDiffableDataSourceSanpShot(taskList: [Task] = []) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        self.taskList = taskList
        snapShot.appendSections([.main])
        snapShot.appendItems(taskList)
        snapShot.reloadSections([.main])
        diffableDataSource?.apply(snapShot)
}   

    ...
    
private func setUpDiffableDataSourceHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<ListCollectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            guard let self = self else { return }
            
            headerView.setUpContents(title: self.listKind.rawValue, taskCount: "\(self.taskList.count)")
        }
        
        diffableDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }
}
    
```

#### 수정 후
```swift
func setUpDiffableDataSourceSanpShot(taskList: [Task] = []) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        self.taskList = taskList
        snapShot.appendSections([.main])
        snapShot.appendItems(taskList)
        diffableDataSource?.apply(snapShot)
}
...

private func setUpDiffableDataSourceHeader() {
    let headerRegistration = UICollectionView.SupplementaryRegistration<ListCollectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
        guard let self = self else { return }

        self.headerView = headerView
        headerView.setUpContents(title: self.taskStatus.rawValue, taskCount: "\(self.taskList.count)")
    }

    diffableDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
        return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }
}
  
  
func reloadTaskList(taskList: [Task]) {
            setUpDiffableDataSourceSanpShot(taskList: taskList)
            headerView?.setUpContents(title: taskStatus.rawValue, taskCount: "\(taskList.count)")
}
    
```

</details>
    
</br>
    
### 2️⃣ TextView 여러줄 입력시 Mask 되지 않는 문제 발생
#### ⛔️ 문제점
<img src="https://github.com/karenyang835/pr-exercise/assets/124643896/66543485-8d8d-4c0d-97a7-a3fc384f73c1" style="zoom:70%;" /> 
- 일정 상세 내용 입력하는 descriptionTextView에 여러줄을 입력하는 경우 mask가 제대로 씌워지지 않아 DatePicker영역을 침범해서 보여주는 문제점이 발생했습니다.


#### ✅ 해결 방법
- subview가 view의 경계를 넘어갈 시 잘리게 보여주는 clipsToBounds를 true로 주어 해결하였습니다.


<details>
<summary>코드 상세</summary>

#### 수정 전
```swift
private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 2, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3
        textView.layer.masksToBounds = false
        textView.delegate = self
        return textView
    }()
   
```

#### 수정 후

```swift
private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 2, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3
        textView.layer.masksToBounds = false
        textView.delegate = self
        textView.clipsToBounds = true //추가
        return textView
    }()
       
```

---

</br>

<a id="5."></a>

## 5.🔗 참고 링크

🍎 [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) <br>
🍎 [The Swift Language Guide - Preventing Overrides](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/#Preventing-Overrides)<br>
🍎 [The Swift Language Guide - Result Type](https://developer.apple.com/documentation/swift/result)<br>
🍏 [Apple Developer - UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)<br>
🍏 [Apple Developer - List](https://developer.apple.com/documentation/swiftui/list)<br>
🍏 [Apple Developer - Pickers](https://developer.apple.com/design/human-interface-guidelines/pickers)<br>
🍏 [Apple Developer - DatePicker](https://developer.apple.com/documentation/swiftui/datepicker)<br>
🍏 [Apple Developer - popover](https://developer.apple.com/documentation/swiftui/view/popover(ispresented:attachmentanchor:arrowedge:content:))<br>
🍏 [Apple Developer - Handling notifications and notification-related actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)<br>
🍏 [Apple Developer - UndoManager](https://developer.apple.com/documentation/foundation/undomanager)<br>
🍏 [Apple Developer - Scheduling a notification locally from your app](https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app)<br>
🍏 [Apple Developer - Localizations](https://developer.apple.com/kr/localization/)<br>


---

</br>


<a id="6."></a> 

## 6. 🎩 aboutTEAM
| Zion ♏️   |Karen ♉️|
| :-: | :-: |
| <img src="https://avatars.githubusercontent.com/u/24710439?v=4" height="250"/> | <Img src="https://avatars.githubusercontent.com/u/124643896?v=4" width="250"/>|
|https://github.com/LeeZion94 |https://github.com/karenyang835|

<details><summary span style="color:black; background-color:#23ff2921; font-size:110%"><b>⏰ 타임 라인 (펼쳐보기) </b></summary></span> 


|**날 짜**|**내 용**|
|:-:|-|
| 2023.09.18.    |🔍 프로젝트에서 필요로 하는 핵심기능 검토 - `UI`, `LocalDB`, `RemoteDB`, `Architecture`, `Dependecy Manager`, `Concurrency`<br>|
| 2023.09.19.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `MVVM패턴` <br> 🆕 코드베이스 준비 |
| 2023.09.20.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `MVVM패턴` <br> 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Clean Architecture` |
| 2023.09.21.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `MVVM패턴` <br> 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Clean Architecture`|
| 2023.09.22.    |📝 프로젝트에서 필요로 하는 핵심기능 공부 - `MVVM패턴` <br> 📝 프로젝트에서 필요로 하는 핵심기능 공부 - `Clean Architecture`| 
| 2023.10.03.    | 🆕 Cell, TaskViewController 구현 및 프로젝트 기초 구성 구현 <br> 🆕 ListViewController 레이아웃 구현<br> 🆕 ListViewCotroller DiffableDataSource 적용<br> 🆕 MainViewController 레이아웃 구현<br> 🆕 Task 생성시 MainViewController에서 ListViewController를 갱신하도록 변경<br>✅ 불필요 타입 삭제 |
| 2023.10.05.    | 🆕 taskCountLabel 라운딩 적용 <br>🆕 shadow적용<br> Task Update로직 추가<br> 🆕 deadline에 따른 텍스트 색상변경 적용<br>  🆕 isPassDeadline 로직 수정<br> ✅ descriptionLabel 줄 수 제한 적용<br> 🆕 swipeDelete 로직추가<br> 🆕 trailingAction 적용<br>🆕 Cell Move 로직추가  |
| 2023.10.06.    |✅ Section 갱신로직 수정 <br>🆕 showToast 로직 추가 <br> 🆕 MainViewController UseCase 생성<br> <br> <br> <br>    |
| 2023.10.08.    |🛠️ 불필요한 컨벤션 삭제, 네이밍 수정<br> 🆕 descriptionTextView글자수 제한 적용<br>🛠️ listKind -> TaskStatus로 수정 <br>🛠️ deleteTask 중복 노출 수정 <br> 🆕 ListViewControllerUseCase 생성 <br>✅  제목만 들어간 경우 titleLoad 불가 수정 <br>✅ TextView 영역을 벗어나서 노출되는 텍스트 안보이도록 수정 <br>🛠️ argument label to로 수정<br>🛠️  convertTitle부분 UseCase로 옮김|

</details>


---

</br>


