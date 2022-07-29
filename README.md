# 프로젝트 관리 앱

## PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/125)
- [STEP 2-1](https://github.com/yagom-academy/ios-project-manager/pull/133)
- [STEP 2-2](https://github.com/yagom-academy/ios-project-manager/pull/141)
- [STEP 2-3](https://github.com/yagom-academy/ios-project-manager/pull/151)


## 외부 라이브러리

| Local DB | Remote DB | UI | Reactive | Layout |
|---|---|---|---|---|
| `Realm` | `Firebase` | `RxCocoa` | `RxSwift` | `SnapKit` |


## 의존성 관리도구

| `Swift Package Manager` |
|---|

## 구조

| `MVVM-C` | `Clean Architecture` |
|---|---|

![](https://i.imgur.com/YgUZpW8.png)

구조는 `MVVM-C` 과 `Clean Architecture`를 적용시켰으며,
때문에 Scene의 의존성을 관리하는 `DIContainer`와, 화면전환을 담당하는 `FlowCoordinator`가 가장 상위 수준에 있으며, `Presentation`, `Domain`, `Data` Layer가 있다. 

![](https://i.imgur.com/PopuMU9.png)

위 그림과 같이 `Presentation`와 `Data` Layer는 `Domain` Layer만 의존한다.

## 기능 구현

### UI

![](https://i.imgur.com/7dbq4jN.png)

### 추가 및 수정

| 추가 | 수정 |
|-|-|
|![](https://i.imgur.com/OUgGlBf.gif)|![](https://i.imgur.com/SoftF3k.gif)|
| 상단에 `UIBarButtonItem`를 클릭하면 item을 추가하기위한 View가 올라오고, Done 버튼을 클릭하면 새로운 todoitem이 생성 | Cell을 클릭후 상단에 Edit 버튼을 클릭하면, 쓰기 모드로 변경 컨텐츠를 변경후 Done 버튼을 클릭하면 todoitem이 수정 |

### 지난 게시글 처리

| 지난 게시글 날짜 표현 |
|-|
| <img src="https://i.imgur.com/nFSyS99.png?"> |
 기한이 지난 게시글은 날짜 표현을 빨간색으로 처리하여 기한이 지난 글과 그렇지 않은 글을 구분 |

### Item 삭제 기능 구현

![](https://i.imgur.com/3LKDX9a.gif)

`rx`의 `modelDeleted()` 메서드를 이용하여 삭제 기능을 구현.

```swift
//  TodoListViewModel.swift
func cellDeleteButtonDidTap(item: TodoCellContent) {
    useCase.deleteItem(id: item.id)
}
```
위처럼 viewModel에선 item의 `UUID`을 넘겨 받고, 

```swift
//  TodoListUseCase.swift
func deleteItem(id: UUID) {
    guard let index = try? repository.read().value()
        .firstIndex(where: { $0.id == id }) else { return }
    
    repository.delete(index: index)
}
```

`UseCase`에서 넘겨 받은 `UUID`를 가지고 해당 item의 index를 찾아 `storege`에서 삭제하는 구조를 가지고 있다.

### TableView간 콘텐츠 이동

![](https://i.imgur.com/mPGqvyn.gif)

`Reactive`를 확장시켜 
```swift
func listLongPress<T>(_ type: T.Type) -> ControlEvent<(UITableViewCell, T)>
```
위 메서드를 통해 `LongPressGesture` 기능을 구현하였고, 두 버튼을 가지고 있는 `TodoMoveViewController`라는 VC를 만들어 popover를 통해 present.

```swift
//  TodoMoveViewModel.swift
final class DefaultTodoMoveViewModel {
    private func setButtonTitle(at state: State) -> (String, String) {
        switch state {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
    }
    
    var buttonTitle: Observable<(String, String)> {
        let buttonTitle = setButtonTitle(at: item.state)
        
        return Observable.just(buttonTitle)
    }
}
```
해당 VC의 VM은 해당 콘텐츠에 해당하는 item을 가지고 있고, 해당 `item`의 `State`를 `setButtonTitle` 메서드를 통해 두 버튼의 title을 반환 받아 `buttonTitle` 라는 `Observable`통해 결정 된다.

```swift
//  TodoListUseCase.swift
extension DefaultTodoListUseCase {
    func firstMoveState(item: TodoModel) {
        switch item.state {
        case .todo:
            changeTodoItemState(item: item, to: .doing)
        case .doing:
            changeTodoItemState(item: item, to: .todo)
        case .done:
            changTodoItemState(item: item, to: .todo)
        }
    }
    
    func secondMoveState(item: TodoModel) {
        switch item.state {
        case .todo:
            changeTodoItemState(item: item, to: .done)
        case .doing:
            changeTodoItemState(item: item, to: .done)
        case .done:
            changeTodoItemState(item: item, to: .doing)
        }
    }
}
```

`UseCase`에선 선택된 item을 VM로 부터 전달받아 두 메서드를 통해 item의 수정후 `update` 한다.


