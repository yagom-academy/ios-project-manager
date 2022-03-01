# 📱 프로젝트 관리 앱

## 🧰 적용 기술 선정

|UI|비동기 이벤트 처리|Local DB|Remote DB|의존성 관리 도구|
|:-:|:-:|:-:|:-:|:-:|
|[SwiftUI](https://developer.apple.com/kr/xcode/swiftui/)|[Combine](https://developer.apple.com/documentation/combine)|[Realm](https://github.com/realm/realm-swift)|[Firebase](https://github.com/firebase/firebase-ios-sdk)|[Swift Package Manager](https://www.swift.org/package-manager/)|

<br>

## STEP 1 - 라이브러리 의존성 추가 및 환경 설정

### 1️⃣ SwiftUI -> UIKit Intergration

- UIKit 으로 만들어진 기존 프로젝트에 `SwiftUI` 프레임워크를 적용했습니다.
- 스토리보드와 ViewController.swift 파일을 삭제하고 `ContentView.swift` 파일을 만들어서 SwiftUI 스타일로 구성했습니다.
- [UIHostingController](https://developer.apple.com/documentation/swiftui/uihostingcontroller)를 이용하여 rootVC 를 `SwiftUI view`로 wrapping 했습니다.
  - 📄 참고 문서 -> [SwiftUI Views Displayed by Other UI Frameworks](https://developer.apple.com/documentation/swiftui/swiftui-views-displayed-by-other-ui-frameworks)

```swift
// SceneDelegate.swift

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let hostingVC = UIHostingController(rootView: ContentView())
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = hostingVC
    window?.makeKeyAndVisible()
}
```

<br>

### 2️⃣ Firebase, Realm 라이브러리 추가

- 데이터 저장을 위해 사용할 Firebase, Realm 라이브러리를 `Swift Package Manager`를 통해 의존성 추가했습니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156151495-9c87e930-128c-451a-a4cd-12a5f2a88293.png" width="40%"></p>

<br>

### 3️⃣ Firebase Realtime DB 연동 체크

- Firebase 의 `Realtime Database` 기능을 사용하기 위해 [해당 블로그](https://ios-development.tistory.com/231?category=899471) 참고하여 테스트를 진행했습니다.
- SwiftUI 프레임워크에서는 viewDidLoad() 메서드를 사용할 수 없어서, [onAppear(perform:)](https://developer.apple.com/documentation/swiftui/view/onappear(perform:)) 메서드를 사용했습니다.

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156117315-5ea9a249-6310-4c35-bbfe-f84b0c3b4406.png" width="100%"></p>

<br>

### 4️⃣ Google Firebase API Key 노출에 대해서

- Firebase 연동을 위해 추가한 `GoogleService-Info.plist` 파일을 깃헙에 푸시하고 잠시 후에 [GitGuardian](https://www.gitguardian.com/) 이라는 곳에서 이메일을 받았습니다.
- 민감 정보인 `Google API Key`가 public repo 에 노출되었다는 경고였는데요.
리뷰어와 논의하고 구글링을 해본 결과, 굳이 숨겨줄 필요가 없는 것으로 판단했습니다.
  - 📄 참고 문서 -> [Firebase API Key를 공개하는 것이 안전합니까?](https://haranglog.tistory.com/25)

<p align="left"><img src="https://user-images.githubusercontent.com/71127966/156119042-3dd7ccfe-f2f2-410f-b410-03a720c44906.png" width="70%"></p>

