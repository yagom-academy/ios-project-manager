# 프로젝트 관리 앱 저장소

#### **목차**
- [기능](#기능)
- [설계 및 구현](#설계-및-구현)
- [Trouble Shooting](#Trouble-Shooting)
- [기술 선택](#기술-선택)
    - [MVVM 패턴](#MVVM-패턴)
    - [RxSwift, RxCocoa](#RxSwift,-RxCocoa)
    - [FireBase](#FireBase)
    - [REST API](#REST-API)

## 기능
---
## 설계 및 구현
---
## Trouble Shooting
### 문제 상황
### 해결 방법
---
## 기술 선택
## MVVM 패턴
> 주로 MVC 패턴을 적용했습니다. 프로젝트 관리 앱에는 MVVM 패턴을 적용합니다. 
### MVC 패턴이 무엇인가?
**MVC (Model-View-Controller) 패턴**은 유저 인터페이스, 데이터, 컨트롤하는 로직을 구현할 때 일반적으로 사용되는 소프트웨어 설계 패턴입니다.

MVC 패턴에서는,
- Controller가 Model, View의 상태를 업데이트하도록 시킬 수 있습니다.
- Model은 Observer로 등록한 개체에게 상태에 변화가 있었음을 알립니다.
- View는 사용자의 이벤트를 Controller에 전달합니다. 
    Observer인 View는 Model에 변화에 따라 화면을 그립니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/60090790/156174248-ce913778-9862-4c54-883b-622e93f0fc08.png" width="667" />
</p>

Observer 패턴을 사용하게 되면 Model이 View를 알고 있게 됩니다. 애플은 이 설계에는 이론적인 문제가 있다고 합니다. 

왜 분리되어야 하나요?
- View와 Model은 재사용이 가능해야 합니다.
    - View는 운영체제와 시스템이 지원하는 애플리케이션의 “모양과 느낌”을 나타냅니다.
        - 모양과 동작의 일관성은 필수적이고, 재사용이 가능한 개체를 필요로 합니다.
- Model은 문제 도메인과 관련된 데이터를 캡슐화하고, 해당 데이터에 대한 작업을 수행합니다.
- 재사용성을 높이기 위해 Model과 View는 분리되어야 합니다.

그래서 이런 문제를 해결하고자 Cocoa 버젼의 MVC도 등장했습니다. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/60090790/156174459-79c124d5-ade1-4be9-848d-bb1eb1cf5b7c.png" width="667" />
</p>

### MVVM 패턴을 고려하게 된 이유 

다수의 프로젝트에서 MVC패턴을 적용해본 결과 **풀리지 않는 문제**가 있었습니다.
MVC패턴의 한계 중 하나를 직접 경험했습니다.  

> 이 코드가 View나 Model인가? 🙅‍♀️  
> → Controller에 포함 → 이 코드가 Controller인가? 🤔   
> → 그렇다고 이 코드가 View나 Model인가? 🙅‍♀️ → ..  

라는 뱅뱅 도는 고민의 결과, **Controller가 비대해졌습니다**.  


### MVVM 패턴이 무엇이길래? 

**MVVM (Model-View-ViewModel) 패턴**은 MVC패턴에서 발전했습니다. 그 후 2004년 MVP 패턴이 발표되고, 이를 개선한(Martin Fowler는 개선이 아니라 동일하다고 말한) MVVM 패턴이 발표가 됩니다. 

MVVM 패턴의 목적은 **비즈니스 로직, 프리젠테이션 로직과 화면을 그리는 UI를 분리**하는 것입니다. 

<p align="center">
    <img src="https://user-images.githubusercontent.com/60090790/156177740-4a66f786-1189-449b-9ed6-ddfd7bb9bc0f.png" width = "667" />
</p> 

MVVM 패턴의 구성요소, 종속성, 데이터의 흐름은 다음과 같습니다. 
- 구성 요소
    - View는 화면에서 보이는 것의 구조, 레이아웃, 모양을 정의합니다.
    - View Model은 View가 데이터를 바인딩할 수 있는 속성과 명령을 구현하고, 알림을 통해 모든 상태 변경을 View에게 알립니다.
    - Model은 앱의 데이터를 캡슐화합니다. 비즈니스 및 유효성 검사 로직, 데이터 모델을 포함하는 앱의 도메인 모델을 나타낸다고 생각할 수 있습니다.
- 종속성
    - View는 View Model을 알고 있고, View Model은 Model을 알고 있습니다.
    - 반대로 Model은 View Model을 알지 못하고, View Model은 View를 알지 못합니다.
    - ‘알고 있음’은 (import, reference, function call과 같은) 코드 의존성을 의미합니다.
    - View Model은 어댑터 역할을 합니다. View Model이 존재함으로써 Model과 View가 분리될 수 있습니다.
- 데이터의 흐름
    - Model은 데이터를 가져와 View Model에게 전달합니다.
    - View Model은 View에서 사용하기 편리한 형식의 데이터를 준비합니다.
    - View는 데이터를 화면에 렌더링합니다.



#### References

- [mozilla: MVC](https://developer.mozilla.org/en-US/docs/Glossary/MVC)
- [Concepts in Objective-C Programming: Model-View-Controller](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html)
- [MVC 디자인 패턴 in iOS](https://velog.io/@ictechgy/MVC-%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4)
- [Modern MVVM iOS App Architecture with Combine and SwiftUI](https://www.vadimbulavin.com/modern-mvvm-ios-app-architecture-with-combine-and-swiftui/)
- [Microsoft Enterprise Application Patterns using Xamarin.Forms eBook: The Model-View-ViewModel Pattern](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm)

---
## RxSwift, RxCocoa
### Functional Reactive Programming?
- **Reactive Programming**이 무엇인가?
    - 데이터 스트림과 변화(변경사항)의 전파에 관련된 비동기식 프로그래밍 패러다임 
- **Stream**
    - 스트림은 시간 순에 따라 진행 중인 이벤트의 시퀀스입니다. 값, 에러, 완료 신호를 방출할 수 있습니다.
    터치 이벤트, 텍스트 타이핑 등 모든 종류의 사용자 상호 작용이나 개체의 변경사항이 실제로 비동기 스트림입니다. 
    RP에서 모든 것이 스트림이라고 생각해 볼 수 있습니다. 프로퍼티, 자료구조 등 모든 것이 사용자의 입력이나 터치에서 생성된 이벤트 스트림과 같은 스트림입니다. 

- **Functional Programming**이 무엇인가?
    - 수학의 함수와 유사하게 입력값을 넣으면 어떤 처리 과정을 거쳐서 결과값이 나오게 됩니다. 처리 과정은 파이프 라인과 유사하여 내부에서 외부를 접근하거나 외부에서 내부를 볼 수 없습니다. 이런 함수들을 묶어서 프로그램을 구성해나가는 것을 함수형 프로그래밍이라고 합니다. 
    - 특징 
        1. Pure Functions  

            동일한 인자를 넣었을 때 항상 동일한 결과값을 반환해야 합니다. 
            언제 선언되었는지 등 외부에 영향을 받지 않도록 작성해야 합니다.

        2. Stateless, Immutability  

            인자로 전달된 데이터의 값을 변경할 일이 있다면, 새로운 개체를 만들어서 결과값으로 전달해야 합니다. 
            외부의 상태나 인자로 전달된 데이터의 상태를 변경하지 않음으로써 side effect(함수를 호출하면 외부의 상태가 변경되거나 예상하지 못한 에러가 발생되는 등)를 만들지 않습니다. 이를 통해 멀티쓰레딩 환경 등에서도 안정적으로 동작할 수 있습니다.

        3. Expressions Only  

            if나 switch와 같은 표현을 사용하지 않야아 합니다.

        4. First-class and higher-order functions  
        
            함수를 변수에 할당하거나 함수에 인자로 전달하거나 리턴하는 등의 일들을 할 수 있는 First Class, 함수 자체를 인자로 전달하거나 함수에서 또 다른 함수를 리턴하는 고차함수 두 가지 속성을 가지고 있어야 합니다.

### FRP를 사용할 때 장점
GCD, KVO, Delegate, Notification Center 등을 통해서 했던 비동기 처리를 일원화할 수 있습니다. 가독성이 높아지고, 유지보수성이 좋아진다고 합니다. 테스트하기 좋은 구조가 된다고 합니다. 

### OOP와 차이 

FP는 결과를 계산하는 것에 더 집중하는 것처럼 보여집니다. 그에 비해 OOP는 과정에 더 집중하는 것으로 보여집니다. 원하는 결과가 나온다고 해도 그 결과까지 계산하는 과정이 SOLID 원칙에 따라 적절하게 분리되지 않았다면 OOP를 잘 설계했다고 할 수 없습니다.     


#### References

- [Functional Reactive Programming using Swift](https://flexiple.com/ios/functional-reactive-programming-using-swift/#section1)
- [Introduction to Functional Programming using Swift](https://flexiple.com/ios/introduction-to-functional-programming-using-swift/)
- [함수형프로그래밍이 대세다?! (함수형 vs 객체지향)](https://www.youtube.com/watch?v=4ezXhCuT2mw&t=1s)


---
## FireBase
#### 장점
 FireBase를 사용하면 서버 구축과 서버 인프라 없이, 무료로 앱을 만들어서 배포할 수 있다는 장점이 있습니다. 프로젝트 관리 앱 특성상 실시간으로 데이터가 동기화되는 것이 중요하다고 생각했습니다. 배포 후 분석, 앱 충돌 보고 등 앱 관련 데이터를 제공하며, GUI를 통해 확인할 수 있습니다. 
#### 단점
FireBase를 사용할 때, 백엔드와 관련된 컨트롤을 잃게 된다는 리스크가 있습니다. 실제 FireBase를 사용했을 때 서버를 구축하는 것보다 속도는 느리다는 사용 평이 있습니다. 일정 한도를 넘어가면 유료 요금제를 사용해야 합니다. 이 단점들이 현재 상황에서 다른 장점보다 크게 작용하지 않았습니다. 
#### 선택한 이유
실제 배포를 전제하고 만들고 있지만, 시장에서 성공할 수 있는지 검증되지 않은 프로젝트를 진행하고 있기 때문에 시간과 자원을 절약하기 위해 FireBase를 선택했습니다.


---
## REST API
### REST API가 무엇인가?
REST(REpresentational State Transfer)는 distributed hypermedia systems의 아키텍처 스타일입니다. URI를 사용하여 액세스합니다. RESTful한 서비스 인터페이스가 되기 위해 원칙을 준수해야 합니다. 
### 왜 중요한가?

#### References
- [REST API Tutorial](https://restfulapi.net/)
---