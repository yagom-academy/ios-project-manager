# 📌 프로젝트 관리 앱
- 프로젝트 기간: 2022.02.28 ~ 2022.03.11

<br>

## 키워드
- `LocalDB`
    - `Realm`, `SQLite`, `CoreData`
- `RemoteDB`
    - `Firebase`, `CloudKit`
- `SPM (Swift Package Manager)`
- `SwiftUI`
	- `@EnvironmentObject`, `@State`, `@Binding`
	- `Text`, `Button`, `DatePicker`, `TextField`, `TextEditor`, `List`
	- `HStack`, `VStack`
	- `onTapGesture`, `onLongPressGesture`
	- `sheet`, `popover`, `alert`
- `MVVM`
	- `ViewModel`
- `Error Handling`
- `Localization`
- `Undo`
- `Local Notification`


<br>

## 구현 내용
- Realm, Firebase를 연동하여 데이터를 관리
-  MVVM 패턴으로 설계 하여 구현
-  SwiftUI를 사용하여 뷰를 구현
- 뷰를 적절히 분리하여 빌드의 부담을 줄이고 가독성을 높힘
- Todo/Doing/Done의 상태를 이용하여 각 해당 List에 맞게 구현하였다.
- HStack 안에 List 세개를 나란히 위치시켜 구현
- popover, sheet에 대해서 학습하고 사용
- 한 번 터치, 길게 누르는 터치에 따른 액션을 정의
-  업무의 진행상태를 enum으로 효율적으로 관리
- 의존성 관리도구에 대해 학습하고 SPM을 사용하여 진행
-  지역화의 개념을 이해하고 적절한 다국어 처리 구현
-  파이어베이스를 연동하여 원격 서버에 데이터를 저장하여 사용
-  Realm을 통해 로컬DB에 데이터를 저장하여 사용
-  서버에서 데이터를 가져오는 과정에서의 비동기 처리 구현
-  오류처리 및 오류메시지를 관리하여 구현
-  H.I.G를 고려하여 오류 내용 및 경고를 사용자에게 알리도록 구현
-  지난 작업내용을 popover를 사용하여 보여줄 수 있도록 구현

<br>

# STEP1 프로젝트 적용기술 선정

## 고민한 점

### 1. LocalDB 비교   

|종류|Realm|SQLite|Core Data|   
|---|-----|------|---------|   
|특징| - 오픈 소스 라이브러리로 모바일에 최적화된 데이터베이스 라이브러리 </br> - 데이터 컨테이너 모델을 사용하며 데이터 객체는 Realm에 객체로 저장 (객체중심의 데이터베이스) </br>- 메인쓰레드에서 데이터 읽기/쓰기 가능| - 전세계적으로 가장 많이 사용 되는 데이터 베이스 엔진이며 오픈소스 </br>- 서버가 필요없는 SQL 데이터 베이스 엔진 </br>- Swift에서는 특별한 설치 없이 바로 사용| - iOS에서 자체 제공하기 때문에 비교적 안정적임 </br>- Object에 더 중심을 둠 </br>- Obejct-C에 클래스로 표현되는 객체의 내용을 저장|
|장점| - 복잡한 Entity에 대한 매핑을 처리해야할 문제가 없으므로 Realm은 메모리 상의 객체를 디스크로 빠르게 가져올 수 있음 <br>- 데이터 용량에 제한 없이 무료<br>- 대용량의 테이터와 대규모 스토리지에 상관없이 일관된 속도 및 성능을 보장<br>- SQLite 및 CoreData 대비 빠른 속도<br>- Realm Studio툴을 사용하여 DB를 시각적으로 확인<br>- 몇 줄의 코드로 모든 작업을 처리 가능 |- 매우 작고 가벼워 전체 데이터 베이스를 하나의 디스크 파일에 저장할 수 있음 <br>- 서버로부터 독립적이고 설정이 간편 <br>- 다양한 OS에서 사용(Mac OS X, iOS, Android, Linux, Window) <br>- 여러 프로세스와 스레드로 부터 접근이 안전 |- SQLite보다 더 빠르게 저장된 기록을 가져옴 <br>- iOS에서 자체 제공하기 때문에 비교적 안정적임 |
|단점| - 외부 라이브러리를 설치해서 사용해야 하기 때문에 비교적 위험이 있음 <br>- 메인 스레드를 사용해서 다른 스레드 접근 시 에러 발생 <br>- 바이너리 용량이 큼 <br>- 다양한 쿼리를 지원하지 않음 | -  Date Time 같은 필드가 존재하지 않음 <br>- 성능이 Realm에 비해 좋지 않음 | - SQLite보다 많은 메모리를 사용하고, 더 많은 저장공간이 필요 <br>- 오버헤드가 발생할 가능성이 있음 <br>- 다른 플랫폼의 OS와 공유가 되지 않음 |

<br>

### 2. RemoteDB 비교
|종류|Firebase|CloudKit|
|---|--------|--------|
|특징|- 구글에서 제공하는 모바일 앱개발 플랫폼 <br>- NOSQL <br>- 실시간으로 사용자 간에 데이터를 저장하고 동기화함 <br>- 구조화된 JSON 및 Collection 데이터 처리에 적합 | - 앱 및 사용자 데이터를 iCloud 서버 (container)에 저장하기 위한 Apple의 프레임워크 <br>- 간단한 데이터는 Key-Value 형식으로 저장 가능함 |
|장점|- 루트 아래에 있는 데이터를 유연하게 관리 <br>- 직관적으로 데이터 베이스 구조 파악이 쉬움 <br>- Android와 공유가 가능 <br>- 비교적 저렴  <br>- Analytics를 제공하여 다수의 사용자의 앱 사용 패턴에 대한 통계를 확인| - 사용자를 자동으로 안전하게 인증 <br>- CoreData와 연동이 편함 <br>- 다른 애플의 기기와의 연동이 용이함 |
|단점|- 다른 트리의 다른 노드에 대한 참조는 수동으로 관리해야함 <br>- iOS보단 Android에 더 최적화 되어 있음 <br>- 종종 서버의 응답속도가 느려짐 <br>- 쿼리가 빈약 (or 문이나 Like문 같은 경우 데이터를 모두 받아와서 직접 필터링 해주어야한다.)| - Android를 지원하는데 한계가 있음 |

<br>

### 3. 프로젝트 적용 기술
**LocalDB: Realm**
Realm은 다른 플랫폼과의 연동이 가능하고 간단한 코드로 사용이 가능하며 다른 LocalDB에 비해 성능이 가장 좋아 선택했다.

**RemoteDB: Firebase**
Firebase는 다른 플랫폼과도 연동이 가능하고 비교적 저렴하며, 사용자의 앱 사용 패턴을 확인할 수 있어 마케팅에도 도움이 될 수 있어 Firebase로 선택했다.

<br>

### 4. 기술스택 고려사항
1. **하위 버전 호환성에는 문제가 없는가?**
	- Deployment Target: iOS 14이상으로 문제 없다.
		- Realm: iOS 11 이상 (SPM)
		- Firebase: iOS 10 이상 (SPM)
2. **안정적으로 운용 가능한가?**
	- 안정적으로 운용 가능함
		- Realm: 많은 곳에서 사용하고 있으며, 모바일에 최적화 되어 있다.
		- Firebase: 많은 곳에서 사용하고 있다.
3. **미래 지속가능성이 있는가?**
	- 미래 지속가능성 충분
		- Realm:  꾸준히 사용되고, 업데이트 되고 있다.
		- Firebase: 꾸준히 사용되고, 업데이트 되고 있다.
4. **리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?**
	- 모두 외부의 라이브러리이기 때문에 리스크가 전혀 없다고 할 순 없지만 현저히 낮다고 판단된다.
		- Realm: 바이너리 용량이 큰편이어서 메모리 관리 시 주의 필요, 메인스레드에서만 사용할 수 있다. (CRUD 이외의 Realm 내부의 인스턴스를 다룰 때에도 메인스레드에서만 사용가능 하다.)
		- Firebase: 종종 서버의 응답속도가 느려진다는 단점있다.
5. **어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**
	- 모두 Cocoa Pods, Carthage, SPM 사용 가능하다.
6. **이 앱의 요구기능에 적절한 선택인가?**
	- 프로젝트에서 사용 필요로 하는 기능과 성능에 대해서는 충분하다고 생각된다.
	- Deployment Target도 적절하다.



# STEP 2 : 프로젝트 할일 리스트 구현


## 고민한 점

### 1. ViewModel 타입
ViewModel에 맞는 데이터 타입을 하나 더 만들어서 사용하려고 하였으나,    
뷰에서 사용하는 데이터와 실제 모델의 데이터가 같아 뷰모델을 위한 데이터 타입을 만들지 않고 로직 내부에서 사용하는 모델을 그대로 사용하였다.

### 2. 메인화면의 상단바를 네비게이션으로 해야하는가?
네비게이션으로 해야할지 따로 바형태로 뷰를 만들어야할지 고민했지만,   
아이패드 전용앱으로서 Todo, Doing, Done 세가지의 리스트를 하나의 화면에서 보여주는 것이 중점이고 현재의 방향에서 네비게이션뷰가 사용될 일이 없다고 판단하였다. 이런 이유로 네비게이션으로 상단바를 따로 만들어 주었다.

### 3. dismiss하는 방식
뷰를 dismiss하는 방식을 두가지를 고민하였다.   
첫번째는 보여주는 뷰의 상태를 수정해서 스스로 닫도록 하는 방법이다.
보여주고 닫아야 하는 뷰에 environment property를 추가하여 presentationMode를 수정할 수 있도록 해주고 뷰를 닫아야할 때 dismiss를 호출한다.

```swift
// environment property 추가
@Environment(\.presentationMode) var presentationMode

// 뷰 dismiss
self.presentationMode.wrappedValue.dismiss()
```

두번째 방법은 바인딩을 이용하는 것이다.   
새로 띄운 뷰를 호출한 뷰에 바인딩을 전달하는 것으로 바인딩된 값을 띄워준 뷰에서 false로 하게 되면 뷰가 닫힌다.

```swift
// 새로운 뷰를 띄우도록 하는 뷰에서 설정
@State private var isShowTaskDetailView = false

.sheet(isPresented: $isShowTaskDetailView, onDismiss: nil) { 
    TaskDetailView(isShowTaskDetailView: $isShowTaskDetailView, task: task)
}

// 띄울 뷰
@Binding var isShowTaskDetailView: Bool

self.isShowTaskDetailView = false
```

### 4. SwipeActions
List의 row를 삭제하기 위해 SwipeActions를 사용하려고 하였으나 SwipeActions은 iOS15 이상부터 지원하는데 현재 프로젝트의 타겟 버전을 iOS14으로 설정하였기 때문에 사용하지 못했다.   
그래서 아래의 버전도 사용할 수 있는 `onDelete`를 사용하였다. SwipeActions가 이미지 버튼을 만들 수 있는 등 여러 기능이 있어 사용하고 싶었지만 1-2년 이후에 사용할 수 있을 것 같다.


## Trouble Shooting

### 1. List에서 row를 공백을 터치하면 동작하지 않는 문제

### 문제점
- row를 클릭시 글자 등 컨텐츠가 없는 곳을 클릭하면 터치기능이 동작하지 않음

#### 원인
- 터치 제스처를 row에 컨텐츠를 감싸고 있는 스택에 지정해두었다. 그래서 스택의 width의 길이는 각 우리가 보는 각 row의 길이가 아니라 글자가 써있는 컨텐츠의 width였다.

```swift
VStack(alignment: .leading, spacing: 4) {
    title
    descrition
    deadline
}
.onTapGesture {
	// ...
}
```

#### 해결방안
- 스택의 width의 크기를 row의 width와 같게 해주고 contentShape을 통해서 인식할 수 있도록 하여 터치할 수 있도록 해준다.

```swift
VStack(alignment: .leading, spacing: 4) {
    title
    descrition
    deadline
}
.frame(maxWidth: .infinity, alignment: .leading)
.contentShape(Rectangle())
.onTapGesture {
	// ...
}
```


### 2. List에 row가 두 개 이상일 때 터치가 먹히지 않는 문제
#### 문제점
- row가 두 개 이상일 때 터치를 하면 List의 처음 row의 정보만 뜨고, 길게 터치하는 것은 먹히지 않음

#### 원인
- 기존에는 아래와 같이 for문 안에서 TaskListCellView에 제스처를 등록해주었다. for문안에서 뷰를 그리는 중에 제스처를 등록하여 제대로 작동하지 않았다.

```swift
List {
    ForEach(taskList) { task in
        TaskListCellView(task: task)
            .onTapGesture {
				// ...
            }
    }
}
```
#### 해결방안
- 뷰를 분리하여 TaskListCellView안의 스택에 제스처를 등록해주었다.

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 4) {
        title
        descrition
        deadline
    }
    .onTapGesture {
		// ...
    }
}
```


## PR 후 개선사항

### 1. 뷰 나누기 (프로퍼티 -> 구조체)
기존에는 뷰를 프로퍼티로 나누었는데, 프로퍼티로 나누는것보다 구조체로 나누는 것이 더 효율적이어서 뷰를 나누는 방식을 구조체로 변경하였다.
그러고 나서는 빌드할 떄 눈에 띌 정도로 성능이 개선된 것을 확인할 수 있었다.

뷰를 프로퍼티로 저장하게 되면 연산프로퍼티로 저장되어 사용할 때마다 다시 계산하도록 하는데, 
구조체로 구현하면 저장했던 데이터를 불러와서 사용하기 때문에 성능에 도움이 된다.

참고자료: [Computed property vs Stored property](https://www.hackingwithswift.com/quick-start/understanding-swift/when-should-you-use-a-computed-property-or-a-stored-property)

### 2. 뷰에 있는 로직 뷰모델로 이동
MVVM 구조에서 뷰는 뷰의 역할, 보여주는 역할만 충실해야하기 떄문에 뷰에 로직이 들어가서는 안된다고 생각한다. 반대로 뷰모델에서 뷰의 요소를 사용해서 뷰의 속성을 변경하면 안된다고 생각한다.

그래서 기존에 뷰에 있던 로직을 뷰모델에서 처리할 수 있도록 구현하였다.

### 3. 뷰모델 나누기
Detail뷰에 대한 뷰모델을 따로 만들어 관리하는것이 기존의 뷰모델의 부담을 줄여줄 수 있고, Detail뷰에 있던 로직을 Detail뷰의 데이터를 관리하는 뷰모델로 옮길 수 있어 효율적이라고 생각했다.


# STEP 3 : 로컬 디스크 저장 및 리모트 동기화 구현


## 고민한 점
### 1. 언제 사용자에게 에러를 알려주어야 할까
  - 처음에 앱을 실행했을 때 네트워크 통신이 된다면 Firebase와 Realm을 동기화 하도록 하였고, 네트워크 통신이 되지 않는다면 네트워크 연결이 되어있지 않다는 얼럿을 띄운 후 사용할 수 있도록 하였다. ( 후에는 Realm에만 저장)

- 네트워크 통신이 되는지 안되는지 확인하여 네트워크 통신이 된다면 Firebase와 통신하도록 분기처리 하였다.
   - 처음에는 Delegate 패턴으로 구현하였으나 Delegate 패턴을 사용하면 결국에 NetworkManager가 ViewModel이 하는 일중 일부를 알게 되는 것이라는 생각이 들어 모니터링하는 메서드를 이스케이핑 함수로 구현해 ViewModel에서 호출하도록 하였다.

- Firebase에서 발생하는 에러도 처리하도록 하여 에러 발생 시 얼럿을 띄울 수 있도록 하였다.


### 2. 히스토리 관리를 어떻게 해야할까

히스토리를 관리하는 Manager 타입과 모델타입을 만들어 관리하도록 구현했다.
그리고 appendHistory() 메서드를 만들어서 파라미터를 열거형(추가/이동/삭제) 연관값으로 하여 필요한 데이터를 받아서 히스토리에 올릴 스트링을 만들어 히스토리에 추가하도록 했다.

### 3. 에러처리의 기준?

Service가 ViewModel의 처리방식에 대해 알고, 에러를 보내주지 않는 것은 ViewModel이 에러가 필요해진 시점이 올 때 처리할 작업이 많아지고 위험해진다고 생각했다.
그래서 먼저 에러를 처리할지 말지를 결정하고 에러를 처리한다면 ViewModel까지 에러를 보내주는 것이 맞다고 생각하였다.


## Trouble Shooting

### 1. popover할 때 List의 크기에 맞게 동적으로 변화실킬 순 없을까?
#### 문제점
- List를 popover로 하게 되면 List가 제대로 나오지 않았다.

![image](https://user-images.githubusercontent.com/90945013/159208076-b1ec4d42-5024-4d72-9ec5-7df33f90c0a5.png)

#### 원인
- LIst item의 width가 item의 내용에 따라 달라질거라고 생각하고 있었는데, 다시 생각해보니 내용에 따라 달라지는 것이 아니라 List에 지정된 크기대로 지정되는 것이 아닌가라는 생각이 든다. 
- 일반 뷰는 화면 크기에 따라 그에 맞게 리스트 크기가 정해질 수 있지만 popover에 올린 List는 크기가 정해져 있지 않아 이상하게 나온것으로 보인다.

#### 해결방안
- 1안: List의 크기를 직접 지정해준다.
- 2안: `GeometryReader`를 사용해서 구현한다.
- 3안: Stack과 scrollView를 이용하여 구현한다.

3안을 선택했다.    
- Stack을 사용하면 List item의 내용에 따라 popover 뷰의 크기가 동적으로 적용된다.
- 내용의 크기가 스택의 크기를 만들고 스택의 크기가 popover뷰의 크기를 만들기 때문에 따로 크기를 지정해주지 않아도 된다.


### 2. 네트워크 연결 체크 시 오류
#### 문제점
- 기기에 네트워크가 연결되지 않았을 떄 이를 사용자에게 알리기 위해 `NWPathMonitor`를 이용하 네트워크 연결을 모니터링 하도록 하고 있다.   
- 처음에 앱을 시작할 때는 네트워크 연결이 되어있지 않으면 얼럿으로 통해 사용자에게 알린다.(처음 앱을 시작할떄는 정상)  
- 그런데 앱을 사용하던 도중에 네트워크가 갑자기 끊어지는 상황에서는 에러가 발생하지 않고 네트워크가 다시 연결될 때 연결되지 않는다는 얼럿이 띄워진다. (네트워크 상황과 반대로 동작한다.)


```swift 
monitor.pathUpdateHandler = { [weak self] path in
    DispatchQueue.main.async {
        self?.isConnected = path.status == .satisfied
        self?.isNotConnected = !(self?.isConnected ?? true)
        
        if self?.isConnected == true {
            print("연결됨")
        } else {
            print("연결안됨")
        }
    }
}
monitor.start(queue: queue)
```

#### 원인
- 분명 로직도 맞게 구현을 했고 문제가 없다고 생각했다. 
- 그래서 의심이 되는 것은 시뮬레이터 에러였다.

#### 해결방법
- 실제기기에서 직접 실해해 보니 문제없이 구현한대로 동작하는 것을 확인할 수 있었다.
- 시뮬레이터를 무조건 믿지는 말자..



[![top](https://img.shields.io/badge/top-%23000000.svg?&amp;style=for-the-badge&amp;logo=Acclaim&amp;logoColor=white&amp;)](#프로젝트-관리-앱)
