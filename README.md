# 🗂 프로젝트 매니저

1. 프로젝트 기간: 2022.02.28 - 2022.03.25
2. Ground Rules
    1. 시간
        - 시작시간 10시
        - 점심시간 12시~2시
        - 저녁시간 6시~8시
    - 진행 계획
        - 프로젝트가 중심이 아닌 학습과 이유에 초점을 맞추기
        - 의문점을 그냥 넘어가지 않기
    - 스크럼
        - 10시에 스크럼 시작
3. 커밋 규칙
    1. 단위
        - 기능 단위
    - 메세지
        - 카르마 스타일

## 🗂 목차

- [⌨️ 키워드](#-키워드)
- [STEP 1 : 프로젝트 적용기술 선정](#STEP-1--프로젝트-적용기술-선정)
    + [고민했던 것](#1-1-고민했던-것)
    + [의문점](#1-2-의문점)
    + [배운 개념](#1-3-배운-개념)
- [STEP 2 : 프로젝트 할일 리스트 구현](#STEP-2--프로젝트-할일-리스트-구현)
    + [고민했던 것](#2-1-고민했던-것)
    + [의문점](#2-2-의문점)
    + [Trouble Shooting](#2-3-Trouble-Shooting)
    + [배운 개념](#2-4-배운-개념)
    + [PR 후 개선사항](#2-5-PR-후-개선사항)

## ⌨️ 키워드
* `Swift Package Manager`
    * `SwiftLint` `Firebase-cloud firestore`
* `Clean Architecture MVVM`
    * `Presentation` `Domain` `Data`
    * `Storage` `Repository` `UseCase`
* `RxSwift` `RxCocoa`
    * `Observable` `Subject` `bind`
* `UILongPressGestureRecognizer`


# STEP 1 : 프로젝트 적용기술 선정

* 프로젝트에 적용할 기술을 조사하여 선정합니다.

## 1-1 고민했던 것

* 하위 버전 호환성에는 문제가 없는가?
* 안정적으로 운용 가능한가?
* 미래 지속가능성이 있는가?
* 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
* 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
* 이 앱의 요구기능에 적절한 선택인가?

## 1-2 의문점

* Firebase로 로컬/리모트를 둘다 관리할 수 있어 CoreData가 꼭 필요한지 의문이다.

## 1-3 배운 개념

* 프로젝트에 적용할 기술에 대한 충분한 사전 조사와 깊은 고민 후 결정해보기
* 다양한 기술 중 `목적`에 맞는 기술을 선택하기

[![top](https://img.shields.io/badge/top-%23000000.svg?&amp;style=for-the-badge&amp;logo=Acclaim&amp;logoColor=white&amp;)](#-프로젝트-매니저)

# STEP 2 : 프로젝트 할일 리스트 구현

프로젝트 리스트를 3개로 나누어 UI를 구현합니다.

## 2-1 고민했던 것

* `[Clean Architecture MVVM](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)를 참고하여 Model, ViewModel을 설계`
    * 의존성을 없애기 위해 기능들을 프로토콜로 추상화하여 타입을 쉽게 갈아끼울 수 있도록 구성

* `ViewModel을 Input과 Output으로 구분지어 설계`
    * 가독성을 위해 ViewModel의 Input과 Output을 Nested Type으로 구현
    * Input과 Output을 통해 뷰와 뷰모델 간의 바인딩이 매우 간결해졌다.

* `Coordinator 패턴 적용`
    * 화면 전환, 화면 제어를 담당하는 타입을 따로 설계하여 화면 전환 시 ViewController에서 사용할 ViewModel을 함께 주입해주는 역할도 동시에 하게 된다.
    * ViewController가 담당하던 일들을 Coordinator 패턴을 통해 분리가 가능해졌다.

* `Memory leak을 방지`
    * Rx의 경우 클로저를 활용하여 구성하기 때문에 self 사용에 의한 강한 참조 사이클 발생을 방지하기 위해서 `withUnretained()` operator를 활용했다.
    * Modal의 경우 버튼이 아니라 modal창 외부를 터치해서 창을 닫았을 때 계속 메모리에서 사라지지않고 남아있는 부분을 확인했으며, View Life Cycle을 통해 뷰가 사라질 때 ViewModel, Coordinator, Controller 모두 메모리에서 사라질 수 있도록 해주었다.

    > 개선하기 전
    ![](https://i.imgur.com/hvUBDML.png)

    > 개선하고난 후
    ![](https://i.imgur.com/Ik1TvL9.png)

## 2-2 의문점

* ViewModel의 테스트는 어떻게 진행해야 적절할까?
* 왜 MVVM를 선호하고 많이들 사용하는 걸까?
* RxCocoa로 TableView를 추가, 수정, 삭제할 때 애니메이션 효과를 주고 싶은데...
* 지금은 데이터가 메모리에 있지만, 나중에 CoreData나 FireStore를 쓸 때 손쉽게 갈아끼워줄 수는 없을까?
* ViewModel에 UIKit을 import해도 되나..?
* ViewModel의 transform 메소드가 너무 긴데 분리하는게 좋은걸까?
* Rx로 UITableView의 headerView는 어떻게 설정해줄까?

## 2-3 Truouble Shooting

### 1. ViewModel을 Rx를 활용하여 리팩토링해보기

* `상황` 기존에는 Observable을 직접 구현하여 bind를 해주고 있었으나, Rx로도 할 수 있는 걸 왜.. 직접 구현하고 있지? 라는 의문이 들었다. 모른다고 회피하다가... 찝찝했는지 ViewModel을 꼭!!! Rx로 리팩토링 꼭!!! 해보고싶어서 삽질을 시작하게 되었다.
```swift
final class ProjectListViewModel {
...
    var deleted: Observable<IndexPath>
...

class ViewController: UIViewController {
    
    func viewDidLoad() {
        viewModel.deleted.asObservable()
            .subscribe(onNext: { indexPath in
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }).disposed(by: bag)

    }
...
```
* 일단 ViewController에서는 위와 같은 방식으로 바인딩 해주어서 사용해주고 싶었다.
* 처음에는 직접 구현한 Observable이 아니라 Rx의 Observable을 활용해보려고 했었는데, 실패했다.
* `이유` 그 이유는 Observable의 경우 값을 넘겨주는 역할만 하지 값을 외부에서 받아들여서 넘겨주는 역할은 하지 않기 때문이다.
* `해결` 따라서 값을 받아먹을 수 있으면서 이 값을 외부에서 컨트롤할 수 있는 것이 뭐가 있을까 찾아보다가 `Subject`라는 오퍼레이터를 알게되었다.
    * 그중 `PublishSubject`가 적절하다고 느꼈다. 초기에는 UI 업데이트가 동작하지 않다가, 이후에 데이터를 전달해주면 subscribe가 실행된다.
```swift
final class ProjectListViewModel {
...
    var deleted = PublishSubject<IndexPath>()
...
    func delete(_ indexPath: IndexPath, completion: ((Project?) -> Void)?) {
        useCase.delete(projects[safe: indexPath.row]) { item in
            guard let item = item else {
                self.errorMessage.onNext("삭제를 실패했습니다.")
                completion?(nil)
                return
            }
            self.projects = self.useCase.fetch()
            self.deleted.onNext(indexPath)
            completion?(item)
        }
    }
...

class ViewController: UIViewController {
    
    func viewDidLoad() {
        viewModel.deleted
            .subscribe(onNext: { indexPath in
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }).disposed(by: bag)

    }
```
* 먼저 UITableView의 Delete 이벤트가 발생했을 때 ViewModel의 delete 메소드를 호출하여 인자로 indexPath를 전달한다.
* 이후 useCase에 데이터를 삭제해달라는 요청을 한 후 deleted 프로퍼티에 onNext로 인자로 받았던 indexPath를 onNext로 전달한다.
* 데이터를 전달하고나면 subscribe에 등록되어있는 deleteRows 메소드가 호출되면서 뷰가 알아서 테이블뷰의 셀을 제거해준다. 

### 2. UI의 value를 변경하지 않았는데, 발생되는 이벤트 때문에 기존 데이터가 사라지는 버그

* DetailViewController에 ViewModel을 바인딩 해줄 때 input을 아래와 같이 적어주었었다.
```swift
let input = DetailViewModel.Input(
    didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
    didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
    didChangeTitleText: titleTextField.rx.text.asObservable(),
    didChangeDatePicker: datePicker.rx.date.asObservable(),
    didChangeDescription: descriptionTextView.rx.text.asObservable())
)
```
* `상황` 여기서 didChange... 프로퍼티는 text, date, text 같은 그냥 value에 접근하고 있는데, Definition에 가보면 `[.allEditingEvents, .valueChanged]` 이 두가지 이벤트가 발생했을 때 이벤트를 발생시킨다.
* 여기서 allEditingEvents라 하면, UITextField의 모든 editing touch라고 정의하고 있다.
* `이유` 즉 값을 입력하기 위한 터치, 입력된 값을 수정하기 위한 터치, 입력 완료되어 키보드를 내리는 동작 모두 이벤트를 발생시킨다는 것이다. 
* 내가 원했던건 값이 변경될 때만 이벤트가 발생했던 부분이라 rx.text라는 ControlProperty는 적절하지 않았다.
* `해결` 따라서 다른 적절한 프로퍼티를 찾게되었는데, changed라는 ControlEvent타입의 프로퍼티다.
    * 사용자가 해당하는 컨트롤의 값을 변경할때마다 이벤트가 방출된다.
* 즉, 값을 변경했을 때만 이벤트가 방출한다는 뜻이다.
* 따라서 아래와 같이 리팩토링을 진행해주었더니 버그가 해결되었다.

```swift
let input = DetailViewModel.Input(
    didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
    didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
    didChangeTitleText: titleTextField.rx.text.changed.asObservable(), // changed
    didChangeDatePicker: datePicker.rx.date.changed.asObservable(), // changed
    didChangeDescription: descriptionTextView.rx.text.changed.asObservable() // changed
)
```
### 3. modal을 닫을 때 메모리 누수 발생

* 시뮬레이터로 앱을 실행해보다가 메모리가 대폭 상승하고 줄어들지는 않아서, 메모리 누수가 있는지 확인해보았다.

![](https://i.imgur.com/GbcKLb2.png)

* `상황` modal을 열고 다른 부분을 터치하여 닫았을 때, 참조 카운트가 늘어나고 줄어들지는 않는 현상이 있었다.
    * Cancel 버튼을 눌렀을 땐 정상적으로 사라짐...
* 확인해보니 Cancel버튼을 누르지 않고 다른 View를 터치해서 modal을 닫았을 때에는, 정상적인 dismiss가 이루어지지 않는 것처럼 보였다.
* `해결` 그래서 View Life Cycle을 활용하여 viewDidDisappear 시점에 ViewModel, Coordinator, Controller 모두 메모리에서 사라질 수 있도록 구현을 해주었다.

> 개선하고 난 후 분석 결과

![](https://i.imgur.com/YWf4Ejj.png)

## 2-4 배운 개념

<details>
<summary>[RxSwift로 데이터 바인딩 해보기]</summary>
<div markdown="1">

데이터 바인딩을 통하여 테이블뷰의 delete 이벤트가 발생되면, 그에 따라 데이터도 제거해주고, 해당하는 셀이 알아서 제거될 수 있도록 해볼 것이다.

먼저 ViewModel에 셀을 제거하기 위해 필요한 IndexPath 데이터를 가지고 있는 `PublishSubject<IndexPath>`를 생성한다.

```swift
final class ProjectListViewModel {
    var deleted = PublishSubject<IndexPath>()
// ...
```

> `Subject`란?
> Observable은 값을 넘겨주는 역할을 하지, 값을 외부에서 받아들여서 넘겨주는 역할은 하지않는다. 그래서 Observable처럼 값을 받아먹을 수는 있는 애인데 외부에서 이 값을 컨트롤할 순 없을까? 하고 나온 것이 Subject이다. Observable과 Observer역할을 동시에 수행한다.
* 총 4가지의 종류가 있다.
    * `AsyncSubject`
        * 여러개가 구독을 하고 있더라도 다 안내려보내준다.
        * 그러다가 completes되는 시점에 가장 마지막에 있던 거를 모든 애들한태 다 내려주고 complete을 시킨다.
    * `BehaviorSubject`
        * 기본값을 가지고 시작한다.
        * 아직 데이터가 생성되지 않았을 때 누군가가 subscribe를 하자마자 기본값을 내려준다.
        * 그리고 데이터가 생기면 그때마다 계속 내려준다.
        * 새로운 게 중간에 subscribe를 하고나면 가장 최근에 발생했던 값을 일단 내려주고나서 그 다음부터 발생하는 데이터를 똑같이 모든 구독하는 애들한태 내려보내준다.
    * `PublishSubject`
        * subscribe를 하면 데이터를 그대로 내려보내준다.
        * 다른 subscribe가 또 새롭게 subscribe 할 수 있다. 그럼 또 데이터가 생성된다면 subscribe하고 있는 모든 관찰자한태 데이터를 내려준다.
    * `ReplaySubject`
        * subscribe를 했을 때 그대로 순서대로 데이터를 내려보내준다.
        * 두번째로 subscribe를 한다면 여태까지 발생했던 모든 데이터를 다 내려준다. 한꺼번에 Replay를 하는 것이다.

내가 원했던 것은 새 이벤트가 발생했을 때에만 subscribe가 실행되었으면 했다. 따라서 새로운 이벤트만 전달받고 이전에 발생했던 이벤트는 버리는[?] PublishSubject를 선택했다.

이후 이벤트를 발생시키기 위해 위에서 생성했던 deleted에 데이터를 전달하는 ViewModel에 메소드를 생성하였다.

```swift
func delete(_ indexPath: IndexPath, completion: ((Project?) -> Void)?) {
        useCase.delete(projects[safe: indexPath.row]) { item in
            guard let item = item else {
                self.errorMessage.onNext("삭제를 실패했습니다.")
                completion?(nil)
                return
            }
            self.projects = self.useCase.fetch()
            self.deleted.onNext(indexPath)
            completion?(item)
        }
    }
```

보면 인자로 받은 indexPath를 deleted에 전달하고 있는 형태이다.
이렇게 onNext로 새 데이터를 전달할 때마다 subscribe가 실행된다고 보면된다.

ViewController에 가서 바인딩을 해주자.

```swift
class ViewController: UIViewController {

    var viewModel = ProjectListViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bind()
    }
    
    func bind() {
        viewModel.deleted
            .subscribe(onNext: { indexPath in
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }).disposed(by: bag)
    }
// ...
}
```

전달받은 indexPath로 셀을 지울 수 있도록 deleteRows 메소드를 호출해주었다.
그리고 Delegate 메소드에서 delete 이벤트가 일어났을 때 ViewModel의 delete 메소드를 호출하도록 해주었다.

```swift
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath, completion: nil)
        }
    }
}
```

흐름을 다시 정리하자면...
* 셀 삭제 이벤트가 발생되면 ViewModel의 delete 메소드를 호출하여 indexPath를 전달한다.
* 메소드 내부에서 ViewModel의 PublushSubject인 deleted에게 `onNext`로 `새 indexPath`를 전달한다.
* 새 데이터를 전달받은 `PublushSubject`는 구독하고 있는 애들에게 이벤트가 발생했으니 subscribe를 실행하라고 알림을 준다.
* 바인딩해두었던 `subscribe`가 호출되면서 셀이 삭제된다.

이렇게 해주면 View는 알아서 UI를 업데이트 하게 되고, ViewModel에서도 UseCase에게 데이터를 삭제요청해서 테이블뷰의 보여질 데이터도 업데이트 된다.

    
</div>
</details>
    
<details>
<summary>[RxSwift 사용시 클로저 내부 self를 약하게 참조시키기]</summary>
<div markdown="1">

* 보통은 클로저 내부에서 강한 참조 사이클을 방지하기 위해 weak self와 guard let self를 활용하여 바인딩 처리를 해주는데, 이 동작을 간결하게 해주는 operator가 존재했다.
* RxSwift 6.0부터 새롭게 생겼으며, weak self 대신 활용할 수 있다.

```swift=
viewModel.someInfo  // Observable<String>
    .withUnretained(self)  // (self, String) 튜플로 변환해줌
    .bind { (owner, string) in
        owner.label.text = string // owner를 self 대신 사용!
    }
    .disposed(by: disposeBag)
```

</div>
</details>
    
<details>
<summary>[Memory Leak 확인하는 방법]</summary>
<div markdown="1">

> modal을 Cancel 버튼이 아니라 다른 View를 터치해서 창을 내릴 경우 메모리에서 사라지지 않고 메모리가 계속 늘어나는 것을 확인했다. 정확히 메모리 누수가 발생하는 것인지 궁금하여 찾다가 `Instrumnets`라는 도구를 알게되었다.

* 메모리 누수가 되고있는지 확인하려면 `Command + I`를 눌러 빌드를 한다.
* 그러면 Instrumnets 도구가 뜨는데...
    * Instrumnets란?
        * Xcode에 통합된 일련의 애플리케이션 성능 분석 도구
        * Allocation 상태를 확인 가능
        * Memory leak 상태 확인 가능
* 도구가 뜨면 여러 아이콘 중에서 `Allocations`라는 아이콘을 클릭하면,

![](https://i.imgur.com/QAUgfyN.png)

* 위와 같은 창이 나타난다.
* 여기서 좌측에 빨간색 녹화버튼을 누르면 시뮬레이터가 실행되면서 수치를 기록해준다.

![](https://i.imgur.com/YWf4Ejj.png)

* 메모리 누수가 발생할 경우 아래처럼 메모리 카운트가 올라간다.

![](https://i.imgur.com/GbcKLb2.png)

</div>
</details>

<details>
<summary>[Coordinator 패턴]</summary>
<div markdown="1">


### Coordinator란?

* 하나 이상의 뷰 컨트롤러들에게 지시를 내리는 객체이며, 여기서 말하는 지시는 View의 트랜지션을 의미한다.
* 즉, Coordinator는 앱 전반에 있어 화면 전환 및 계층에 대한 흐름을 제어하는 역할을 한다.

### 수행기능

* 화면 전환에 필요한 인스턴스 생성(ViewController, ViewModel ...)
* 생성한 인스턴스의 종속성 주입(DI)
* 생성된 ViewController의 화면 전환

### 왜 사용할까?

* ViewController가 담당하던 화면 전환 책임을 Coordinator가 담당하게되면서, 화면전환 시 ViewController에서 사용할 ViewModel을 함께 주입해줄 수 있다.
* 또한 화면 전환에 대한 코드를 따로 관리하게 되면서 재사용과 유지보수를 편하게 만들어주기 때문에 주로 사용한다.
* 정리하자면 Coordinator는 화면 전환 제어 담당과 의존성 주입을 가능하게 해주는 허브라고 생각하면 될 것 같다.

</div>
</details>    

<details>
<summary>[UIAlertController를 Rx스럽게 리팩토링 해보기]</summary>
<div markdown="1">

```swift
func showActionSheet(
    sourceView: UIView,
    titles: (String, String),
    topHandler: @escaping (UIAlertAction) -> Void,
    bottomHandler: @escaping (UIAlertAction) -> Void
) {
    let topAction = UIAlertAction(title: "Move to \(titles.0)", style: .default, handler: topHandler)
    let bottomAction = UIAlertAction(title: "Move to \(titles.1)", style: .default, handler: bottomHandler)
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(topAction)
    alert.addAction(bottomAction)
    if let popoverController = alert.popoverPresentationController {
        popoverController.sourceView = sourceView
        let rect = CGRect(x: .zero, y: .zero, width: sourceView.bounds.width, height: sourceView.bounds.height / 2)
        popoverController.sourceRect = rect
        popoverController.permittedArrowDirections = [.up, .down]
    }
    navigationController.topViewController?.present(alert, animated: true)
}
```
* 라이언한태 코드리뷰 받고난 후 escaping 클로저만 보면... '아 옵저버블 쓸 수 있을 거 같은데?' 라는 생각에 빠진다.
* 오늘도 어김없이 옵저버블을 쓸 수 있을 것 같아서 찾아보니까... 예제코드들이 많길래 도전해보았다.
* 따라서 위 코드를 아래와 같이 수정해보았다.

```swift
enum ActionType: CaseIterable {
    case top
    case bottom
}

func showActionSheet(sourceView: UIView, titles: [String]) -> Observable<ProjectState> {
    return Observable.create { observer in
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ActionType.allCases.enumerated().forEach { index, _ in
            let action = UIAlertAction(title: "Move to \(titles[index])", style: .default) { _ in
                observer.onNext(ProjectState(rawValue: titles[index]) ?? ProjectState.todo)
                observer.onCompleted()
            }
            alert.addAction(action)
        }
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sourceView
            let rect = CGRect(
                x: .zero,
                y: .zero,
                width: sourceView.bounds.width,
                height: sourceView.bounds.height / 2
            )
            popoverController.sourceRect = rect
            popoverController.permittedArrowDirections = [.up, .down]
        }
        self.navigationController.topViewController?.present(alert, animated: true)

        return Disposables.create {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
```
* 뭐가 많이 바뀐 것 같지만... 별거없다.
* ActionType이라는 enum을 만들고 해당 케이스를 반복하면서 핸들러 내부에 onNext로 ProjectState라는 데이터와 함께 이벤트를 전달해준다.
* 나머지는 iPad를 위한 popover 설정...
```swift
showActionSheet(sourceView: cell, titles: project.status.excluded)
    .subscribe(onNext: { state in
        self.useCase.changedState(project, state: state)
    }).disposed(by: disposeBag)
```
* 사용할 때(구독)는 onNext로 전달받은 state값으로 project의 상태값을 바꿔주는 작업을 해주었다.
* 이때 파라미터로 sourceView를 넘겨주는 이유는 popover를 띄울 위치를 잡기 위함인데... ViewModel에 UIKit을 import해야해서 몹시 불편하다..
* 이부분은 고민해보았지만 좋은 방법이 떠오르지가 않아서 개선하지 못했다.


</div>
</details>

<details>
<summary>[UI의 value가 변경되었을 때만 이벤트 받기]</summary>
<div markdown="1">

```swift
let input = DetailViewModel.Input(
    didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
    didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
    didChangeTitleText: titleTextField.rx.text.asObservable(),
    didChangeDatePicker: datePicker.rx.date.asObservable(),
    didChangeDescription: descriptionTextView.rx.text.asObservable())
)
```
* 처음엔 위와 같이 단순하게 input을 만들어주었는데...
* 이렇게 만들다보니 TextField의 경우 값을 수정하지 않고 tap해서 활성화만 해도 이벤트를 전달받는 것을 확인했다.
    * 이러면 값을 변경하지 않고 modal을 닫아도, 이벤트를 받고 값이 수정된 것 마냥 빈문자열이 들어와서 기존 데이터가 사라지는... 버그가 발생했다.
    * 아무것도 안해도.. Modal만 띄우고 닫아도.. 빈문자열 이벤트를 받아서 데이터가 지워지는....🥲
* 구글링을 해보니 changed라는 ControlProperty를 찾게 되었고, 아래와 같이 값이 변경될때 마다 이벤트를 전달하는 옵저버블로 변경해주었다

```swift
let input = DetailViewModel.Input(
    didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
    didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
    didChangeTitleText: titleTextField.rx.text.changed.asObservable(), // changed
    didChangeDatePicker: datePicker.rx.date.changed.asObservable(), // changed
    didChangeDescription: descriptionTextView.rx.text.changed.asObservable() // changed
)
```

* 그리고 output을 설정해줄때 논옵셔널 타입으로 설정해주었는데, 옵셔널 타입으로 바꿔주고, nil일 경우 기존 데이터를 전달해서, 값이 임의로 변경되지 않도록 처리해주었다.
* 이렇게 하니까 값을 수정하지 않으면 정상적으로 수정되지 않았고, 해당 문제를 해결할 수 있었다.



</div>
</details>
    
## 2-5 PR 후 개선사항

* 테스트 메소드명 개선
* 명확한 네이밍 처리
* Completion 대신 RxSwift Observable로 개선
* 메소드 대신 RxSwift를 활용하여 스트림 형식으로 개선해보기

[![top](https://img.shields.io/badge/top-%23000000.svg?&amp;style=for-the-badge&amp;logo=Acclaim&amp;logoColor=white&amp;)](#-프로젝트-매니저)
