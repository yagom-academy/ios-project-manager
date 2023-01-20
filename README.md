# 🗓 프로젝트 매니저

## 📖 목차
1. [소개](#-소개)
2. [파일 tree](#-파일-tree)
3. [타임라인](#-타임라인)
4. [실행 화면](#-실행-화면)
5. [고민한 점](#-고민한-점)
6. [트러블 슈팅](#-트러블-슈팅)
7. [참고 링크](#-참고-링크)

## 🌱 소개

`Mangdi`가 만든 `iPad전용 프로젝트 매니저 앱`입니다.
TODO, DOING, DONE로 각각 할일, 하고있는 일, 완료한 일 세가지 리스트로 구분되며 사용자가 직접 프로젝트(일)들을 관리할수 있습니다.
<!-- - **KeyWords**
  -  -->

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()

## 🛒 사용 기술 스택
|UI구현|아키텍처|LocalDB|RemoteDB|의존성관리도구|라이브러리
|:--:|:--:|:--:|:--:|:--:|:--:|
|UIKit|MVC|Realm|Firebase|CocoaPods|SwiftLint|

## 🧑🏻‍💻 팀원
|<img src="https://avatars.githubusercontent.com/u/49121469" width=160>|
|:--:|
|[Mangdi](https://github.com/MangDi-L)|

## 🌲 파일 tree

```
.
├── ProjectManager
│   ├── ProjectManager
│   │   ├── Controller
│   │   │   ├── CellPopoverViewController.swift
│   │   │   ├── DetailViewController.swift
│   │   │   └── MainViewController.swift
│   │   ├── Info.plist
│   │   ├── Model
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AccentColor.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   ├── CellPopoverViewDelegate.swift
│   │   │   ├── CellPopoverViewMode.swift
│   │   │   ├── DetailViewDelegate.swift
│   │   │   ├── DetailViewMode.swift
│   │   │   ├── KindOfCollectionView.swift
│   │   │   └── TodoModel.swift
│   │   ├── SupportFiles
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift
│   │   └── View
│   │       ├── Base.lproj
│   │       │   ├── LaunchScreen.storyboard
│   │       │   └── Main.storyboard
│   │       ├── DoneContentView.swift
│   │       └── TodoContentView.swift
│
└── README.md


```
 
## ⏰ 타임라인

### Step 1 타임라인
    
- **23/01/10**
    - 사용할 기술 스택 장단점 비교하며 정하기

- **23/01/11**
    - SwiftLint 적용

___

### Step 2 타임라인
    
- **23/01/12**
    - TodoContentView 구현

- **23/01/13**
    - main화면 UI 구현
    - main화면 UI StackView관련 추가구현
    - README 추가 및 수정

- **23/01/14**
    - TodoModel 생성 및 UI 수정
    -  DiffableDataSource 및 Snapshot 구현

- **23/01/15**
    - DetailViewController 생성
    - TitleTextField 그림자효과 적용
    - datePicker, bodyTextView 구현
    - Delegate패턴으로  todoCollectionView에 cell추가할수있도록 구현

- **23/01/16**
    - 각 셀을 클릭하여 수정할수있도록 구현
    - bodyTextField 글자수 1000개 제한기능 구현
    - cell을 길게눌렀을때와 뗄때 애니메이션효과 넣어서 구현

- **23/01/17**
    - cell을 길게 터치할때 popover 메뉴 보일수있도록 구현
    - popover메뉴로 셀을 다른 컬렉션뷰로 이동할수있도록 구현

- **23/01/17**
    - collectionView의 layout 새로운걸로 변경
    - collectionView의 header부분에 원치않은 높이 변경
    - UILongPressGestureRecognizer 관련 메서드 간소화
    - 중복된코드들 configureSectionHeader 메서드로 합치기
    - 각 컬렉션뷰의 셀 개수가 바뀔때마다 countLabel 갱신할 수 있도록 구현
    - cell을 swipe하여 지울수있는 기능 구현

## 📱 실행 화면

- STEP 2 실행화면

    |생성|
    |:--:|
    |![1](https://user-images.githubusercontent.com/49121469/213162906-d77695a3-47d8-40a9-9538-4c1f3b400fd1.gif)|
    |**수정**|
    |![2](https://user-images.githubusercontent.com/49121469/213162896-a3814553-4486-4ede-aab0-55fe2fdfe96c.gif)|
    |**popover 이동**|
    |![3](https://user-images.githubusercontent.com/49121469/213162869-a2c5a4d4-d46e-4d17-9291-17b717ba9954.gif)|
    |**swipe 삭제**|
    |![4](https://user-images.githubusercontent.com/49121469/213163533-be1fe0b1-e681-455d-8d6c-14a467d273cd.gif)|
    
</details>

## 👀 고민한 점

### STEP 1

- **아키텍처**
MVVM과 MVC패턴중 어느것을 사용할지 고민했습니다.  
MVC패턴은 이전에도 계속 사용해왔던 방식이라 문제가 없지만 MVVM패턴이란 개념은 처음 접해보았고 바로 적용하는것은 쉽지않아보였습니다.  
그래서 MVC패턴으로 개발하되, MVVM패턴으로 개발하면 구조가 어떻게 될거라는식의 연습을 같이 병행하겠습니다.

- **LocalDB**
CoreData와 Realm 둘중에 어느걸 사용할지 고민했습니다.
    - Realm은 CoreData와 달리 Entity에 대한 매칭을 처리해야할 필요가 없습니다.
    - CoreData는 코드로 데이터를 Read, Write하는 과정이 직관적이지 않아서 불편한점이 있지만 Realm은 직관적인 코드로 작업이 가능합니다.
    - Realm은 Cross Platform을 지원해서 안드로이드OS와 DB파일을 공유할 수 있습니다.
    - Realm은 외부 라이브러리이기때문에 초기 설치 용량(약 14MB)이 필요합니다.
    - 아래 그래프를 보면 Realm이 CoreData보다 2배 더 빠르다는것을 알 수 있습니다.
    ![초당쿼리수비교](https://i.imgur.com/t058Npy.png)
    - Realm은 iOS8 or OS X 10.9 이상이어야 지원합니다. 

    기존에 CoreData를 이용해서 플젝을 진행한 경험이 있어서 CoreData로 진행하려했는데 Realm이란것을 새롭게 알게되어 장단점들을 비교하고 Realm을 사용해보는것도 좋은 경험이 될거라 생각해서 선택하게되었습니다.

- **RemoteDB**
    - Firebase는 google에서 만들었으며, 모든 기기를 지원하는 강력한 장점이 있지만 일반적으로 iOS보단 Android쪽을 더 지원합니다.
    - iCloud는 Apple에서 만들었으며 iOS앱에 강력한 편의 기능을 지원합니다. Android지원은 어렵습니다.

    Firebase와 iCloud 둘 다 좋은 기술이고 하나를 정하기 힘들었습니다.  그래서 iOS 개발자들이 많이 쓰는걸 참고하려고 알아봤는데 Firebase를 많이 사용하는걸 확인했습니다.
![](https://i.imgur.com/PANNszz.png)


- **의존성 관리도구**
    - CocoaPods와 SPM, Carthage 셋 모두 사용하기에 부족함이 없지만 비교적 더 많은 라이브러리를 지원하는 CocoaPods로 정했습니다.


### STEP 2

- **TableView와 CollectionView중 어느것으로 구현할지에 대한 고민**
    - Todo, Doing, Dong 3가지 리스트를 어느걸로 구현할지 고민했습니다.
    - TableView와 CollectionView 둘 다 마찬가지로 요구사항들을 충분히 구현할수 있을거라 예상했습니다.
    - 다만, CollectionView가 TableView보다 다양한 Layout으로 구현가능한 점을 보아 앞으로 TableView보다 CollectionView의 사용성이 더 높을것이라 판단해서 CollectionView를 사용해서 구현했습니다.

    
## ❓ 트러블 슈팅

### STEP 1

X

### STEP 2

- **원하는 스택뷰 그리기**
UILabel2개로 스택뷰를 구성하여 아래와 같이 구성하고싶었습니다.
<img width="243" alt="스크린샷 2023-01-13 오후 3 55 21" src="https://user-images.githubusercontent.com/49121469/212256673-069cdb9c-3668-432c-8dea-5b6481512085.png">
그런데 Hugging과 Compression priority, 등등 스택뷰요소를 아무리 만져도 위 사진과 같이 구성하기가 쉽지 않았습니다.

|삽질의 기록들||
|:--:|:--:|
|<img width="242" alt="스크린샷 2023-01-13 오후 3 57 55" src="https://user-images.githubusercontent.com/49121469/212257081-18a37ec4-65e7-4494-87a3-79bb8228f1c7.png">|<img width="241" alt="스크린샷 2023-01-13 오후 4 03 59" src="https://user-images.githubusercontent.com/49121469/212258096-b0486384-4614-422b-8280-605d01a62e22.png">|

그래서 계속 어떻게 할까 고민하다가 생각해낸게 빈 view를 스택에 추가하는것이었습니다.  
잔머리를 굴린것같지만 그렇게 하면 empty 뷰에 priority를 부여해서 최종적으로 제가 원하던 스택뷰를 그릴 수 있었습니다.

- **UITextField 그림자효과 적용 이슈**
    - UITextView의 그림자적용은 잘되었지만 UITextField는 안되어서 무슨 차이점이 있나 알아보았습니다.
    - 그림자효과를 적용할 때 TextView의 경우는 clipsToBounds의 기본값이 true로 설정되어있어서 false로 바꿔주고 TextField는 기본값이 false라 바꾸어줄 필요가 없다는것을 알고있었는데 이것 말고 설정해야하는 무언가가 있는지 알아보려했는데 별다른점을 찾지 못했습니다.
    - 그렇게 계속 삽질을 하다가 우연히 background적용을 해주어야 적용이 된다는것을 발견했습니다.
    - UITextView의 backgroundColor는 기본적으로 systemBackgroundColor가 적용되었지만 UITextField는 nil이 기본값이란걸 알게되었고 추가적으로 backgroundColor를 설정해주어야 그림자가 적용된다는것도 알게되었습니다.

- **UICollectionLayoutListConfiguration의 appearance를 grouped로 설정했을때 나타나는 문제**
    UICollectionLayoutListConfiguration의 appearance를 grouped로 설정했을때 plain으로 설정했을때랑 비교되게 header부분에 35의 높이를 가진 빈 공간이 생성되는것을 발견했습니다.

    |grouped|
    |:--:|
    |<img width="774" alt="스크린샷 2023-01-20 오후 12 59 02" src="https://user-images.githubusercontent.com/49121469/213614725-56aeedfb-6ccc-4aa1-bbcf-3fc17abdb6c2.png">|
    |plain|
    |<img width="772" alt="스크린샷 2023-01-20 오후 1 00 07" src="https://user-images.githubusercontent.com/49121469/213614735-d6480a3d-1b07-4ff6-b753-7054342572b2.png">|

    이런 현상을 해결하기 위해 처음에는 contentInset을 주어서 해결하려고했지만 먼가 정식으로 해결하는것이 아닌 꼼수를 쓰는것같아서 다른 방법을 찾아보았습니다.
    [관련 이슈 StackOverFlow](https://stackoverflow.com/questions/71897527/grouped-uicollectionview-has-extra-35-pixels-of-top-padding)
    [관련 이슈 appsloveworld](https://www.appsloveworld.com/swift/100/353/uicollectionview-top-spacing)
    위의 링크를 통해서 문제를 해결할 수 있었습니다.
    요약하자면 headerMode에 supplementary를 추가하여
    ```swift
    var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
    configuration.headerMode = .supplementary
    ```
    각 컬렉션뷰의 dataSource 속 supplemtaryView의 height를 설정해주었습니다.
    ```swift
    private func configureSectionHeader() {
        let dataSources = [todoDataSource, doingDataSource, doneDataSource]

        for dataSource in dataSources {
            dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.sectionHeaderIdentifier, for: indexPath)
                    headerView.frame.size.height = 8
                    return headerView
                }
                return nil
            }
        }
    }
    ```


## 🔗 참고 링크
[Apple Developer Documentation - Displaying transient content in a popover](https://developer.apple.com/documentation/uikit/windows_and_screens/displaying_transient_content_in_a_popover)
[tistory - Date()관련](https://formestory.tistory.com/6)
[CompositionalLayout appearance를 grouped으로 설정했을때 관련 이슈 StackOverFlow](https://stackoverflow.com/questions/71897527/grouped-uicollectionview-has-extra-35-pixels-of-top-padding)
[CompositionalLayout appearance를 grouped으로 설정했을때 관련 이슈 appsloveworld](https://www.appsloveworld.com/swift/100/353/uicollectionview-top-spacing)
[Apple Developer Tutorials - cell swipe액션적용](https://developer.apple.com/tutorials/app-dev-training/adding-and-deleting-reminders)
[블로그 - LongPressGesture](http://yoonbumtae.com/?p=4418)

---

[🔝 맨 위로 이동하기](#-프로젝트-매니저)


---
