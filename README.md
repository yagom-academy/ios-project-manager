# 📑 Project Manager
- 하모와 Wonbi가 만든 프로젝트 매니저 App입니다.

## 📖 목차
1. [팀 소개](#-팀-소개)
2. [팀 위키](#-팀-위키)
3. [실행 화면](#-실행-화면)
4. [Diagram](#-diagram)
5. [폴더 구조](#-폴더-구조)
6. [타임라인](#-타임라인)
7. [기술적 도전](#-기술적-도전)
8. [트러블 슈팅 및 고민](#-트러블-슈팅-및-고민)
9. [참고 링크](#-참고-링크)


## 🌱 팀 소개
|[Wonbi](https://github.com/wonbi92)|[Hamo](https://github.com/lxodud)|
|:---:|:---:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src="https://avatars.githubusercontent.com/u/88074999?v=4">| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src= "https://i.imgur.com/ydRkDFq.jpg">|

## 🧭 팀 위키

#### [🤙 Ground Rule](https://github.com/wonbi92/ios-project-manager/wiki/1.-Ground-Rule)

#### [🖋 Code Convention](https://github.com/wonbi92/ios-project-manager/wiki/2.-Code-Convention)

#### [📝 일일 스크럼](https://github.com/wonbi92/ios-project-manager/wiki/3.-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EB%A7%A4%EB%8B%88%EC%A0%80-Scrum)

## 🛠 실행 화면
|프로젝트 추가|
|:-:|
![](https://i.imgur.com/7XeB9kY.gif)

|프로젝트 편집|
|:-:|
![](https://i.imgur.com/WPQYML8.gif)

|프로젝트 삭제|
|:-:|
![](https://i.imgur.com/ZrolKV5.gif)

|프로젝트 상태 변경|
|:-:|
![](https://i.imgur.com/EYyrYPD.gif)
## 👀 Diagram

### 🐙 기술스택 마인드맵
![](https://i.imgur.com/GIVNQvE.png)


### 📝 책임 주도 설계
![](https://i.imgur.com/jvbDgzM.png)


### 🏗 아키텍쳐
![](https://i.imgur.com/sLIunkI.png)

### 🧬 Class Diagram
![](https://i.imgur.com/IJ31Uc8.png)

 
## 🗂 폴더 구조
```
ProjectManager
├── Info.plist
├── Resources
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
└── Sources
    ├── Extension
    │   └── Date+.swift
    ├── Model
    │   ├── Project.swift
    │   └── State.swift
    ├── View
    │   ├── Components
    │   │   ├── CountLabel.swift
    │   │   ├── HeaderView.swift
    │   │   └── ProjectCell.swift
    │   └── Controllers
    │       ├── AddViewController.swift
    │       ├── EditViewController.swift
    │       ├── MainViewController.swift
    │       ├── ProjectListViewController.swift
    │       └── ProjectViewController.swift
    └── ViewModel
        ├── AddViewModel.swift
        ├── EditViewModel.swift
        ├── HeaderViewModel.swift
        ├── MainViewModel.swift
        ├── ProjectCellViewModel.swift
        └── ViewModelDelegate.swift
```

## ⏰ 타임라인

#### 👟 Step 1
- 기술스택 결정
    - ✅ 요구사항과 현재 상황에 가장 적합하다 판단되는 기술스택 결정
- 설치
    - ✅ SPM을 이용한 FireBase 설치
    - ✅ brew를 이용한 SwiftLint 설치

#### 👟 Step 2
- 화면 구현
    - ✅ 프로젝트를 관리하는 3개의 테이블 뷰와 헤더 구현
    - ✅ 추가와 수정을 할 수 있는 Add/Edit뷰 구현
- 기능 구현
    - ✅ 추가 버튼을 터치하거나 각 프로젝트의 셀을 터치했을 때 각각 Add/Edit뷰를 화면에 띄우도록 구현
    - ✅ 사용자가 셀을 길게 누르면 popover가 나타나 셀의 상태를 변경하도록 구현
    - ✅ 사용자가 셀을 스와이프하면 프로젝트를 삭제할 수 있도록 구현

<details>
<summary> 
펼쳐보기
</summary>

## 🟡 View
### ⚪️ Components    
1️⃣ **HeaderView**
- titleLabel
    - 사용자의 프로젝트의 상태를 나타내는 레이블입니다.
- countLabel
    - 사용자의 프로젝트의 총 갯수를 나타내는 레이블입니다.
    
2️⃣ **CountLabel**
- 커스텀레이블
    - 배경을 동그란 모양으로 깎아 동그란 모양의 커스텀 레이블입니다.
    - 숫자가 커져서 가로로 길어지면 길이에 맞게 캡슐모양으로 변화합니다.

3️⃣ **ProjectCell**
- 테이블뷰에서 사용하기 위한 커스텀 셀입니다.
    
### 🔴 Controllers 
1️⃣ **AddViewController**
- 추가하기 버튼(+ 버튼)을 눌렀을 때 나타나는 뷰 입니다.
- pageSheet방식의 모달프리젠테이션을 진행합니다.
    
2️⃣ **EditViewController**
- 프로젝트 셀을 눌렀을 때 나타나는 뷰 입니다.
- AddViewController와 동일한 방식으로 화면에 띄우지만, Edit버튼이 있어 내용을 수정할 수 있습니다.

3️⃣ **ProjectViewController**
- AddViewController와 EditViewController가 상속하는 뷰 컨트롤러입니다.
- 두 컨트롤러는 화면 구성요소가 버튼을 제외 하면 동일하기 때문에 상속을 통해 구현하도록 하였습니다.

4️⃣ **MainViewController**
- 처음 화면에 나타나는 메인 뷰입니다. 
- 3개의 ProjectListViewController를 차일드 뷰컨트롤러로 가지고 있습니다.

5️⃣ **ProjectListViewController**
- 하나의 테이블 뷰를 가지는 MainViewController의 차일드 뷰 컨트롤러 입니다.
- 테이블 뷰 와 헤더 뷰를 가지고 있어 각각 담당하는 프로젝트 상태에 맞게 화면에 출력해줍니다.

### 🟠 ViewModel

1️⃣ **AddViewModel**
- 사용자가 새로운 데이터를 입력 후 저장하면, 그 데이터를 받아와 ViewModelDelegate를 통해 MainViewModel로 넘겨줍니다.
    
2️⃣ **EditViewModel**
- 사용자가 셀을 터치하면 그 셀에 있는 정보를 가져와 `project` 프로퍼티를 업데이트 합니다.
- 사용자가 Edit 버튼을 누르면 `isEditing` 프로퍼티 정보를 업데이트 합니다.
- 사용자가 기존 데이터를 수정 후 저장하면, 그 데이터를 받아와 ViewModelDelegate를 통해 MainViewModel로 넘겨줍니다.

3️⃣ **HeaderViewModel**
- ProjectListViewController가 초기화 될 때 title과 cellCount를 업데이트합니다.
- 화면에 나타낼 cellCount의 내용을 String으로 변환하여 업데이트합니다.

4️⃣ **MainViewModel**
- 각각 상태별 Project 배열을 가지고 있어 화면 테이블 뷰 셀에 나타낼 내용을 업데이트 합니다.
- 사용자가 새로 추가한 프로젝트나 수정한 프로젝트를 각 테이블 뷰에 적용합니다.
- 사용자가 롱 프레스 제스쳐를 통해 프로젝트의 상태를 변경하면 이를 반영합니다.

5️⃣ **ProjectCellViewModel**
- 각 셀에 들어갈 내용 3가지를 각각 셀에 들어갈 내용으로 변환하여 저장합니다.
- 마감일이 지났는지 판단하고 지났다면 빨간색을 같이 넘겨줍니다.

### 🟢 Model
1️⃣ **Project**
- 제목, 마감일, 상세내용, 상태를 각각 String과 Date, State 타입으로 가지고 있는 모델 객체입니다.
- 각 개체는 UUID를 `id`프로퍼티로 가지고 있어 내용이 정확히 일치하더라도 이 객체들을 구별할 수 있습니다.
    
2️⃣ **State**
- 프로젝트의 상태를 Todo, Doing, Done 3가지로 제한하는 열거형 객체입니다.
- 각 상태의 이름을 알려주는 name 연산 프로퍼티를 가지고 있습니다.

### 🟣 Delegate
1️⃣ **ViewModelDelegate**
- AddViewModel과 EditViewModel에서 데이터를 추가하거나 수정하는 작업을 대신 수행하는 대리자 객체입니다.

2️⃣ **ProjectListActionDelegate**
- 리스트 뷰 컨트롤러에서 발생하는 이벤트를 대신 넘겨줄 대리자 객체입니다.

</details>

## 🏃🏻 기술적 도전

#### ⚙️ 책임 주도 설계 
<details>
<summary>펼쳐보기</summary>
    
- 시스템이 사용자에게 제공하는 기능인 시스템 책임을 파악하고 이를 더 작은 책임으로 분할하여 이를 수행할 수 있는 객체를 찾아 책임을 할당하는 설계법입니다.
- 객체가 외부에 보여줘야 하는 인터페이스를 파악하기 좋습니다. 즉, 캡슐화에 용이합니다.
- 다른 객체에게는 인터페이스만 제공하기 때문에 결합도가 낮고 객체가 가져야할 책임이 뚜렷해져서 응집도가 높은 설계를 할 수 있습니다.
 <br><br>
- 💡 책임 주도 설계를 통해 좀 더 객체지향적이고, 역할이 뚜렷하고 유연한 구조를 설계하고자 사용하게 되었습니다.
    
</details> 

#### ⚙️ SPM
<details>
<summary>펼쳐보기</summary>
    
- Swift Package Manager는 Xcode 11 부터 애플에서 공식으로 지원하고 Xcode에 내장된 의존성 관리도구로, Cocoa Pod에 비해 package를 추가하기 쉽고 podfile을 관리하지 않아도 되는 장점이 있습니다.
- 또, 써드파티인 CocoaPods 과는 달리 퍼스트파티 툴이기 때문에 추가적인 설치가 필요없는 장점도 있고, Xcode에 내장된 도구이기 때문에 Xcode 사이드바에 명확하게 표시하고 패키지의 현재 버전도 보여줍니다.<br><br>
- 💡 이번 프로젝트에서는 Firebase 등 외부 라이브러리를 사용하여 앱을 개발하는데, 좀 더 편리하고 직관적으로 보여주는 SPM을 사용하여 개발 편의성을 높여보고자 사용하게 되었습니다.

</details> 

#### ⚙️ MVVM 아키텍쳐
<details>
<summary>펼쳐보기</summary>
    
- MVVM의 간단한 장단점은 다음과 같습니다.
- 장점
    - View와 Model이 서로 전혀 알지 못하기에 독립성을 유지할 수 있고, 유닛테스트가 가능합니다.
    - 각 역할과 용도에 따라 구분이 가능하다.
- 단점
    - 데이터 바인딩이 필수적으로 요구되어 설계의 어려움이 있을 수 있습니다.
    - 데이터의 변화가 많이 없고, UI가 간단한 앱에서는 오히려 설계가 어려워 질 수 있습니다.<br><br>
- 💡 MVC에서 ViewController가 많은 역할을 담당하는 문제가 발생하기 때문에 역할을 분리하기 위해서 MVVM을 사용하게 되었습니다.

</details> 

## 🏔 트러블 슈팅 및 고민
    
#### 🚀 동그라미로 감싼 숫자 그리기
    
<details>
<summary> 
펼쳐보기
</summary>

**문제 👻**
- 프로젝트 요구사항 중 각 상태의 갯수를 표현하는 숫자를 동그라미 모양으로 감싸서 보여줘야 했습니다.
- 동그라미 모양의 뷰를 그리고 그위에 숫자 레이블을 올리는 방법을 생각했지만 너무 복잡한 방법이라 생각했습니다.
- 또한 이 방법을 사용하면, 숫자의 크기가 커질경우, 레이블 크기에 맞게 뷰를 다시 그리는 방법이 너무 복잡했습니다.
    
**해결 🔫**
```swift
final class CountLabel: UILabel {
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
```
- 레이블의 layer에 접근하여 `cornerRadius`값을 주고 `backgroundColor`를 검정색으로 설정하여 레이블 길이에 따라 크기가 변하도록 하여 문제를 해결하였습니다.
- 또한, UILabel은 padding값을 설정하는 프로퍼티가 없기 때문에, `intrinsicContentSize`를 이용하여 padding값을 주도록 커스텀 레이블을 만들어 자연스러운 모양의 동그라미와 캡슐모양을 가지도록 하였습니다.

</details>

#### 💭 MVVM사용에 관한 고찰

<details>
<summary> 
펼쳐보기
</summary>

- MVVM 아키텍처를 적용하고 사용하는데 있어서 여러가지 장단점을 직접 느껴볼 수 있었습니다. 
- 먼저, 확실히 뷰 컨트롤러의 크기가 많이 줄어들고 각자의 역할에 맞게 객체를 나누어 좀 더 객체지향적인 설계를 할 수 있었다 생각했습니다.
- 더불어, 뷰 컨트롤러의 역할을 뷰를 그리고 사용자의 인터렉티브를 넘겨주는 역할로 쓰다보니, 객체간 의존도를 단방향으로 가지게 할 수 있었고, 이를 이용해 객체간 느슨한 결합을 가질 수 있도록 할 수 있었습니다.
- 하지만 데이터를 바인딩하는 과정에서 콜백함수를 활용하다보니 흐름을 읽기 어려워 여러번 다시 읽으면서 이해하는 시간들이 추가적으로 필요했고, 코드의 복잡도가 많이 올라갔다고 생각했습니다.
- 또한, 객체간 역할에 집중해서 개발을 진행하다 보니 MVC보다 개발 속도가 현저히 느려지는 것을 느꼈습니다.<br><br>
- 이러한 문제들을 해결하기 위해 등장한 Functional Reactive Programming을 좀 더 공부해봐야겠다 생각하였습니다.
</details>

#### 💭 모델의 state를 어떻게 구분지을까

<details>
<summary> 
펼쳐보기
</summary>
    
- enum 사용
    - ocp를 위반하는 경우가 존재한다.
    - case가 추가될 경우 기존의 코드를 수정해야 하는 상황이 발생한다.
- 모델 프로토콜을 이용하여 각 state별 구체 타입 생성
    - state가 추가되더라고 기존의 코드를 수정하지 않고 확장할 수 있음
    - 복잡성이 증가한다.
    
현재 프로젝트에서 핵심 로직 중 하나는 todo, doing, done 세가지 종류의 데이터를 분류하는 로직이라 생각했습니다.
이 로직을 수행하기 위해 모델 안에 enum을 사용해서 각 케이스를 만들고, 그 케이스별 분기처리를 하는것이 맞는것인가? 아니면 세가지의 각각의 다른 모델을 만들고 그 모델에 해당하는 ViewModel과 View를 각각 처리하는 방법이 맞는것인가? 라는 고민을 했습니다.
또 아예 방향성이 잘못된 것은 아닌가? 세가지 상태를 꼭 분류할 필요가 있는가? 상태라는 하나의 값 때문에 세가지의 모델이 생기는 것이 옳은 방향성인가? 상태는 모델의 한가지의 속성에 불과한데, 이 프로퍼티 하나 때문에 모델이 분기 되는 것이 맞는 것인가? 라는 고민에 도달하게 되었습니다.<br><br> 결론적으로 각 상태에 따라 모델을 가지는 것이 아니라 하나의 모델이 상태를 열거형으로 가지고 있는 방향으로 사용하게 되었습니다. OCP를 위반하는 것이 아닐까 라는 생각이 들었지만, 그 리스크보다 훨씬 더 좋은 코드 가독성과 데이터를 처리하는 로직을 단순화 할 수 있는 리턴이 더 크다고 결론짓고 이 방식으로 사용하게 되었습니다.

</details>

#### 💭 Date의 처리

<details>
<summary> 
펼쳐보기
</summary>
    
Date타입의 데이터를 모델이 가지고 있습니다. 모델은 Date타입으로 Deadline을 가지고 있지만, 뷰는 이를 String으로 받아서 표현해야합니다. 이 값을 트렌스폼 하는 객체는 누가 되야 하는지 고민하였습니다. <br><br> 결과적으로 Cell의 ViewModel을 만들어 Date타입의 값을 String으로 변경하는 로직을 가지게 하고 Date Extension을 통해서 DateFormatter와 formatting메서드를 만들어서 사용하였습니다.

</details>

#### 💭 MainViewModel에서 각 테이블뷰에 뿌릴 모델을 왜 쪼갰는가

<details>
<summary> 
펼쳐보기
</summary>
    
하나의 배열로 관리하게 되면 변동사항이 하나 생겼을 때 모든 테이블뷰에 데이터를 바꾸는 작업을 해야하기 때문에 3개로 나누어서 변경이 발생하는 테이블뷰만 작업을 수행하도록 하려고 했습니다.
이렇게 하면 각 테이블뷰가 자신의 모델만 바라보게 되고, 모든 테이블 뷰가 데이터를 바꾸는 작업을 하지 않게 되는 장점이 있었습니다. 하지만 분기처리가 많이 생기는 단점이 발생했습니다.

</details>
    
## 🔗 참고 링크

[공식문서]


[Swift Package Manager](https://www.swift.org/package-manager/)  
[intrinsicContentSize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)  
[Firebase](https://firebase.google.com/docs/ios/swift-package-manager?hl=ko)  
[SwiftLint Rules](https://realm.github.io/SwiftLint/rule-directory.html)  


---

[⬆️ 맨 위로 이동하기](#-project-manager)

