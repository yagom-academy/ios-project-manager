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

![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/a606622f-dac0-42ec-9206-112cd25db805/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220301%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220301T083333Z&X-Amz-Expires=86400&X-Amz-Signature=02585bb8ec1fe9f34f51db33572502058a9eecd420ee86c3ca4d3c72c4a136c1&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

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
