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
|[Wonbi](https://github.com/wonbi92)|[Gundy](https://github.com/Gundy93)|
|:---:|:---:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src="https://avatars.githubusercontent.com/u/88074999?v=4">| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src= "https://i.imgur.com/ydRkDFq.jpg">|

## 🧭 팀 위키

#### [🤙 Ground Rule](https://github.com/wonbi92/ios-project-manager/wiki/1.-Ground-Rule)

#### [🖋 Code Convention](https://github.com/wonbi92/ios-project-manager/wiki/2.-Code-Convention)

#### [📝 일일 스크럼](https://github.com/wonbi92/ios-project-manager/wiki/3.-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EB%A7%A4%EB%8B%88%EC%A0%80-Scrum)

## 🛠 실행 화면

## 👀 Diagram

### 🐙 기술스택 마인드맵
![](https://i.imgur.com/GIVNQvE.png)


### 📝 책임 주도 설계
![](https://i.imgur.com/jvbDgzM.png)


### 🏗 아키텍쳐
![](https://i.imgur.com/sLIunkI.png)

 
## 🗂 폴더 구조
>

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

<details>
<summary> 
펼쳐보기
</summary>

1️⃣ **HeaderView**
- titleLabel
    - 사용자의 프로젝트의 상태를 나타내는 레이블입니다.
- countLabel
    - 사용자의 프로젝트의 총 갯수를 나타내는 레이블입니다.
    
2️⃣ **CountLabel**
- 커스텀레이블
    - 배경을 동그란 모양으로 깎아 동그란 모양의 커스텀 레이블입니다.
    - 숫자가 커져서 가로로 길어지면 길이에 맞게 캡슐모양으로 변화합니다.
    
3️⃣ **MainViewController**
- ListCollectionViewCell
    - 리스트 형태의 컬렉션 뷰에서 사용하는 셀입니다.
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

#### 💭 어떤 점 고민
    
<details>
<summary> 
펼쳐보기
</summary>
    
**고민 🤔**
- 어떻게 고민하였고 어떤 결론을 내렸다

</details>
    
## 🔗 참고 링크

[공식문서]
[Swift Package Manager](https://www.swift.org/package-manager/)  
[intrinsicContentSize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)  
[Firebase](https://firebase.google.com/docs/ios/swift-package-manager?hl=ko)  
[SwiftLint Rules](https://realm.github.io/SwiftLint/rule-directory.html)  

[⬆️ 맨 위로 이동하기](#-project-manager)
