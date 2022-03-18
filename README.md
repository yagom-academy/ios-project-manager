# 💾 프로젝트 관리 앱 저장소
현재 진행 중이거나, 계획하고 있는 프로젝트(Todo / Doing / Done으로 구성)를 관리할 수 있는 프로젝트입니다. 

## 📌 목차
- [🛠 사용한 기술 스택](#-사용한-기술-스택)
    - [✅ 기술 선정 이유](#-기술-선정-이유)
- [🗺 코딩 컨벤션 및 구조 설계](#-코딩-컨벤션-및-구조-설계)
    - [👨🏻‍⚖️ 코딩 컨벤션](#%EF%B8%8F-코딩-컨벤션) 
    - [🔸 MVVM 설계](#-mvvm-설계)
- [📱 UI 및 CRUD 구현](#-ui-및-crud-구현)
    - [🔸 DateFormatter의 Extension을 통한 Static 구현](#-dateformatter의-extension을-통한-static-구현)
    - [🔸 TableView의 Cell 간 간격 부여](#-tableview의-cell-간-간격-부여)
    - [🔸 반복적으로 사용되는 UI의 경우 따로 분리하여 재사용할 수 있도록 구현](#-반복적으로-사용되는-ui의-경우-따로-분리하여-재사용할-수-있도록-구현)
    - [🔹 Create](#-create)
    - [🔹 Update](#-update)
    - [🔹 Delete](#-delete)
- [🔫 Trouble Shooting](#-trouble-shooting)
    - [🔸 MVVM에 맞는 View와 ViewModel 설계](#-mvvm에-맞는-view와-viewmodel-설계) 

## 🛠 사용한 기술 스택
|UI 및 비동기 처리|코딩 컨벤션|서버 DB|로컬 DB|
|--|--|--|--|
|RxSwift / RxCocoa|SwiftLint|Firebase|CoreData|

### ✅ 기술 선정 이유
**1️⃣ 하위 버전 호환성에는 문제가 없는가?**
- `RxCocoa / RxSwift`: iOS 9까지 지원하며 현재 프로젝트 타겟의 경우 14.1로 되어 있기에 호환성에는 전혀 문제가 없다고 판단했습니다.
- `Firebase`: 21.5.11일 기준 iOS 10까지 지원을 하기 때문에 이 또한 문제가 없다고 판단했습니다. 

또한 [애플 문서](https://developer.apple.com/kr/support/app-store/)에 따르면 현재 iOS 15는 72%, iOS14는 26%의 사용률을 보이고 있어 현재 해당 기술을 사용하더라도 대부분의 사용자는 사용이 가능하다고 판단했습니다. 

**2️⃣ 안정적으로 운용 가능한가?**
- `RxCocoa / RxSwift`: Github의 `star`도 21.7k이고 15년도부터 나온 라이브러리인 만큼 충분히 안정적으로 운용이 가능하다 생각했습니다. 

<Contributors 추이>
<img width="976" alt="스크린샷 2022-03-01 오후 6 51 34" src="https://user-images.githubusercontent.com/90880660/156146330-b5a0dc95-a08a-4ac5-a826-9a02dc855667.png">

<5년간 검색 관심도>
<img width="1122" alt="스크린샷 2022-03-01 오후 6 50 24" src="https://user-images.githubusercontent.com/90880660/156146415-ebfc05e8-71bf-4d8b-a0ba-7e32373518cc.png">
다만 Contributors 추이나 5년간 검색 관심도로 미뤄볼 때 미래에도 지속해서 사용할 기술인가에 대해선 어느 정도 의문이 들긴 했습니다.

<br>

- `Firebase`: 업데이트도 꾸준히 되고 있고 구글에서 운영하는 것인 만큼 충분히 안정적으로 운용이 가능하다고 생각했습니다. 또한 많은 사람들이 사용하고 있는 만큼 관련된 자료도 많아 Trouble Shooting도 원활하다고 판단했습니다. 

<Contributors 추이>
<img width="985" alt="스크린샷 2022-03-01 오후 6 48 43" src="https://user-images.githubusercontent.com/90880660/156145905-aa887bac-29c3-461a-9624-ffa80e6c2016.png">
Contributors가 꾸준히 존재하고 있으며, 비교적 다양한 Contributors가 존재하고 있어 안정적인 운용이 예상됩니다. 

<5년간 검색 관심도>
<img width="1125" alt="스크린샷 2022-03-01 오후 6 45 40" src="https://user-images.githubusercontent.com/90880660/156145452-daebd25e-130c-4bda-a0e2-b95b29fa6d52.png">

<br>

- `SwiftLint`: 이 또한 15년도부터 나온 라이브러리이고, 이전 2개의 프로젝트에서 사용하며 놓치기 쉬운 컨벤션을 Alert / Error로 잡아줘서 유용하게 사용할 수 있었습니다. 따라서 이번 프로젝트에서도 적용했습니다. 또한 Contributors의 경우도 어느정도 꾸준히 존재하고 있어 안정적으로 운용이 될 것이라 생각합니다.

<Contributors 추이> 
<img width="1012" alt="스크린샷 2022-03-01 오후 6 40 39" src="https://user-images.githubusercontent.com/90880660/156144557-560e9b50-cf16-44c4-8b86-178ad0d0f345.png">

<5년간 검색 관심도>
<img width="1129" alt="스크린샷 2022-03-01 오후 6 43 33" src="https://user-images.githubusercontent.com/90880660/156144942-ebe771b7-4b2b-49bb-9a58-3b775828d67c.png">

**3️⃣ 미래 지속가능성이 있는가?**
- `RxCocoa / RxSwift`: SwiftUI가 대중화되면서 Combine 프레임워크가 많이 사용된다면 지속적으로 사용되진 않을 수 있다고 판단했습니다. 다만 현재에도 적지 않은 기업들이 사용 중이기 때문에 향후 1~2년은 지속해서 사용할 것이라 판단했습니다. 
- `Firebase`: 구글이 제공하고 있는 서비스이고, 현재 다양한 곳에서 사용 중이기 때문에 충분히 지속가능성이 있다고 판단했습니다. 

**4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?**
- `Firebase`: 일정 사용량이 초과할 경우 비용이 발생할 수 있다고 알고 있습니다. 또한 어떤 서버를 사용할 지 등과 같이 백엔드에 대한 컨트롤을 할 수 없다는 점도 리스크 중 하나라고 생각합니다. 하지만 현재 프로젝트 수준에선 일정 사용량이 초과할 경우는 발생하지 않는다고 판단했고, 서버 또한 현재 관리를 할 수 없기 때문에 큰 리스크는 아니라고 판단했습니다. 
 
**5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**
- `RxCocoa / RxSwift`: SPM, CocoaPods, Carthage
- `Firebase`: SPM, CocoaPods, Carthage
- `SwiftLint`: CocoaPods

의존성 관리 도구의 경우 RxSwift를 SPM으로 사용했을 경우 버그가 있다는 것을 확인했습니다. 따라서 현재 다양한 회사에서 사용 중인 `CocoaPods`를 사용하기로 결정했습니다. 

**6️⃣ 이 앱의 요구기능에 적절한 선택인가?**
- `Firebase`: 빠르게 프로토타입의 앱을 만드는데 최적화된 데이터베이스인 만큼 해당 프로젝트에서 가장 적절한 데이터베이스 관련 라이브러리라고 판단했습니다. 

<br>

## 🗺 코딩 컨벤션 및 구조 설계
### 👨🏻‍⚖️ 코딩 컨벤션
|**프로퍼티 순서**|**메서드 순서**|
|--|--|
|1. static 프로퍼티<br>2. IBOutlet 프로퍼티<br>3. stored 프로퍼티<br>4. computed 프로퍼티|1. override 메서드<br>2. 일반 메서드<br>3. IBAction 메서드<br>4. private 메서드|

- 상수의 경우 최대한 코드 내부에 두지 않고 따로 enum의 static 프로퍼티로 두어 관리
- import 밑에는 **두 줄** 줄바꿈
- 타입 시작과 마지막은 항상 줄바꿈
- 변수의 경우도 맥락에 따라 줄바꿈 
- `return` 전에는 항상 줄바꿈
- `guard let` 구문에선 else 문 내부에 return만 있을 경우에만 한 줄로 작성(다른 경우는 항상 줄바꿈)
```swift
guard let viewController = segue.destination as? ProjectTableViewController else { return }
```

### 🔸 MVVM 설계
<img width="1335" alt="스크린샷 2022-03-07 오후 7 05 36" src="https://user-images.githubusercontent.com/90880660/157010428-382c46d7-d9dd-4ae9-9f1d-3faa80be0dbb.png">

기본적인 구조의 경우 MVVM으로 설계를 했습니다. 또한 종속된 View가 아닌 경우 각각의 View마다 ViewModel을 가질 수 있도록 구현했습니다. 

**<MVVM을 사용한 이유>**
관련 블로깅 작성 내용 [링크](https://ho8487.tistory.com/62)
- ViewModel에 UI 관련 코드가 없어 테스트가 용이하다
- ViewController가 비대해지는 문제를 해결할 수 있다
- View와 ViewModel의 역할이 명확해진다

**MVVM 설계를 위한 기준**
- View: 비즈니스 로직을 갖지 않는다. (ex: 어떤 버튼을 눌렀을 때 어떤 화면을 내보낼 지, 어떤 상황에서 버튼의 타이틀을 변경할 지)
- ViewModel: UI 관련 코드를 갖지 않는다. (UI 관련 라이브러리와 프레임워크를 import하지 않는다)

<br>

## 📱 UI 및 CRUD 구현
### 🔸 DateFormatter의 Extension을 통한 Static 구현
이전 프로젝트를 진행하면서 DateFormatter를 매번 생성하고 사용할 경우 오히려 비용이 많이 든다는 것을 파악할 수 있었습니다. 
실제로 테스트를 했었을 때에도 훨씬 시간이 많이 걸리는 것을 확인할 수 있었습니다. ([테스트 당시 링크](https://ho8487.tistory.com/50?category=513748))

이번 프로젝트에서도 각 셀마다 DateFormatter를 통해 변환된 날짜를 사용해야 했기에 Static으로 한 번만 구현을 해놓고 사용을 하는 것이 비용 측면에서 더 낫다고 판단하여 Static으로 구현을 했습니다. 

```swift
extension DateFormatter {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter
    }()
    
   •••

}
```

### 🔸 TableView의 Cell 간 간격 부여
셀 간 간격을 부여하기 위해 `layoutSubviews()` 메서드를 재정의하여, Cell의 `contentView.frame`에 top, bottom에 inset을 줘서 셀 간 간격이 생기도록 구현했습니다. 
```swift
override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(
        top: 3,
        left: 0,
        bottom: 3,
        right: 0)
    )
    contentView.backgroundColor = .white
    self.backgroundColor = .systemGray5
}
```

### 🔸 반복적으로 사용되는 UI의 경우 따로 분리하여 재사용할 수 있도록 구현
TableViewCell, TableView, Header View의 경우 동일한 형태의 View가 하나의 ViewController에 3개가 들어간 형태였습니다. 

<img src="https://user-images.githubusercontent.com/90880660/158107683-c53e9fd0-6c05-4a94-b339-9f3c96eca9b0.png" width="600">

따라서 이를 각각 Storyboad에 생성하지 않고 재사용할 수 있도록 TableViewCell의 경우 xib 파일로 분리하고 TableView와 Header View의 경우 하나의 ViewController를 만든 뒤 3개의 Container View가 해당 ViewController에 reference를 가지고 있을 수 있도록 구현했습니다. 

<img width="600" alt="스크린샷 2022-03-14 오후 2 05 31" src="https://user-images.githubusercontent.com/90880660/158108326-029a2674-dda3-4807-8f9b-79bdf9df0a2a.png">

그 후 Cell은 각각의 TableViewController에 다음과 같이 register를 해주었습니다. 
```swift
private func registerTableViewCell() {
    let nib = UINib(nibName: String(describing: ProjectTableViewCell.self), bundle: nil)

    tableView.register(nib, cellClass: ProjectTableViewCell.self)
}
```

### 🔹 Create
![프로젝트매니저_생성화면](https://user-images.githubusercontent.com/90880660/158109842-17636d46-18ff-4619-ba4f-fe5725f24641.gif)


새로운 Work를 추가할 때에는 NavigationBar에 있는 `+` 버튼을 눌러야 작동을 하도록 되어있었습니다.
따라서 일단 `+` 버튼을 누를 경우 Create를 위한 Modal 창이 formSheet 형태로 나올 수 있도록 구현했습니다. 

이때 모달에 해당하는 ViewController에도 add 기능을 구현할 수 있도록 WorkFormViewController의 인스턴스를 생성할 때 ViewModel을 전달받을 수 있도록 구현했습니다. 
이를 위해 `instantiateViewController(identifier:creator:) -> ViewController` 메서드를 활용했습니다. 

그 후 Modal의 RightBarButtonItem(Done 버튼)을 누르면 새롭게 Work를 추가할 수 있도록 viewModel의 `addWork` 메서드를 호출해주었습니다.
만약 제목을 입력하는 TextField에 아무것도 작성하지 않았을 경우 자동으로 `제목을 입력해주세요`가 제목이 되도록 구현을 했습니다. 

```swift
if titleTextField.text == Content.isEmpty {
    titleTextField.text = Content.EmptyTitle
}

let work = Work(title: titleTextField.text, body: bodyTextView.text, dueDate: datePicker.date)

viewModel?.addWork(work)
```


또한 추가를 해주었을 때 Header View의 Count가 자동으로 올라가야 했기 때문에, ViewModel에 각각의 갯수를 세주는 `todoCount`, `doingCount`, `doneCount`를 두고 해당 Observable<Int> 타입을 HeaderView의 countLabel이 subscribe할 수 있도록 구현해주었습니다. 
 
 ```swift
private func configureHeader() {
    guard let count = count else { return }

    titleLabel.text = titleText

    _ = count
        .subscribe(onNext: {
            self.countLabel.text = $0.description
        })
        .disposed(by: disposeBag)
}
 ```
 
 또한 각각의 TableView에 적합한 Count를 전달할 수 있도록 Main이 되는 `ProjectViewController`에서 `prepare` 메서드를 통해 각각에 맞는 count와 list, title을 받을 수 있도록 구현해주었습니다. 
 ```swift
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination as? ProjectTableViewController else { return }

    viewController.viewModel = viewModel

    switch segue.identifier {
    case UIName.todoSegue:
        viewController.titleText = Content.todoTitle
        viewController.count = viewModel.todoCount
        viewController.list = viewModel.todoList
    case UIName.doingSegue:
        viewController.titleText = Content.doingTitle
        viewController.count = viewModel.doingCount
        viewController.list = viewModel.doingList
    case UIName.doneSegue:
        viewController.titleText = Content.doneTitle
        viewController.count = viewModel.doneCount
        viewController.list = viewModel.doneList
    default:
        break
    }
}
 ```

### 🔹 Update
![프로젝트매니저_업데이트](https://user-images.githubusercontent.com/90880660/158111362-5b01db04-8890-4629-94ae-01e63e656478.gif)
 
특정 셀을 선택할 경우 기존 RightBarButtonItem의 title이 `Done`이 아닌 `Edit`으로 뜨도록 구현을 해야 했습니다. 따라서 기존의 `WorkFormViewController`는 공유하되, 만약 `titleTextField`가 비어있을 경우만 RightBarButtonItem의 title이 `Done`이 되도록 구현을 했습니다. 
 
또한 RightBarButtonItem의 title에 따라 update를 해줄지, Create를 해줄지 분기할 수 있도록 구현했습니다. 

```swift
@IBAction private func touchUpRightBarButton(_ sender: UIBarButtonItem) {
    if rightBarButtonItem.title == Content.doneTitle {
        if titleTextField.text == Content.isEmpty {
            titleTextField.text = Content.EmptyTitle
        }

        let work = Work(title: titleTextField.text, body: bodyTextView.text, dueDate: datePicker.date)

        viewModel?.addWork(work)
    } else if rightBarButtonItem.title == Content.editTitle {
        guard let passedWork = passedWork else { return }

        viewModel?.updateWork(
            passedWork,
            title: titleTextField.text,
            body: bodyTextView.text,
            date: datePicker.date
        )
    }

    dismiss(animated: true, completion: nil)
}
 ```

또한 셀을 선택했을 때 뿐만 아니라 특정 셀을 Long press로 누를 경우 Popover가 뜨면서 다른 tableView로 이동할 수 있도록 구현을 해야 했습니다. 
![프로젝트매니저_업데이트이동](https://user-images.githubusercontent.com/90880660/158112030-bb70204d-e3a1-49e1-94a6-e9a8abe5fc90.gif)

따라서 셀의 `awakeFromNib` 메서드를 통해 셀이 Interface Builder나 nib 파일로 부터 로드가 되었을 때 해당 Cell에 gesture recognizer를 등록할 수 있도록 구현했습니다. 
또한 각 TableView마다 나오는 ActionSheet의 내용이 달라야했습니다. 
그래서 연산 프로퍼티를 통해 firstTitle과 secondTitle이 뭐가 나와야하는지를 지정해주었습니다. 그리고 update를 통해 Work의 Category를 변경했을 경우 해당 변경 내용을 `ViewModel`에 있는 `BehaviorSubject<[Work]>`에 알려줘야 했기에 `onNext`를 통해 변경된 `workMemoryManager`의 List들을 전달해주었습니다.

```swift
@objc private func showPopupMenu() {
    guard let viewModel = viewModel else { return }

    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    let firstAction = UIAlertAction(title: firstTitle, style: .default) { [weak self] _ in
        if self?.firstTitle == Content.moveToDoTitle {
            self?.change(category: .todo)
            viewModel.todoList.onNext(viewModel.workMemoryManager.todoList)
        } else {
            self?.change(category: .doing)
            viewModel.doingList.onNext(viewModel.workMemoryManager.doingList)
        }
    }
    let secondAction = UIAlertAction(title: secondTitle, style: .default) { [weak self] _ in
        if self?.secondTitle == Content.moveDoingTitle {
            self?.change(category: .doing)
            viewModel.doingList.onNext(viewModel.workMemoryManager.doingList)
        } else {
            self?.change(category: .done)
            viewModel.doneList.onNext(viewModel.workMemoryManager.doneList)
        }
    }

    alert.addAction(firstAction)
    alert.addAction(secondAction)
    alert.popoverPresentationController?.sourceView = self

    viewController?.present(alert, animated: true)
}
```
 
### 🔹 Delete
![프로젝트매니저_삭제](https://user-images.githubusercontent.com/90880660/158112662-2f819df8-a4ff-4fbe-a7ed-1234fe732962.gif)

삭제의 경우 Swipe를 통해 이루어졌습니다.
따라서 `UITableViewDelegate`의 메서드인 `tableView(_:trailingSwipeActionsConfigurationForRowAt:)`를 활용했습니다. 특히 선택된 셀이 `BehaviorSubject<[Work]>`에서 어디에 있는지 확인을 해야 했기에 map Operator를 통해 해당 indexPath.row의 요소를 가져와 이를 삭제하는 방식으로 구현했습니다. 
 
```swift
func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(
        style: .destructive,
        title: Content.swipeDeleteTitle
    ) { [weak self] _, _, _ in
        guard let viewModel = self?.viewModel else { return }
        guard let list = self?.list else { return }

        var selectedWork: Observable<Work?> {
            list.map { $0[safe: indexPath.row] }
        }

        _ = selectedWork.subscribe(onNext: { self?.selectedWork = $0 })

        if let work = self?.selectedWork {
            viewModel.removeWork(work)
        }
    }

    return UISwipeActionsConfiguration(actions: [deleteAction])
}
```

## 🔫 Trouble Shooting
### 🔸 MVVM에 맞는 View와 ViewModel 설계
MVVM의 설계를 위한 기준에 맞춰 View와 ViewModel을 만들고 싶었으나 기존에는 View가 Model의 타입을 직접 알고 있었고, View가 ViewModel의 메서드를 직접 알고 있는 문제가 있었습니다.
따라서 MVVM에 보다 적합한 설계를 위해 [tailec/ios-architecture](https://github.com/tailec/ios-architecture/tree/master/mvvm-rxswift-pure)를 참고하여 설계를 수정했습니다. 
    
또한 ViewModel은 View를 추상화했다고 판단했고 추상화가 다르다면 ViewModel을 따로 두는 방식을 선택했습니다. 이를 통해 각 View에 해당하는 ViewModel이 불필요한 데이터나 메서드를 가지고 있지 않을 수 있도록 구현했습니다.

#### 🔹 ViewModel의 설계
일단 추상화가 다를 경우 ViewModel이 여러 개 생기게 되기 때문에 ViewModel을 프로토콜을 통해 추상화를 해놓았습니다.

```swift
protocol ViewModelDescribing {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
    
}
```

이를 통해 일단 ViewModel을 설계했습니다.
일단 Input과 Output을 ViewModel 클래스 내부에 정의를 해줬습니다.

- Input의 경우 어떤 Action이 발생했는지 인식하는 역할을 수행하며 만약 ViewModel에서 처리할 때 필요한 데이터가 있다면 Input을 통해 받을 수 있도록 Observable 타입으로 선언했습니다.
- Output의 경우 추후 View에서 띄워야 하는 UI가 있거나 하는 경우 사용할 수 있도록 구현했습니다.
 

이를 통해 View가 직접 비즈니스 로직을 갖고 있지 않더라도, ViewModel이 구조화되어 액션에 대한 처리를 할 수 있도록 했습니다.

하지만 여기서 MVVM의 단점도 찾을 수 있었습니다. 모든 Action에 대한 비즈니스 로직을 ViewModel이 처리를 해야하다 보니 ViewModel이 비대해질 수 있고, 너무 많은 Input과 Output이 생길 수 있다는 점에선 분명 단점이라고 생각했습니다. 

(예시를 위해 코드는 일부 생략했습니다)
```swift
private enum Content {
    
    static let editTitle = "Edit"
    static let doneTitle = "Done"
    
}

class WorkFormViewModel: ViewModelDescribing {
    
    final class Input {
        
        let viewDidLoadObserver: Observable<Void>
        
        init(viewDidLoadObserver: Observable<Void>) {
            self.viewDidLoadObserver = viewDidLoadObserver
        }
        
    }
    
    final class Output {
    
        let showRightBarButtonItemObserver: Observable<String>
        
        init(showRightBarButtonItemObserver: Observable<String>) {
            self.showRightBarButtonItemObserver = showRightBarButtonItemObserver
        }
        
    }
    
    private(set) var selectedWork: Work?
    private(set) var workMemoryManager: WorkMemoryManager!
    private var list = BehaviorSubject<[Work]>(value: [])
    private let disposeBag = DisposeBag()
    
    func setup(selectedWork: Work?, list: BehaviorSubject<[Work]>, workMemoryManager: WorkMemoryManager) {
        self.selectedWork = selectedWork
        self.list = list
        self.workMemoryManager = workMemoryManager
    }
    
    func transform(_ input: Input) -> Output {
        let showRightBarButtonItemObserver = PublishSubject<String>()
        
        configureViewDidLoadObserver(by: input, observer: showRightBarButtonItemObserver)
        
        let output = Output(
            showRightBarButtonItemObserver: showRightBarButtonItemObserver
        )
        
        return output
    }
    
    private func configureViewDidLoadObserver(by input: Input, observer: PublishSubject<String>) {
        input
            .viewDidLoadObserver
            .bind(onNext: { [weak self] in
                if self?.selectedWork == nil {
                    observer.onNext(Content.doneTitle)
                } else {
                    observer.onNext(Content.editTitle)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
```

코드에서 `ViewDidLoad` 시점에 선택된 셀(작업)이 없을 경우 `RightBarButton`을 `Done`으로 두고, 선택된 셀이 있을 경우 `Edit`으로 바꿔야 하는 로직 역시 비즈니스 로직이라 판단했습니다.
따라서 일단 `ViewDidLoad`가 되었는지를 `ViewModel`이 알아야 하기 때문에, Input으로 `viewDidLoadObserver`를 두었습니다.

이땐 단순히 viewDidload가 되었다는 것만 알면 되기 때문에 `Observable<Void>`로 어떤 값도 받아오지 않았지만, 만약 Input에 데이터를 받아와서 해당 데이터를 처리해야 한다면 `Observable<받아야하는 데이터의 타입>`이렇게 작성해주고 View에서 데이터를 받을 수 있도록 구현했습니다.

    
또한 이에 대한 output으로 화면에 바뀐 Title의 `RightBarButton`을 보여줘야 하기 때문에 `showRightBarButtonObserver`를 두었고, 이땐 String을 데이터로 내보내야 하기 때문에 `Observable<String>`으로 타입을 작성해주었습니다.

##### ❓왜 Input과 Output을 Observable로 선언했을까?
`PublishSubject`나 `BehaviorSubject`같은 `Subject` 타입을 사용하면 값을 외부에서 넣을 수 있기 때문입니다. 따라서 외부에서 ViewModel의 값을 마음대로 변경할 수 없도록 하기 위해, Notification을 받을 순 있지만 외부에서 값을 주입받을 수는 없는 `Observable` 타입을 사용했습니다.
    
내부에서 값을 전달해줄 때에는 `PublishSubject`를 사용했고 Input과 Output을 생성할 때에는 `asObservable()` 메서드를 통해 Observable 타입으로 변경해주었습니다.

 
이렇게 설계한 ViewModel과 View를 상호작용할 수 있도록 하는 메서드를 `transform(input:) -> Output`으로 정의했습니다.
```swift
func transform(_ input: Input) -> Output {
    let showRightBarButtonItemObserver = PublishSubject<String>()

    configureViewDidLoadObserver(by: input, observer: showRightBarButtonItemObserver)

    let output = Output(
        showRightBarButtonItemObserver: showRightBarButtonItemObserver
    )

    return output
}
``` 
    
여기서 configureViewDidLoadObserver 메서드에서 외부에서 input을 받아 처리를 해주고, output이 있다면 output에 해당하는 observer에 데이터를 넣어서 output을 정의하고 이 output을 return하는 구조로 설계를 했습니다.

 
#### 🔹 그럼 View에서 어떻게 input에 값을 넣어주고 output을 사용할까?
```swift
final class WorkFormViewController: UIViewController {
    
    @IBOutlet weak private var rightBarButtonItem: UIBarButtonItem!
    
    private let viewDidLoadObserver: PublishSubject<Void> = .init()
    private var disposeBag = DisposeBag()
    private var viewModel = WorkFormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadObserver.onNext(())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    private func bind() {
        let input = WorkFormViewModel.Input(
            viewDidLoadObserver: viewDidLoadObserver.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        configureShowRightBarButtonItemObserver(output)
    }
    
    private func configureShowRightBarButtonItemObserver(_ output: WorkFormViewModel.Output) {
        output
            .showRightBarButtonItemObserver
            .subscribe(onNext: { [weak self] in
                self?.rightBarButtonItem.title = $0
            })
            .disposed(by: disposeBag)
    }
}
```
    
**bind 메서드**

이는 viewModel로 넘겨줄 input의 인스턴스를 생성하고, viewModel의 transform 메서드를 사용해 input에 대한 처리를 ViewModel에 맡기고 output을 통해 View에 보여줄 데이터를 받기 위한 메서드입니다. 

일단 View가 init되는 시점에서 bind를 해주어야 하기 때문에, required init(coder:)에서 bind 메서드를 사용했습니다.
이렇게 bind를 해주고 추후 ViewModel에 작성한 비즈니스로직이 필요한 Action을 했을 때 정의해놓은 input 프로퍼티에 값을 전달하여 ViewModel에서 이를 캐치하고 동작할 수 있도록 설계했습니다. 


해당 설계를 도식화해서 살펴보면 다음과 같습니다. 

<img width="900" alt="스크린샷 2022-03-18 오후 4 56 01" src="https://user-images.githubusercontent.com/90880660/158966760-ca461121-1876-4cd5-be1e-7f486e686ad9.png">


이렇게 구현을 할 경우 ViewModel에는 UI 관련 코드가 없기 때문에 테스트가 용이해지며, ViewModel은 비즈니스 로직 / View는 UI만 다루게 되어 역할도 명확하게 분리가 된다는 장점이 생긴다고 판단했습니다.
