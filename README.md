# 🗓  프로젝트 관리 앱

## STEP 1 - 라이브러리 의존성 추가 및 환경 설정

### 🛠 기술 스택

|UI|이벤트 처리|의존성 관리 도구|Local DB|Remote DB|
|:---:|:---:|:---:|:---:|:---:|
|RxCocoa|RxSwift|CocoaPods|Realm|Firebase|


### RxCocoa

Uikit에선 UI Components와 Datasource를 바인딩할 때 delegate 패턴을 사용하는데, RxCocoa를 도입하면 위같은 과정없이 간결한 코드로 바인딩을 할 수 있다는 장점을 보고 사용하였습니다.

### RxSwift

비동기 코드를 비교적 깔끔하고 일관성있게 작성할 수 있고, Callback 지옥을 벗어날 수 있으며, 

이번 프로젝트에서 적용할 MVVM 패턴과 같이 사용하면 의존도를 많이 낮출 수 있다는 장점을 보고 사용하였습니다.

### FireBase, Realm

가장 대중적이라고 생각하였습니다.

이전 프로젝트에서 DropBox를 사용해보았는데 레퍼런스가 없어 문제 해결을 못하는 일이 변변치않게 발생하였는데, Realm, Firebase는 문제 발생시 해결에 도움이 되는 레퍼런스가 많다는 이유 하나만으로도 충분히 사용할 이유가 된다고 생각했습니다.

## 🍎 사용한 기술 스택에 대한 고민

### 1. 하위 버전 호환성에는 문제가 없는가?

|Firebase|Realm|
|:--:|:--:|
|![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/d3a7b9bc-3760-4f24-a35d-df0139e6b8f5/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220301%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220301T082931Z&X-Amz-Expires=86400&X-Amz-Signature=408c193fefe3b153b05b9196ddaf39f4362d08d69d1467050ce3f3c61d9eba82&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)|![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/1b1cdd84-2320-451b-8058-6f3b137247c0/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220301%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220301T083002Z&X-Amz-Expires=86400&X-Amz-Signature=36e306b636db0bc3c4a65637ad317b3af9726dfd30641974466c7b9619a42b9a&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)|

Firebase는 iOS 10, Realm은 iOS 9부터 지원하기 때문에 저희 프로젝트 최소 타깃인 iOS 13을 커버하기에 무리가 없다고 판단하였습니다.

### 2. 안정적으로 운용 가능한가?

- Google에서 제공하는 라이브러리이기 때문에 안정적이라고 생각했습니다.


### 3. 미래 지속가능성이 있는가?

- iOS, Android, 웹 등 다양한 플랫폼을 지원하기 때문에 향후에 확장이 용이하다고 생각하였습니다.


### 4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

- 어떤 리스크가 있는지 잘 모르겠지만 검색해보니 속도가 느리고, 쿼리가 제한적이라고 합니다.

### 5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?

Firebase와 Realm이 지원하는 의존성 관리도구에는 아래 세가지가 있습니다.

- CocoaPod
- Carthage
- SPM

이 중에서 저희는 CocoaPod을 사용하기로 결정했습니다.

### 6. 이 앱의 요구기능에 적절한 선택인가?

저장과 관련된 핵심 요구사항에 적합하다고 생각합니다.

- 로컬에 저장 - Realm
- 서버에 저장 및 동기화 - Firebase

## 🍎 객체지향 프로그래밍 vs 함수형프로그래밍

객체지향은 객체 안에 상태를 저장하고 상태를 조정하기 위해 다양한 기능을 사용하는 반면에

함수형은 상태를 없애고 전달받은 인자값을 중심으로 결과값을 반환합니다.

### 객체지향 프로그래밍

#### 장점

- 객체간의 독립성 확립으로 인해 유지보수에 좋다.
- 코드 재사용이 용이하다

#### 단점

- 객체간의 의존 등의 많은 것들을 먼저 생각하고 코드를 작성해야하므로 상대적으로 개발 시간이 오래걸린다.

### 함수형 프로그래밍

#### 장점

- 순수 함수를 이용해 코드를 작성하며 사이드 이펙트를 줄일 수 있다.
- 간결하다. → 유지보수에 좋다.

#### 단점

- 상태를 갖고 있지 않다

### 순수함수란?

- 동일한 input에는 항상 같은 output을 반환한다
- 함수의 실행이 프로그램에 영향을 주지 않는다
- 외부 환경과 철저하게 독립적으로 작동한다

#### 순수함수

```swift
function add(a, b) {
    return a + b;
}
console.log( add(10 , 5) );    // 출력값 15
```

#### 순수함수 아님

```swift
 function add2(a, b) {
    return a + b + c;
 }

 let c = 10;
 console.log( add2(10 , 2) );   //출력값 22

 c = 20;
 console.log( add2(10 , 2) );   //출력값 32
```

함수의 인풋값인 a와 b를 이용한 연산값이 어떤 상황에서도 동일하게 나오는 함수를 순수함수라고 이해했습니다. 

인풋값으로 a와 b를 받는데 함수 안에 변수 c가 존재한다면 c의 값에 따라 아웃풋이 달라지기 때문에 순수함수가 아닙니다.

## 🍎 디자인 패턴에 대한 고민

### MVVM vs MVC

![image](https://user-images.githubusercontent.com/70251136/157047963-3cac5caa-bf0f-44ff-b8cc-c1e4faca59d9.png)

[이미지 출처](https://ichi.pro/ko/swift-mich-mvvm-dijain-paeteon-eul-sayonghan-logeu-in-hwamyeon-guhyeon-74723834678771)


### MVC 란?

Model + View + Controller로 이루어진 패턴으로 각각 다음과 같은 역할을 합니다.

### MVC 동작 순서

1. Controller를 통해 사용자의 액션이 들어온다
2. Controller는 사용자의 액션을 확인하고 Model을 업데이트한다
3. Controller는 Model을 나타내줄 View를 선택한다
4. View는 Model을 이용하여 화면을 나타낸다
    1. View가 Model을 이용하여 직접 업데이트
    2. Model에서 View에게 Notify하여 업데이트
    3. View가 주기적으로 Model의 변경을 감지하여 업데이트

#### 장점

- 코드가 직관적이고 비교적 빠른 시간내에 개발 가능

#### 단점

- View와 Model간의 높은 의존성이 있다.

### MVVM 이란?

Model + View + ViewModel로 이루어진 패턴으로 각각 다음과 같은 역할을 합니다.
- Model: 앱에서 다룰 데이터를 가지고, 그 데이터를 처리하는 부분
- View: 사용자에게 보여질 화면
- ViewModel: Model이 가진 데이터를 View에 보여주기 위한 (View가 원하는) 값으로 변형(가공)

#### 장점

- View와 Model사이에 의존성이 없다.
- View와 ViewModel사이에도 의존성이 없다. (Command패턴과 Data Binding)

#### 단점

- ViewModel을 설계하기가 어렵다.
- View와 Model사이의 의존성은 해결되었지만, 앱이 복잡해질수록 View와 ViewModel사이에 의존성이 강해진다
- 데이터 바인딩을 통해 View를 바꿀 때 간단한 View를 만들더라도 많은 코드를 작성해야한다.

### MVVM 동작 순서

1. View를 통해 사용자의 액션이 들어온다
2. View는 ViewModel에 액션을 전달한다
3. ViewModel은 Model에게 데이터를 요청하고(Command패턴)
4. ViewModel은 Model에게 응답받은 데이터를 가공하여 저장한다
5. ViewModel은 View를 Data Binding을 통해서 바꿔준다.

참고 문서
[https://beomy.tistory.com/43](https://beomy.tistory.com/43)
[https://velog.io/@addiescode/디자인-패턴-MVC-MVVM](https://velog.io/@addiescode/%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4-MVC-MVVM)


<br>

## 🍎 Rest API는 무엇이고, 왜 중요한가?

### **Rest란?** 

자원을 이름(자원의 표현)으로 구분하여 해당 자원의 상태(정보)를 주고 받는 모든 것을 의미합니다.

### Rest API란?

Rest를 기반으로 제작된 API입니다.  

이를 사용하는 목적은 다양한 플랫폼을 통합하여 사용할 수 있고 일관적인 컨벤션을 통한 API의 이해도 및 호환성을 높이는 것이라고 생각합니다.

<br>

## 🍎 알아두면 좋을 것들

- 뷰는 테스트를 왜 하기 어렵고 뷰모델은 왜 테스트하기 쉬울까?
- 뷰모델은 프로퍼티로 모델을 가지고 있습니다.
- 뷰모델을 테스트하려면 DI라는 것이 필요한데 이건 무슨 개념일까?
- Rx + MVVM이 왜 좋을까? 아니 MVVM을 정의대로 구현하려면 Rx가 필요한건가
- UITableViewDataSource가 ViewModel의 역할을 할수 있지 않을까?

## Step 2

- **STEP 2-1** UI 구현
- **STEP 2-2** 데이터 전달
- **STEP 2-3** Rx적용

## Step 2-1 : UI 구현

![Simulator Screen Recording - iPad (9th generation) - 2022-03-07 at 22 31 45](https://user-images.githubusercontent.com/70251136/157047799-add8dfc1-8e0f-4fe9-ba23-e3119d0797cf.gif)

## 🍎 Lazy 키워드 사용에 대한 고민

```swift
private lazy var entireStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, totalCountLabel, spacerView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Design.entireStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
```

Lazy 키워드의 사용 용도는 처음부터 메모리에 올리지 않고, 호출시 메모리에 올리기 위해 사용하는 것이다.

Lazy 키워드를 사용시 주의할 점에 대해서 고민해보았다. 

1. 메모리 누수

첫번째로 변수에 클로저의 실행 결과를 할당하는 경우는 메모리 누수의 위험이 없다.

두번째로 변수의 타입을 클로저로 설정하여 클로저 실행의 결과가 아닌 클로저 자체를 담고 있는 변수라면 메모리 누수의 위험성이 있어서 [weak self]로 메모리 누수를 방지해줘야한다.

```swift
lazy var greeting: String = {
    return "Hello my name is \((self.name))"
}()
```

```swift
lazy var greeting: () -> String = { [weak self] in
    return "Hello my name is \(((self?.name))!)"
}
```

사용시 주의할 점은 만일 해당 클로저에서 self를 참조할 시 메모리 누수가 발생할 수 있다는 점이 있다.

또한 swift 코드는 기본적으로 thread-safe 하지 않기 때문에 여러 스레드가 동시에 해당 lazy var 변수에 접근한다면 해당 lazy 변수가 여러번 생성될 위험이 있으므로 lazy var 는 멀티 스레드 환경에서 접근하면 안된다. 

위 사항들에 대해 고민해본 결과 해당 코드는 메모리 누수될 일이 없음을 확인하였고, lazy의 용도와 달리 stackView는 처음부터 메모리에 올려야되는 뷰이므로 쓸 필요가 없어보여 제거하였음

```swift
private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Design.entireStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
```

참고 링크: [https://www.avanderlee.com/swift/lazy-var-property/](https://www.avanderlee.com/swift/lazy-var-property/)

## 🍎 View 부분 문제 해결

### sectionHeaderTopPadding

![image](https://user-images.githubusercontent.com/70251136/157048130-3fc6a2c8-8fac-4ab8-bde9-1a8b73d2beaa.png)

![image](https://user-images.githubusercontent.com/70251136/157048192-37629794-1f23-4ff6-86db-5e0269b83875.png)


iOS 15부터 tableView의 HeaderView 윗부분에 공백이 생겼다.

iOS 15부터 생긴 sectionHeaderTopPadding을 설정하여 공벡을 없애 위 문제 해결

[https://medium.com/@GalvinLi/fix-the-table-header-gap-in-ios-15-197debb92608](https://medium.com/@GalvinLi/fix-the-table-header-gap-in-ios-15-197debb92608)

```swift
if #available(iOS 15, *) {
    todoTableView.sectionHeaderTopPadding = 1
}
```

### 셀의 contentView와 view

셀의 contentView와 view는 다른 것이었다.

cell의 contentView에 inset을 10만큼 줬더니 view와 구분되게 되었다. 

![image](https://user-images.githubusercontent.com/70251136/157048286-7f8b1bbe-d464-4634-93e9-7382ac6b027c.png)

코드

```swift
class ProjectTableViewCell: UITableViewCell {
		override func layoutSubviews() {
		    super.layoutSubviews()
		    self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
		    contentView.backgroundColor = .white
		    self.backgroundColor = .yellow
		}
}
```

- cell contentView - white
- cell view - yellow
- tableView - green

### 빈 뷰를 활용하여 레이블이 줄어드는 현상 해결

![image](https://user-images.githubusercontent.com/70251136/157048341-35fbbcaa-86d3-45ff-87c4-d37f344a5ddd.png)

스택뷰의 Leading쪽으로 컴포넌트(label)들을 몰아야했지만 스택뷰의 공간이 남아 두 컴포넌트가 스택뷰를 전부 차지하는 상황이 발생했다.

이를 해결하기 위해 Spacer(빈 뷰)를 넣어 스택뷰의 남는 공간을 차지하게 하였다.

### 문제 상황

컴포넌트들을 leading 쪽으로 몰기 위해 스택뷰의 traling과 셀의 trailing 사이에 간격을 길게 줬다.

```swift
stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200)
```

그러나 간격(constraint)이 고정되어있어 화면이 작아지면 DOING 레이블이 줄어들어서 DO... 가 되기에 모든 기기에 대응하지 못했다. 

### 1차 시도

스택뷰 안에 DOING 레이블의 CompressionResistancePriority를 높여서 화면이 줄어들때 레이블이 줄어들지 못하도록 하려 했으나 실패했다.

실패한 이유는 trailing에 준 간격(constraint)이 고정되어있기 때문이었다.

### 해결

스택뷰의 trailing과 셀의 trailing 사이에 간격 대신에 빈 뷰를 스택뷰에 넣고 **HuggingPriority**와 **CompressionResistancePriority**를 애플이 제공하는 Priority중 가장 낮은 값인 **fittingSizeLevel**로 두어 화면이 작아지고 커질 때 빈 뷰가 줄어들고 늘어나게 하여 레이블이 줄어드는 것을 해결했다

```swift
let spacerView: UIView = {
    let view = UIView()
    view.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
    view.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    return view
}()
```

![image](https://user-images.githubusercontent.com/70251136/157048383-e15c98a6-62e9-482f-89b4-48c66ffbc771.png)

레이블의 텍스트를 길게 적어도 숫자 레이블이 안깨지는 모습을 볼 수 있다.

## 🍎 View 부분 추가 구현 사항

### label 동그랗게 만드는 방법

너비와 높이를 같게 주고, cornerRadius는 너비의 절반으로 하면 된다

```swift
label.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
label.layer.cornerRadius = 30 / 2
label.layer.masksToBounds = true
```

### 텍스트필드 drop shadow 적용

UITextField에는 backgroundColor와 borderColor를 주지 않으면 텍스트 필드 테두리의 shadow가 생기는 대신 텍스트 자체의 shadow가 생기는 문제가 있었다.

문서를 찾아 보니 UITextField의 borderStyle 프로퍼티의 기본값이 .none이라서 borderStyle을 .roundedRect로 줬더니 해결되었다.

```swift
extension UIView {
    func dropShadow(
        shadowColor: CGColor,
        shadowOffset: CGSize,
        shadowOpacity: Float,
        shadowRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
```

```swift
textField.borderStyle = .roundedRect
```

## 🍎 오토레이아웃 알게된 부분

### **Constraint Priorites**

- required 1000
- high 750
- low 250
- fittingSizeLevel 50

`Hugging` 의 기본값 : 250 (대부분)

`Compression Resistance` 의 기본값 : 750 (대부분)

참고 링크: 
[https://stackoverflow.com/questions/36924093/what-are-the-default-auto-layout-content-hugging-and-content-compression-resista](https://stackoverflow.com/questions/36924093/what-are-the-default-auto-layout-content-hugging-and-content-compression-resista)
