# 프로젝트 관리 앱

## PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/125)
- [STEP 2-1](https://github.com/yagom-academy/ios-project-manager/pull/133)
- [STEP 2-2](https://github.com/yagom-academy/ios-project-manager/pull/141)

## 외부 라이브러리

| Local DB | Remote DB | UI | Reactive | Layout |
|---|---|---|---|---|
| `Realm` | `Firebase` | `RxCocoa` | `RxSwift` | `SnapKit` |


## 의존성 관리도구

| `Swift Package Manager` |
|---|

## 구조

| `MVVM-C` | `Clean Architecture` |
|---|---|

![](https://i.imgur.com/YgUZpW8.png)

구조는 `MVVM-C` 과 `Clean Architecture`를 적용시켰으며,
때문에 Scene의 의존성을 관리하는 `DIContainer`와, 화면전환을 담당하는 `FlowCoordinator`가 가장 상위 수준에 있으며, `Presentation`, `Domain`, `Data` Layer가 있다. 

![](https://i.imgur.com/PopuMU9.png)

위 그림과 같이 `Presentation`와 `Data` Layer는 `Domain` Layer만 의존한다.

## 기능 구현

### UI

![](https://i.imgur.com/7dbq4jN.png)

### 추가 및 수정

| 추가 | 수정 |
|-|-|
|![](https://i.imgur.com/OUgGlBf.gif)|![](https://i.imgur.com/SoftF3k.gif)|
| 상단에 `UIBarButtonItem`를 클릭하면 item을 추가하기위한 View가 올라오고, Done 버튼을 클릭하면 새로운 todoitem이 생성 | Cell을 클릭후 상단에 Edit 버튼을 클릭하면, 쓰기 모드로 변경 컨텐츠를 변경후 Done 버튼을 클릭하면 todoitem이 수정 |

### 지난 게시글 처리

| 지난 게시글 날짜 표현 |
|-|
|![](https://i.imgur.com/nFSyS99.png)|
| 기한이 지난 게시글은 날짜 표현을 빨간색으로 처리하여 기한이 지난 글과 그렇지 않은 글을 구분 |
