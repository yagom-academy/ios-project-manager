# 🗂 프로젝트 매니저

1. 프로젝트 기간: 2022.02.28 - 2022.03.11
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

## ⌨️ 키워드
* `Swift Package Manager`
    * `RxSwift` `SwiftLint` `Firebase-cloud firestore`
* `Clean Architecture MVVM`
    * `Presentation` `Domain` `Data`
    * `Storage` `Repository` `UseCase`
* `RxSwift`
    * `Observable` `Subject`


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

* [Clean Architecture MVVM](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)를 참고하여 Model, ViewModel을 설계
    * 의존성을 없애기 위해 기능들을 프로토콜로 추상화하여 타입을 쉽게 갈아끼울 수 있도록 구성

## 2-2 의문점

* ViewModel의 테스트는 어떻게 진행해야 적절할까?
* 왜 MVVM를 선호하고 많이들 사용하는 걸까?
* RxCocoa로 TableView를 추가, 수정, 삭제할 때 애니메이션 효과를 주고 싶은데...
* 지금은 데이터가 메모리에 있지만, 나중에 CoreData나 FireStore를 쓸 때 손쉽게 갈아끼워줄 수는 없을까?

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
    * 그중 `PublishSubjec`t가 적절하다고 느꼈다. 초기에는 UI 업데이트가 동작하지 않다가, 이후에 데이터를 전달해주면 subscribe가 실행된다.
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

[![top](https://img.shields.io/badge/top-%23000000.svg?&amp;style=for-the-badge&amp;logo=Acclaim&amp;logoColor=white&amp;)](#-프로젝트-매니저)
