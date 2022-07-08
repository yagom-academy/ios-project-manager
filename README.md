# 프로젝트 매니저 공유노트
 
# 🗂 프로젝트 매니저
> 프로젝트 기간 2022-07-04 ~ 2022-07-15 
팀원 : 👼[@Taeangel](https://github.com/Taeangel) 🔴[Red](https://github.com/cherrishRed) / 리뷰어 : [TOny](https://github.com/Monsteel)

- [프로젝트 소개](#프로젝트-소개)
- [개발환경 및 라이브러리](#개발환경-및-라이브러리)
- [키워드](#키워드)
- [STEP 1](#step1)
- [STEP 2](#step2)

## 프로젝트 소개
간편한 아이패드 TodoList App!


## 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange?style=for-the-badge)]()

[![xcode](https://img.shields.io/badge/Xcode-15.5-blue?style=for-the-badge)]()

|Local DB|Remote DB|그 외 라이브러리|
|--|--|--|
|[![Realm](https://img.shields.io/badge/Realm-ff69b4?style=for-the-badge&logo=Realm)]()|[![firebase](https://img.shields.io/badge/firebase-008cff?style=for-the-badge&logo=Firebase)]()|[![swiftLint](https://img.shields.io/badge/swiftLint-333333?style=for-the-badge&logo=Swift)]()[![combine](https://img.shields.io/badge/combine-orange?style=for-the-badge&logo=Swift)]()|


## 키워드
`SwiftUI`, `Combine`, `firebase`, `Realm`, `List`, `@State`, `@Binding`, `@StateObject`

## STEP1
[STEP1-PR](https://github.com/yagom-academy/ios-project-manager/pull/135)
### 기능구현
- SPM으로 firebase, realm 설치 

### 🚀 trouble shooting
- SPM으로는 swiftlint를 설치가 불가능하여 homebrew로 swiftlint를 설치하였다.

## STEP2

### 기능구현
- SwiftUI로 UI구성하기
- MVVM 형태의 디자인 패턴으로 구성


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
좌우 여백은 `.padding(.horizontal, -24)` 를 주어 뷰를 구성하였다. (추후 수정예정) 

`🥵 추후 해결 예정`

### EnvironmentObject vs ObservableObject 
`🤔문제`
처음에는 편하는 이유로 EnvironmentObject 를 사용해서 대부분의 데이터를 받았다. 
그런데 EnvironmentObject 는 전역적으로 사용되기 때문에 싱글톤 같은 느낌을 받았다.
할 수 있다면 데이터를 전역으로 공개하지 않는 것이 좋다고 생각되었다. 
`🥳해결`
ObservableObject로 변경하였다. 

EnvironmentObject 보다는 ObservableObject가 더 메모리상(?) 효율 적일 것 같은데 아직까지는 근거를 못찾았다. 
`🥵 추후 근거 추가 예정`

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
없데이트 메서드를 구현하여 사용하였는데 값을 확인하면 ViewModel의값은 분명히 바뀌었는데 UI 업데이트를 하지 않았다. creat 메서드를 사용하였을때는 바로 화면에 List을 추가하여 바로 보여주었는데 왜 update 메서드를 사용하였을때는 화면에 List를 바로 업데이트 해주지 않는지 궁금하다. 생각하기에는 내부 프로퍼티 값을 바꾸어 준 것은 Published가 감지를 못하나 싶어서 `ForEach(viewModel.read(by: status)`부분을 viewModel.todoList으로 바꾸어 주었는데 이경우에는 List화면이 꼬이긴 하나 바뀌기는 한다. 

(여기서 말하는 List 가 꼬였다 함은 Title1 cell을 눌러보았는데, DetailView 로 이동하면 Title7 으로 내용이 뜬다던가... 하는 오류이다. 마치 테이블 뷰에서 cell이 reuse 되어서 뷰의 내용이 꼬인것 같은 현상이 일어 난다ㅜ...)                      (문제해결후 수정예정)

`🥳해결`

`🥵 추후 해결 예정`

### MVVM

SwiftUI를 처음 써보기도 하였고 MVVM 디자인 패턴을 UIKIT에서도 많이 사용해 보지 못하여 현제 코드 상태가 MVVM 디자인 패턴에 맞는지 잘 모르겠다.
SwiftUI를 쓰다보니 View 를 많이 생성하게 되는데, 모든 View 가 ViewModel 을 가져야 하는 것인지 어느정도 까지 ViewModel 을 공유해도 되는지도 잘 모르겠다.
또 @State @Binding 등의 상태를 통해 action 을 수행하다 보니 View 마다 들고 있는 변수가 많아지고 마치 이 변수들이 flag 처럼 느껴져서 좋게 생각되지는 않았다. 

`🥵 추후 해결 예정`

### file 분리 

SwiftUI 를 사용하다보니 View를 자잘하게 나눠지게 되었는데 이에 따른 파일 분리를 어떻게 해야 하는지 아직 잘 모르겠다.

`🥵 추후 해결 예정`
