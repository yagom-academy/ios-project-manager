# 프로젝트 매니저 공유노트
 
# 🗂 프로젝트 매니저
> 프로젝트 기간 2022-07-04 ~ 2022-07-29 
팀원 : 👼[@Taeangel](https://github.com/Taeangel) 🔴[Red](https://github.com/cherrishRed) / 리뷰어 : [TOny](https://github.com/Monsteel)

- [프로젝트 소개](#프로젝트-소개)
- [개발환경 및 라이브러리](#개발환경-및-라이브러리)
- [키워드](#키워드)
- [STEP 1](#step1)
- [STEP 2](#step2)
- [STEP 3](#step3)

## 프로젝트 소개
🌼 간편한 아이패드 TodoList App!🌼

🧑🏻‍💻 할일이 너무 많아서 자꾸 까먹는 다구요?

📱 프로젝트 매니저로 할일을 정리하세요!

🔵 버튼을 눌러서 Remote 저장소와 동기화 하세요!

|할일을 생성|할일을 삭제|
|:---:|:---:|
|![create](https://i.imgur.com/zzxxaAu.gif)|![delete](https://i.imgur.com/WCP50kd.gif)|

|할일을 수정|할일 기록 보기|
|:---:|:---:|
|![edit](https://i.imgur.com/SMW7wq5.gif)|![history](https://i.imgur.com/564jnuH.gif)

## 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange?style=for-the-badge)]()

[![xcode](https://img.shields.io/badge/Xcode-15.5-blue?style=for-the-badge)]()

|Local DB|Remote DB|코드 규칙|비동기 이벤트|
|--|--|--|--|
|[![Realm](https://img.shields.io/badge/Realm-ff69b4?style=for-the-badge&logo=Realm)]()|[![firebase](https://img.shields.io/badge/firebase-008cff?style=for-the-badge&logo=Firebase)]()|[![swiftLint](https://img.shields.io/badge/swiftLint-333333?style=for-the-badge&logo=Swift)]()|[![combine](https://img.shields.io/badge/combine-orange?style=for-the-badge&logo=Swift)]()|


## 키워드
`SwiftUI`, `Combine`, `firebase`, `Realm`, `List`, `@State`, `@Binding`, `@StateObject`, `MVVM`, `@ObservedObject`, `@Published`, `UIHostingController`, `FirebaseFirestore` ``

## STEP1
[자세한 고민보기 STEP1-PR](https://github.com/yagom-academy/ios-project-manager/pull/154)
### 기능구현
- SPM으로 firebase, realm 설치 

### Realm 선정이유
|😁장점|😩단점|
|--|--|
|성능이 좋음|다중 쓰레드에서의 Realm 객체 관리 (쓰레드별 객체 관리 필요함)|
|Android, iOS DB 공유 가능|쓰레드 흐름에 익숙하지 않다면 거의 사용하기 힘들기 때문에 러닝커브가 어느정도 존재함.|
|Realm Studio가 있음|바이너리 용량이 늘어남|
||다양한 쿼리를 지원하지 않음|
||iOS8부터 지원가능|

> CoreData 를 사용해 본 적이 있기 때문에 다른 Local DB를 사용해 보고 싶었고, Realm 이 성능이 빠르고 보편화 되어 있는 것 같아 선정하였다.

### Firebase 선정이유
|😁장점|😩단점|
|--|--|
|무료!|부분 유료|
|개발 속도가 매우 빠르다|제한적인 쿼리.|
|다양한 서비스를 한번에 제공|응답 속도가 느림|
|백엔드 작업을 규격화하여 시간을 아낄 수 있음||

> 서버를 구현하지 않아도 되고, 일정한 데이터 까지는 무료로 사용할 수 있으며 통계 기능을 제공한다는 점에서 fireBase를 선정하였다. 

<details>
<summary>기술스택 CheckList</summary>
<div markdown="1">

`하위 버전 호환성에는 문제가 없는가?`
- [x] Realm - ios8 부터 사용 가능
- [x] Firebase - ios10 부터 사용이 가능
swiftUI 로 개발을 하기 때문에 타겟을 ios15로 설정하여 개발하므로 문제 없음.

`안정적으로 운용 가능한가?`
- [x] Realm - 멀티 쓰레드로 접근하지 않는 이상 안전하다고 생각
- [x] Firebase - 구글이 지원하기에 안전하다고 생각

`미래 지속가능성이 있는가?`
- [x] Realm - 앱 개발자들이 가장 많이 사용하고 있는 localDB이기 때문에 미래 지속가능성이 있을것 같다.
- [x] Firebase - 백엔드 보다는 프론트엔드 중심적으로 개발을 할 경우 좀더 특화되어 있기 때문에 앱의 초기단계나 공부를 할경우 다른 서버보다 활용도가 더 좋아 지속가능할 것 같다.

`리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?`
- [x] Realm - 멀티 쓰레드 관리를 잘 해주면 리스크를 최소화 할 수 있을 것 같다. 
- [x] Firebase - 유로로 가면 비싸지지만 서버 개발자가 없어도 되니 합리적이라고 말 할 수도 있을 것 같다.

`어떤 의존성 관리도구를 사용하여 관리할 수 있는가?`
- [x] Realm - SPM, cocoaPod
- [x] Firebase - SPM, cocoaPod

`이 앱의 요구기능에 적절한 선택인가?`
> 간단한 서버 구현이고, 빅데이터를 다루지 않고, 범용성이 높은 API 들이기 때문에 적절한 선택이라고 생각된다. 
</div>
</details>

### 🚀 trouble shooting
- SPM으로는 swiftlint를 설치가 불가능하여 homebrew로 swiftlint를 설치하였다.

## STEP2

[자세한 고민보기 STEP2-1-PR](https://github.com/yagom-academy/ios-project-manager/pull/135)

[자세한 고민보기 STEP2-2-PR](https://github.com/yagom-academy/ios-project-manager/pull/147)

### 🚀 trouble shooting

### NavigationView 가 한쪽으로 솔리고 Title 이 중앙에 오지 않는 현상
`🤔문제`

<img src="https://i.imgur.com/SqV6YYH.png" width=50%>


Tablelet 모드에서 봤을 때 네비게이션 바가 한쪽으로 치우치는 일이 있었다. 
ipad 에서는 기본적으로 네비게이션바가 왼쪽에 있고 오른쪽에 content 가 뜨는 것이 기본이기에 이런 화면이 나온 것 같다.

`🥳해결`

```swift
.navigationViewStyle(.stack)
```
기본 스타일이 아닌 stack 스타일로 변경하고 
```swift
.navigationBarTitleDisplayMode(.inline)
```
title Mode 를 inline 으로 변경하여 문제를 해결 했다.


### NavigationView SafeArea
`🤔문제` 
위의 NavigationView 문제를 해결했는데 NavBar의 배경색이 예상했던 것과 달라서 배경색을 

```swift
init() {
  UINavigationBar.appearance().backgroundColor = UIColor.systemGray6
}
```
위의 코드로 추가해 주었다.
그런데 SafeArea 부분까지는 색이 채워지지 않는 문제가 있었다.

<img src="https://i.imgur.com/1LrexEz.png" width=50%>

`.edgesIgnoringSafeArea(.all)`, `.ignoringSafeArea(.all)` 등을 사용해도 해결되지 않았다.

`🥳해결`
```swift
 init() {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
  }
```
위의 코드를 추가하여 문제를 해결했다. 

아직까지는 UIkit 코드를 사용하지 않고 순수 swiftUI 만으로 커스텀을 하기에 한계가 있는 것 같다. 
직접 NavigationBar 를 만드는 것도 좋겠다는 생각이 들었다.

### List의 Cell 의 inset
`🤔문제`

![](https://i.imgur.com/SlIHS6Y.png)
이와 같이 셀사이의 간견을 주고 싶었다. 
하지만 padding이나 Spacer()등을 활용해 보아도 cell사이의 간격을 줄 수 없었다. 

`🥳해결`
그래서 우선 cell의 배경색을 흰색으로 넣어주었다  
`.listStyle(.inset)` 을 사용하고, 
`.listRowSeparator(.hidden)` 으로 주어서 간격이 떨어져 보이게끔 (약간야매?)했다
좌우 여백은 `.padding(.horizontal, -24)` 를 주어 뷰를 구성하였다.

### EnvironmentObject vs ObservableObject 
`🤔문제`
처음에는 편하는 이유로 EnvironmentObject 를 사용해서 대부분의 데이터를 받았다. 
그런데 EnvironmentObject 는 전역적으로 사용되기 때문에 싱글톤 같은 느낌을 받았다.
할 수 있다면 데이터를 전역으로 공개하지 않는 것이 좋다고 생각되었다. 
`🥳해결`
ObservableObject로 변경하였다. 

EnvironmentObject 보다는 ObservableObject가 더 메모리상(?) 효율 적일 것 같은데 아직까지는 근거를 못찾았다. EnvironmentObject를 선언하면 싱글톤을 사용한 것처럼 되어 사용이 꺼려 졌었는데 EnvironmentObject을 선언한 하위뷰에서만 사용이 가능하기때문에 만약 하위뷰 전체에서 사용할 거라면 ObservableObject를 사용하여 계속 값을 넘겨 주는 것 보다는 EnvironmentObject를 사용하는 것이 더 깔끔하게 코드를 작성 할 수 있을 것이라 생각한다.

### updata 메서드 사용시 UI 업데이트 문제
`🤔문제`
```swift
class Todo: Identifiable, ObservableObject {
  let id: UUID
  @Published var title: String
  @Published var content: String
  @Published var date: Date
  @Published var status: Status
}

class TodoViewModel: ObservableObject {
  func creat(todo: Todo) {
    todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
}
  
func update(todo: Todo) {
  let willChangeTodo = todoList.filter { todo in
  todo.id == todo.id
    }
}      
    
 List { ForEach(viewModel.read(by: status)) { todo in
  DetailViewButton(viewModel: viewModel, todo: todo, isShowDetailView: $isShowDetailView)
 }   
    
```
업데이트 메서드를 구현하여 사용하였는데 값을 확인하면 ViewModel의값은 분명히 바뀌었는데 UI 업데이트를 하지 않았다. 
creat 메서드를 사용하였을때는 바로 화면에 List을 추가하여 바로 보여주었는데 왜 update 메서드를 사용하였을때는 화면에 List를 바로 업데이트 해주지 않는지 궁금하다. 
생각하기에는 내부 프로퍼티 값을 바꾸어 준 것은 Published가 감지를 못하나 싶어서 `ForEach(viewModel.read(by: status)`부분을 viewModel.todoList으로 바꾸어 주었는데 이경우에는 List화면이 꼬이긴 하나 바뀌기는 한다.

(여기서 말하는 List 가 꼬였다 함은 Title1 cell을 눌러보았는데, DetailView 로 이동하면 Title7 으로 내용이 뜬다던가... 하는 오류이다. 
마치 테이블 뷰에서 cell이 reuse 되어서 뷰의 내용이 꼬인것 같은 현상이 일어 난다ㅜ...)

`시도`
todoList가 수정이 되었을 때는 반응하지 않고 새로운 인스턴스 추가 삭제에만 반응을 했기 때문에, 수정된 객체를 찾아서 삭제하고 다시 삽입하는 방법으로 로직을 바꾸어서 작동하도록 하였다.


`🥳해결`
Todo(Model)를 직접적으로 수정하기 위해서 class 로 만들고 Observable을 붙여 주었었다.

클래스는 주소를 stack에 저장하고 데이터를 heap 에 저장하는데 있던 객체를 수정하면 stack 이 변하질 않으니 값이 변했다고 인지를 못한다. 
그래서 모델은 꼭 구조체로 만들어 주어야 변경에 대응할 수 있다. 

해결 방법을 알고나니 다양한 문제가 이것 때문에 발생한 것을 알 수 있었다.
처음엔 원인을 몰라서 로직을 수정해 해결을 했지만 근본적인 이유를 찾고 나서는 이로 인해 발생한 모든 문제가 해결 되었다. 

### MVVM
`🤔문제`
SwiftUI를 처음 써보기도 하였고 MVVM 디자인 패턴을 UIKIT에서도 많이 사용해 보지 못하여 현제 코드 상태가 MVVM 디자인 패턴에 맞는지 잘 모르겠다.
SwiftUI를 쓰다보니 View 를 많이 생성하게 되는데, 모든 View 가 ViewModel 을 가져야 하는 것인지 어느정도 까지 ViewModel 을 공유해도 되는지도 잘 모르겠다.
또 @State @Binding 등의 상태를 통해 action 을 수행하다 보니 View 마다 들고 있는 변수가 많아지고 마치 이 변수들이 flag 처럼 느껴져서 좋게 생각되지는 않았다. 

`🥳해결`
모든 View 가 ViewModel 을 가져야 하는 것인지 어느정도 까지 ViewModel 을 공유해도 되는지 에대해 이번 프로잭트 코드리뷰를 담당하신 토니의 조언을 구했을때는 Scene별로 ViewModel이 존재 하면 좋을 것 같다는 조언에 따라 이번프로잭트에서는 3개의 Scene이존재 하기 때문에 3개의 ViewModel을 두현 하였다. 하지만 무조건 Scene별로 하나의 ViewModel을 생성하기 보다는 팀적으로 합의를 하고 그 기준에 맞추어 ViewModel을 구성해야 겠다.

@State를 사용하여 바인딩 값을 전달해 주는것은 flag로 보기 보다는 특정 부분의 값만을 변경하려는 SwiftUI의 특징으로 보아야 겠다.

### file 분리 
`🤔문제`
SwiftUI 를 사용하다보니 View를 자잘하게 나눠지게 되었는데 이에 따른 파일 분리를 어떻게 해야 하는지 아직 잘 모르겠다.

`🥳해결`
최종적인 Scene을 보여주는 파일들을 Scene으로 분리하였고 안에 view들은 View파일을 만들고 그 안에 파일을 하나 더 만들어 좀더 보기 좋게 파일을 분리 하였다.

### Gesture가 작동하지 않는 문제
`🤔문제`
하나의 버튼에 LongPressGesture 와 TapGesture 를 추가해 주었는데, 작동하지 않았다.

`🥳해결`
우선 제스쳐를 두개로 나눠주는 시점에서 Button 타입을 사용할 필요성이 없었다.
SwiftUI 에서는 코드의 순서도 중요해서 LongPressGesture 를 먼저 배치하면 TapGesture 를 인지하지 못해서 발생한 오류 였다.

### service 를 어떻게 넘겨야 하는가? 
`🤔문제`
이번 프로젝트에서 todoService라는 개념을 만들어 주었는데 이 todoService는 모든 뷰모델에서 공통되게 가지고 있어야 한다. 그래서 view가 이동할 떄마다 todoService를 넘겨 주엇는데 이렇게 되면 코드가 복잡해지는 문제가 발생하였다.
![](https://i.imgur.com/6NZpask.png)

`🥳해결`
해당 뷰의 하위뷰에서 전체적으로 사용해야할 경우 @EnvironmentObject를 사용하는 것이 더 합리적 일것이라는 의견을 받았다. 그러나 이번 프로잭트에서는 한번만 todoService를 넘겨주어도 되기 때문에 @ObjectedObject를 사용하여 todoService를 넘겨 주었다.


### EditViewButton의 isShowEditView을 상위 뷰에서 주입문제
`🤔문제`

원래 로직에서는 상위뷰에서 isShowEditView를 선언하고 List 마다 가지고 있는 하위뷰인 EditViewButton에서 binding으로 값을 전달받아 상위뷰에서 주입해 주는 방식으로 구현하였다.

이렇게 되면 상위뷰에서 isShowEditView 값을 true로 전달하면 모든 EditViewButton의 isShowEditView 값이 true가 되어 여러 EditView가 띄워져 가장먼저 띄워진 각 status의 첫번째 뷰가 띄워지는 것 같았다.

`🥳해결`
isShowEditView의 값을 상위뷰에서 EditViewButton으로 전달하지 않고 EditViewButton 자체적으로 isShowEditView를 @State으로 선언하여 전체 EditViewButton에 값을 전달하는 것이 아니라 선택한 EditViewButton에만 true를 바꾸도록 수정하여 문제를 해결하였다.

### ViewModel 과 Service 
`🤔문제`
하나의 View(여기선 scene)가 ViewModel을 가지도록 구현을 하였다. 모든 ViewModel이 하나의 service를 의존성 주입 형태로 받고 있는데, viewModel들을 생성하는 부분이 제각각 이다 보니 이 service 프로퍼티를 넘겨주어야 해서, service 프로퍼티가 외부에 나와잇는 경우가 생겼다.

(viewModel 이 아닌 그냥 view 상단에)
저희가 보기엔 이 그림이 깔끔하진 않다는 생각이 들었다

또 service가 view에 있다보니 이것을 사용하게 되었다.
지금 todoListView의 경우 AppView의 하위 View 인데, ViewModel을 가지지 않고 되도록 closure를 넘겨서 처리하려고 하였으나, List가 값이 바뀔 때 마다 갱신이 되어야 하는데 closure는 이 역할을 충분히 하지 못해서 결국엔 service를 사용하게 되었습니다. 

이 부분의 로직이 저희가 보기엔 MVVM에서 깔끔한 형태가 아닌 것 같아 어떻게 수정을 해야 하는지 조언을 얻고 싶습니다. 

`🥳해결`
아직 MVVM패턴에 대한 이해가 완벽하지 않아 생긴 문제였다. 각 뷰가 각자의 뷰모델을 가지게 수정을 하여 뷰에서 service를 직접적으로 사용하지않고 각 뷰가 뷰모데의 해당 뷰모델을 사용하게하여 수정하였다. 이렇게 뷰모델을 설정하고 뷰모델들은 파사드 패턴으로구현하여 뷰에서 서비스를 넘기지 않고 뷰모델 내에서 넘기도록 수정하여 뷰에서는 뷰모델만을 넘기게하여 문제를 해결했다. 


### realm primaryKey 
`🤔문제`
realm Model 객체를 만들었는데, primaryKey 를 꼭 설정해야 한다는 공식문서의 지침을 보고
```swift
@Persisted(primaryKey: true) var id: UUID
```
이렇게 key 값을 설정해 주었더니 
Realm() 을 불러오는 과정에서 부터 오류가 났다.  
결국에 false로 값을 바꿔서 key 값을 설정해 주지 않았더니, 문제가 해결 되었지만 공식문서의 지침을 따르면서 문제를 해결하고 싶었다. 

`🥳해결`
이미 키 값이 존재하지 않는 상태로 정보를 저장한 이력이 있어서 모델을 수정하고 정상적으로 작동하려면 마이그레이션이 필요했다. 
```swift
let realmConfigure = Realm.Configuration(schemaVersion: 2)
Realm.Configuration.defaultConfiguration = realmConfigure
```
위의 코드로 realm 의 자동 마이그레이션으로 문제를 해결했다.

### ViewModel 이 View 의 상태를 들고 있어야 하는 점
`🤔문제`
View의 상태값을 ViewModel이 알고 있어야 한다생각 하는데 그렇게 하려면 모든 상태값을 가지는 뷰는 ViewModel을 가지고 있어야 한다 그래서 ViewModel에 state를 가지고 View에 Biding으로 값을 넣어주었더니 Biding 값을 추적해보았을 때, Binding 값을 바꿨음에도 값 자체가 바뀌지 않는 현상이 일어났다.

`🥳해결`
하위뷰가 상위뷰를 알 수 있는 방법은 클로저 밖에 없다 판단하여 뷰에서 State Binding으로 사용한 값들에 대해서는 클로저를 사용했다.

## STEP3

[자세한 고민보기 STEP3-PR](https://github.com/yagom-academy/ios-project-manager/pull/154)

### 뷰와 뷰모델이 1:1 대응이 되게 MVVM 수정 
저번 스탭까지는 Scene별로 뷰모델을 하나씩 가지게 해여 뷰모델이 여러 뷰를 처리하도록 되어 있었다. 이번스탭부터는 뷰와 뷰모델이 1:1 대응이 되게 로직을 변경하고 뷰모델은 파사드 패턴으로 구현하여 뷰에서 다음 뷰로 넘어갈 때에는 그 해당 뷰의 뷰모델만을 전달해 주는 방식으로 변경 했다. 이런 방식으로 변경하였더니 appViewModel의 todoList 값을 변경해 주었는데도 listViewModel 값이 변경되지 않던 문제가 발생하였다. 그래서 appViewModel 안에 있는 다른 ViewModel들을 연산프로퍼티로 변경하여 appViewModel의 todoList값이 변경되면 listViewModel의 값이 변경되 도록 수정하였다

### fireBase와 realm의 연동
`🤔문제`
fireBase와 realm의 연동상태는 
처음에 앱을 시작했을때 firebase에 있는 데이터를 가져와서 갱신해주고 
그 다음에 CRUD 시 Raealm과 firebase를 둘다 각각 업데이트를 해주고 
특정 버튼(NavigationBar 의 초록버튼)을 누를경우 realm의 데이터를 모두 삭제하고
firebase에 있는 데이터를 가져오는 방식으로 구현하였다.

이러한 방식의 문제점은 각각 수정을 해주기 때문에 데이터의 무결성이 깨진다는 것과 sync 버튼을 누를 때마다 realm 을 모두 지우고 firebase 의 모든 값을 가져오기 때문에 비용이 많이 든다는 점이다.

`🥳해결`
`🔴 추후 피드백 받고 수정 예정` 

### swiftUI layout
`🤔문제`
`todo`의 기록이 저장되는 `historyView`가 popOver 형식으로 화면에 나타나고 있는데, View의 frame 값을 미리 정해주지 않으면 화면에 리스트가 나타나지 않는 오류가 있었다.
[오류의 원인](https://stackoverflow.com/questions/61228002/navigationview-in-ipad-popover-does-not-work-properly-in-swiftui)

frame 값이 미리 지정해 주어야 하기 때문에 Text 의 길이에 따른 frame 의 width 를 정해주고 싶다. (마치 UIkit 의 autolayOut 처럼)

`🥳해결`
`🔴 추후 피드백 받고 수정 예정` 

### firebase 비동기 방식

처음에 firebase의 getDocuments를 했을때 값이 잘 받아와 졌었다(print로 찍었을때), 그래서 그대로 firebase의 read 메서드를 만들어 사용하였는데 값이 분명히 받아와 졌는데 화면에 값이 띄워지지 않는 오류가 있었다. 이 문제는 firebase의 getDocuments가 비동기 방식이라 발생한 문제였다.
