# 🗓 프로젝트 매니저

> 프로젝트 기간: 2022.07.04 ~ 2022.07.29 <br>
> 팀원: [Donnie](https://github.com/westeastyear), [grumpy](https://github.com/grumpy-sw)
> 리뷰어: 🍕[라자냐](https://github.com/wonhee009)

# 📋 목차
- [프로젝트 소개](#-프로젝트-소개)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [타임라인](#-타임라인)
- [PR](#-pr)
- [STEP 1](#step-1)
    + [STEP 1 적용 기술 선정 및 근거](#-step-1-적용-기술-선정-및-근거)
- [STEP 2](#step-2)
    + [STEP 2 진행과정](#-step-2-진행과정)
    + [STEP 2 프로젝트 구조](#-step-2-프로젝트-구조)
    + [STEP 2 고민한 점](#-step-2-고민한-점-및-해결한-부분)
- [STEP 3](#step-3)
    - [STEP 3 진행과정](#-step-3-진행과정)
    - [STEP 3 고민한점 및 해결한 부분](#-step-3-고민한-점-및-해결한-부분)
    - [STEP 3 조언을 얻고 싶은 부분](#-step-3-조언을-얻고-싶은-부분)

<br>

## 🔎 프로젝트 소개
### "할건 많고 시간은 부족한 당신! 🫵🏻"
### "매니저가 필요해 보이는군요?!" 
### "Project Manager로 해야할 일을 손쉽게 관리해보세요!"

<br>

## 📺 프로젝트 실행화면
|생성|수정|
|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/74251593/178438864-c0a64d55-654c-4b12-b6c3-d66a2ef36f40.gif" width="100%">|<img src="https://user-images.githubusercontent.com/74251593/178439799-864456ce-93e2-46a2-8b32-c719decc7ad6.gif" width="100%">|

|셀 삭제|팝오버 뷰|
|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/74251593/178440435-0fff20c0-4641-4e07-9837-f60128939d87.gif" width="100%">|<img src="https://user-images.githubusercontent.com/74251593/178440781-97e2fa3d-6383-43f6-9798-5f44babdb8b3.gif" width="100%">|

|셀 이동|
|:---:|
|<img src="https://user-images.githubusercontent.com/74251593/178441458-0d4aca99-db43-4885-aa89-06441928e49d.gif" width="60%">|

|온라인|오프라인|
|:---:|:---:|
|<img width="142" alt="스크린샷 2022-07-22 오후 8 29 43" src="https://user-images.githubusercontent.com/63997044/180430289-adc8e7d0-6852-4d20-8fb6-db8d40724866.png">|<img width="139" alt="스크린샷 2022-07-22 오후 8 29 53" src="https://user-images.githubusercontent.com/63997044/180430312-262f69d0-aa75-4678-b05a-dfc9f98f74b9.png">|

|변경 내역 확인하기|
|:---:|
|<img src="https://user-images.githubusercontent.com/63997044/180429788-c3a2014c-e127-4021-bceb-9b6b2179c354.png" width="80%">|

<br>

## ⏱ 타임라인
- 프로젝트 매니저

|날짜|내용|
|--|--|
|22.07.04(월)|프로젝트 적용 가능한 기술 조사|
|22.07.05(화)|STEP1 PR|
|22.07.06(수)|STEP1 피드백 반영|
|22.07.07(목)|STEP2-1 진행|
|22.07.08(금)|STEP2-1 진행|
|22.07.11(월)|STEP2-2 진행|
|22.07.12(화)|STEP2 PR|
|22.07.13(수)|STEP2 피드백 반영|
|22.07.14(목)|코드 리팩토링|
|22.07.15(금)|리뷰 코멘트 확인 및 README 작성
|22.07.18(월)|프로젝트 적용 가능한 기술 조사|

- 프로젝트 매니저 II

|날짜|내용|
|--|--|
|22.07.19(화)|STEP1 진행|
|22.07.20(수)|STEP1 진행|
|22.07.21(목)|STEP1 진행|
|22.07.22(금)|STEP1 PR, README 작성|

<br>

## 👀 PR
프로젝트 매니저
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/124)
- [STEP 2](https://github.com/yagom-academy/ios-project-manager/pull/139)

프로젝트 매니저 II
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/160)
<br>

## 🛠 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![iOS](https://img.shields.io/badge/iOS-15.5-red)]()

<br>

## 🔑 키워드
- RxSwift
- RxCocoa
- RxRelay
- Firebase
- Realm
- SnapKit
- SwiftLint
- Swift Package Manager
- Cocoapod
- RxGesture
- MVVM
- NWPathMonitor
- UISplitViewController
- NotificationCenter

<br>

## [STEP 1]
## 🔧 STEP 1 적용 기술 선정 및 근거
|Reactive|UI 구현|로컬 DB|원격 DB|Convention|Layout|
|:---:|:---:|:---:|:---:|:---:|:---:|
|RxSwift|RxCocoa|Realm|Firebase|SwiftLint|SnapKit|

### RxSwift
- `Swift`로 `Reactive` 프로그래밍을 하기 위해 선택
- 비동기적으로 움직이는 이벤트들을 직관적, 효율적으로 코드를 작성하기 위함

### RxCocoa
- `Cocoa Framework에 Rx(ReactiveX)` 기능을 결합한 라이브러리
- `UI`구성요소에 반응형 확장 기능을 추가하여 `UI`이벤트 추가 가능

### Realm
`Realm` vs `CoreData`
1. 데이터베이스 사용 면에서 `Realm`이 `CoreData`보다 사용하기 쉽다.
2. `Realm`이 `CoreData`보다 모델을 관리하기 쉽다.
3. `third-party` 라이브러리이기 때문에 `Realm`을 사용했을 때 앱의 용량이 커진다.
4. `CoreData`는 `Realm`과 다르게 `cross-platform mobile device`가 아니다.

위 이유로 로컬 DB를 관리하는 기술로 `Realm`을 선정

### Firebase 
||`RealTime Database`|`Cloud Firestore`|
|:---:|:---:|:---:|
|**특징**|데이터를 하나의 큰 JSON 트리로 저장|데이터를 문서와 컬렉션으로 저장|
|**장점**|지연 시간이 짧아 동기화가 자주 발생할 때 유리하다.|풍부하고 빠른 쿼리<br>원활한 확장성|
|**단점**|데이터의 크기가 성능에 영향을 준다.<br>확장이 어렵다.|요청 쿼리 결과에 따라 성능에 영향을 줄 수 있다.|

- 비록 `Cloud Firestore`가 후속으로 나온 제품이지만 다음과 같은 부분에서는 아직까지 강점을 보이고 있다고 생각해서 `Realtime Database`를 선택
    - 잦은 데이터 동기화
    - 작은 단위의 데이터가 자주 변경
    - 데이터 형식이 간단한 json 트리
    - CRUD 작업이 자주 발생


### SwiftLint
- 협업 시 공통적인 코딩 컨벤션으로 코드를 작성하기 위해 선택

### SnapKit
- 짧은 코드로 `AutoLayout`을 표현할 수 있도록 도와주는 프레임워크
- `AutoLayout` 설정 시 작성해야 하는 `Constraints` 관련 코드들을 줄일 수 있음
- 잘 만들어진 프레임워크를 사용함으로써 `Layout`에 대응하는 시간을 줄이고, 보다 더 중요한 로직을 구성하는데 시간을 집중하기 위해 선택

<br>

---

## [STEP 2]
## ⏳ STEP 2 진행과정
- **[STEP 2-1]**
    - 화면 `UI` 구현
- **[STEP 2-2]**
    - 뷰 업데이트 및 비즈니스 로직 구현
- **[STEP 2-3]**
    - `RxSwift`, `RxCocoa`로 뷰의 요소들을 연결
- **[STEP 2-4]**
    - `MVVM` 구조로 비즈니스 로직 리팩토링

> - 위 4단계로 나누어 진행하였고 
> `[STEP 2-1]`, `[STEP 2-2]` -> `[STEP 2-1]브랜치`,
> `[STEP 2-3]`, `[STEP 2-4]` -> `[STEP 2-2]브랜치`

<br>

## 🏛 STEP 2 프로젝트 구조
- ### 사용한 외부 라이브러리
<img width="633" alt="스크린샷 2022-07-15 오후 4 00 24" src="https://user-images.githubusercontent.com/63997044/179169527-ef883e28-7634-4c36-8ed5-24fad58e4858.png">

<br>

- ### 프로젝트 파일구조
<img width="268" alt="스크린샷 2022-07-15 오후 3 57 48" src="https://user-images.githubusercontent.com/63997044/179169075-398b9461-7269-45a9-b8b8-a9d49822cb8d.png"><br>

- **View**
    - 사용자에게 보여지는 화면에 해당
- **View Controller**
    - `View`를 생성하고 데이터 바인딩을 통해 `View Model`로 데이터를 전달
    - 화면 이동 등 동작을 수신
- **View Model**
    - `View Controller`로부터 이벤트를 수신하여 비즈니스 로직(데이터베이스의 데이터 저장 등)을 처리하고 값 업데이트를 통해 뷰에 연결된 속성 갱신
- **RealmManager**
    - `Realm` 인스턴스를 갖고 `Real Database`에 조회, 수정, 추가, 삭제 작업을 담당하는 구조체

<br>

## 🤔 STEP 2 고민한 점 및 해결한 부분
### 1. Realm 데이터베이스 사용
> `Realm` 인스턴스를 갖고 `Real Database`에 조회, 수정, 추가, 삭제 작업을 담당하는 구조체인 `RealmManager`를 통해 로컬 데이터를 저장하며 프로젝트를 진행하였습니다.

<br>

### 2. `UI`프로퍼티 생성시, 간결함과 중복을 제거하기 위한 `Then`기능 활용
> - `Then`라이브러리를 그냥 가져다가 사용하지 않고 저희에게 필요한 기능을 가진 부분을 확인하여, 팀원과 한줄한줄 공부한다음 직접 구현하여 사용해 보았습니다.
> - 다른 캠퍼가 이 기능을 사용하는것을 우연히 알게 되었고, `UI`프로퍼티 생성시 당연한 줄만 알았던 중복되는 부분을 제거할 수 있다는 점에 매료되어 이번 프로젝트에 적용해 보았습니다.

```swift
protocol Then {}

extension Then where Self: AnyObject {
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}
```

<br>

### 3. `longPressed` 제스쳐 처리
> - `longPressed` 제스쳐를 추가하려면 `GestureReconizer`를 생성하고 이를 테이블뷰에 추가해주어야 했습니다. 
> - 코드를 리팩토링하면서 `button.rx.tap`처럼 간단하게 `event`를 처리하는 로직이 있지 않을까 알아보다가 `RxGesture`를 통해 필요한 제스쳐에 대한 동작을 쉽게 핸들링할 수 있었습니다.

- 기존 방법
```swift
private func setupLongPressedGesture(at tableView: UITableView) {
    let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    tableView.addGestureRecognizer(longPressedGesture)
}
@objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
    if gestureRecognizer.state == .began {
        ....
    }   
}
```
- `RxGesture`라이브러리 사용 후
```swift
mainView.todoTableView.rx.longPressGesture()
    .when(.began)
    .map { $0.location(in: self.mainView.todoTableView) }
    .subscribe(onNext: { 
        ....
    })
    .disposed(by: disposeBag)
```

<br>

### 4. 기한에 지난 날짜가 있으면 빨간색으로 표시하는 방법
> - 처음엔 저장된 `date`와 현재 시간을 비교하여 기한이 지났는지 확인하는 로직을 사용하였는데, 날짜가 지나야 데드라인을 넘긴 항목으로 처리하도록 수정했습니다.
> - `now`는 오늘의 시작 시간(00:00)이 되어 오늘까지인 항목들은 `Label`을 빨간색으로 표시하지 않습니다.
```swift
let now = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
```

<br>

### 5. `Error Handling`을 위한 `Error Observable` 생성

- #### 코드
```swift
var error: PublishRelay<DatabaseError> = .init()


---------------------중략------------------------


do {
    try realmManager.delete(task: task)
} catch {
    self.error.accept(DatabaseError.deleteError)
}


---------------------중략------------------------


private func bindErrorAlert() {
    viewModel.error
        .subscribe(onNext: { [weak self] error in
            self?.showAlert(message: error.errorDescription)
        })
        .disposed(by: disposeBag)
}
```

- #### Alert
![스크린샷 2022-07-14 오후 10 20 52](https://user-images.githubusercontent.com/63997044/179173671-5b3b1b7e-87cc-481a-9ab3-a8d538f04496.png)

<br>

- `Realm DB`에 접근해 `CRUD` 작업을 하면서 발생할 수 있는 예외사항에 대한 처리를 하기 위해 `DatabaseError`를 정의했습니다.
- `Exception`이 발생하게 되면 `PublishRelay`인 `error`에, 해당되는 `DatabaseError` 케이스를 담습니다.
- 이를 `subscribe`하고 있는 `View Controller`에서는 이벤트를 인지하여 사용자에게 `Alert`을 출력합니다.<br>

<br>

---
## [STEP 3]
## ⏳ STEP 3 진행과정
- **[STEP 3-1]**
    - 네트워크 연결 상태 표시
- **[STEP 3-2]**
    - 원격 DB(Google Firebase)에 대한 CRUD 구현
    - 로컬 DB(Realm)과의 데이터 동기화 구현
- **[STEP 3-3]**
    - 변경 이력(History) 기능 구현
    - 소스 코드 리팩토링

## 🤔 STEP 3 고민한 점 및 해결한 부분
### 1. `History`이력을 어떤 `UI/UX`로 보여야 할지 고민하였습니다.
<img src="https://user-images.githubusercontent.com/74251593/180429093-f262a451-4f03-4fa4-9937-a22ad70afc08.png" width="80%"><br>

> - 기능구현 예시에서는 `popoverView`로 되어있지만, 좀더 다양한 걸 해보고 싶은 마음이 들었습니다.
> - 팀원과 협의후에 `iPad`와 잘 어울리는 `splitView`를 적용해 보자고 의견을 나누었고, 적용해 보았습니다.

<br>

### 2. `History`이력을 생성(데이터 전달)하기 위해 고민하였습니다.
> - `splitView`에 데이터를 전달하기 위해, 처음에는 `delegate` 패턴을 고민하였으나 `MainViewController`와 `HistoryViewController`간의 관계가 없다는걸 파악하게 되었습니다.
> - 그래서, 어느곳에 있던지 키만 맞으면 데이터가 전달되는 `NotificationCenter`를 활용하여 `History`이력을 생성할 수 있었습니다.

```swift
// 예시
private func sendNotificationForHistory(_ title: String) {
    let content = "Added '\(title)'."
    let time = date.value
    let history: [String: Any] = ["content": content, "time": time]
    NotificationCenter.default.post(name: NSNotification.Name("History"), object: nil, userInfo: history)
}
```

<br>

### 3. 로컬과 원격 데이터베이스의 동기화 작업
- 두 데이터베이스의 데이터 동기화 작업을 다음 과정을 거쳐 진행하였습니다.

    - 1. 로컬 디스크에서 전체 데이터 조회(이하 `L`)
    - 2. 원격 데이터베이스에서 전체 데이터 조회(이하 `R`)
    - 3. `L`과 `R`을 비교하여 둘을 비교하여 `R`에는 존재하고 `L`에는 없는 데이터를 골라냅니다.
    - 4. `R`에 `L`의 내용을 전부 업데이트합니다.
    - 5. 3에서 골라낸 데이터를 `R`에서 전부 삭제합니다.
    
- 위와 같이 구현한 이유
    - 1. 추가/수정/삭제가 일어날 때마다 두 곳 모두에 데이터를 저장해 줄 필요는 없습니다.
    - 2. 네트워크 상황에 관계없이 로컬 데이터베이스(`Realm`)에는 데이터가 항상 저장되어야 합니다.
    - 3. 따라서 기준 데이터베이스는 로컬 데이터베이스가 되고, 특정 상황에서만 로컬 -> 원격으로 데이터를 전송하여 동기화 작업을 하도록 구현하였습니다.
    - 4. 현재는 로컬 데이터를 기준점으로 원격 데이터베이스를 항상 업데이트하고 있는데, 백업 저장소 역할도 할 수 있도록 이 부분을 고민해볼 예정입니다. 

<br>

## 🤔 STEP 3 조언을 얻고 싶은 부분
### 1. 앱 종료 시 동기화 작업 진행
- 저희가 생각한 로컬과 서버의 동기화 작업 시점은 다음 세 가지입니다.
 
    - 사용자가 앱을 실행시켰을 때
    - 앱의 상태가 오프라인에서 온라인으로 전환되었을 때
    - 사용자가 앱을 종료했을 때

- 이 중에서 세 번째 상황에 대한 구현을 하기 위해`AppDelegate`의`applicationWillTerminate(_ application: UIApplication)` 내부에 코드를 작성하였는데, 함수의 동작이 다 끝나지 않았는데도 중간에 종료가 되는 것을 확인하였습니다. 
- 저희가 예상하기로는 이 메서드가 앱이 종료될 때 어떤 동작을 시키기 위해 존재하는 것이 아니라 앱이 종료된다는 것을 알리기 위한 메서드이기 때문일 것이라고 생각하는데요.
- 앱이 종료될 때 특정 동작을 하도록 정의하는데 사용하는 다른 방법이 있을까요? 

```swift
func applicationWillTerminate(_ application: UIApplication) {
    DispatchQueue.main.async {
        let synchronizeManager = SynchronizeManager(realmManager: RealmManager())
        // synchronizeDatabase() 메서드 돌다가 프로그램 종료됨
        synchronizeManager.synchronizeDatabase { result in
            switch result {
            case .success:
                print("동기화")
                return
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
```

<br>

### 2. Network 상태에 따라 View와 ViewModel 둘 다 변화가 있어야 하는 경우
- `MainViewModel`은 `viewDidLoad()`상태를 수신받자마자 `startMomitoring()`을 통해 `Network` 상태를 모니터링합니다.
- 네트워크 상태값인 `network`값이 `true`인 경우 `ViewController`는 이벤트를 수신하여 네트워크 상태를 나타내는 이미지의 색을 변경합니다.
- 동시에 `ViewModel`에서는 원격 데이터베이스와 로컬 데이터베이스의 동기화 작업을 수행해야 합니다.

```swift
viewModel.network
    .map { [weak self] bool in
        if bool {
            DispatchQueue.main.async {
                self?.viewModel.syncronize()
            }
            return UIColor.systemGreen
        } else {
            return UIColor.systemRed
        }
    }
    .bind(to: networkIcon.rx.backgroundColor)
    .disposed(by: disposeBag)
```
- 현재 그 내용이 위 코드로 구현되어 있는데 `ViewModel`의 상태값 변화를 `ViewController`가 감지하여 다시 `ViewModel`의 메서드를 실행시킨다는 것이 부자연스럽게 느껴집니다. 위의 코드를 어떻게 개선할 수 있을까요?

<br>

---
