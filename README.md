# 프로젝트 관리 앱

## 외부 라이브러리

| Local DB | Remote DB | UI | Reactive | Layout | Convention |
|---|---|---|---|---|---|
| `Realm` | `Firebase` | `RxCocoa` | `RxSwift` | `SnapKit` | `SwiftLint` |


## 의존성 관리도구

| `CocoaPods` |
|---|

## 구조

| `MVVM-C` | `Clean Architecture` |
|---|---|

## 해당 기술 스택을 선정한 이유

### Realm VS CoreData

| `Realm` |
|---|

Realm과 CoreData에 비해 빠른 속도와 높은 성능을 가지고 있습니다. 또한 Android와 데이터 공유 또한 가능하다. Realm이 CoreData에 비해 속도의 이점을 가져올 수 있었던 이유는 SQL 쿼리문을 실행하지 않고, Entitiy에 대한 매핑 처리가 필요없어 빠르게 읽어올 수 있다.

하지만, CoreData와 다르게 외부 라이브러리이고, 때문에 의존성 관리도구를 이용해야한다. 또한, 쓰레드 관리가 필요하다. 메인 쓰레드가 아닌 다른 쓰레드에서 접근하면 에러가 발생!

마지막으로, Realm을 선택한 이유는 CoreData 사용 경험이 있어, 사용 경험이 없는 Realm을 선택했습니다.

### RxSwift VS Combine

| `RxSwift` |
|---|

RxSwift와 Conbine중 RxSwift를 선택한 가장 큰 이유는 Conbine은 iOS 13.4 이전 버전에서 안정성 이슈가 있어 13.4 보다 낮은 버전까지 지원 가능한 앱을 만들기 위함이고, 또한 Conbine 보다 많은 자료와 다양한 Operators가 존재 및 다른 라이브러리와도 호환성이 좋다. 최종적으로 RxCocoa가 있어 UIKit과 좋은 호환성을 가진다.

단점으로는 Realm과 같이 의존성 관리도구가 필요하고, Conbine에 비해 낮은 성능을 가지고 있다.

### 그외에 기술스택

|| `Firebase` | `SnapKit` | `SwiftLint` |
|---|---|---|---|
| 선정 이유 | Firebase는 Remote DB 라이브러리 중 가장 널리 사용되는 라이브러리로 많은 자료가 존재 및 사용이 편리하다.  | SnapKit는 길고, 가독성이 떨어지는 AutoLayout 코드를 간결하고, 가독성을 높이는데 용의할 것이라 생각되어 선정하게 되었다. | SwiftLint의 경우 SwiftLint가 제공하는 룰을 통해 일관성 있는 컨벤션으로 코드를 작성 할 수 있다. |




