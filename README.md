# 🗂 프로젝트관리 App ![iOS badge](https://img.shields.io/badge/Swift-F05138?style=flat&logo=Swift&logoColor=white) ![iOS badge](https://img.shields.io/badge/iPadOS-13.0%2B-blue)

> 👩🏻‍💻 2023.01.09~ 진행 중


**프로젝트를 세 개의 상태인 예정(TODO)/ 진행중(DOING)/ 완료(DONE)로 나누어 관리할 수 있습니다.**
- 프로젝트에 대한 제목, 예정 기한, 상세 내용을 등록할 수 있습니다.
- 처음 프로젝트를 등록하면 예정(TODO)리스트 에 등록됩니다.
- 등록된 프로젝트가 진행사항에 따라 TODO, DOING, DONE 리스트로 이동시킬 수 있습니다.
- 메인 화면에서 세 개의 상태에 대해 리스트로 관리 할 수 있습니다.
- 등록된 프로젝트들에 대해 상세보기/ 수정/ 삭제가 가능합니다.


## 📖 목차
1. [팀 소개](#-팀-소개)
2. [기능 소개](#-기능-소개)
3. [개발환경 및 적용기술](#-개발환경-및-적용기술)
4. [Class Diagram](#-class-diagram)
5. [폴더 구조](#-폴더-구조)
6. [프로젝트에서 경험하고 배운 것](#-프로젝트에서-경험하고-배운-것)
7. [타임라인](#-타임라인)
8. [고민한 부분](#-고민한-부분)
9. [트러블 슈팅](#-트러블-슈팅)
10. [참고 링크](#-참고-링크)

---

## 🌱 팀 소개
- 1인 개발
 
 |[써니쿠키](https://github.com/sunny-maeng)|
 |:---:|
|<img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src="https://avatars.githubusercontent.com/u/107384230?v=4">| 

---

## 📱 기능 소개

| **Main 화면** | 
| :-------------------------------------------: | 
| **세 단계로 프로젝트 관리** | 
| <img width = 500, src = "https://i.imgur.com/BjGJlLu.gif"> | 
| **삭제 혹은 진행상황에 맞게 이동** |
| <img width = 500,  src = "https://i.imgur.com/iVSI94W.gif"> |

| **등록/자세히보기/수정 화면** | 
| :-------------------------------------------: | 
| **새로운 프로젝트 등록** |
| <img width = 500, src = "https://i.imgur.com/McbxWDC.gif"> |
| **등록된 프로젝트 자세히 보기 및 내용 수정** |
| <img width = 500, src = "https://i.imgur.com/HaeWUnS.gif"> |

---

## 🛠 개발환경 및 적용기술
![iOS badge](https://img.shields.io/badge/Swift-V5.6.1-red) ![iOS badge](https://img.shields.io/badge/Xcode-V13.4.1-blue) ![iOS badge](https://img.shields.io/badge/Pod-V1.11.3-red) ![iOS badge](https://img.shields.io/badge/SwiftLint-V0.49.1-orange)

| UI | LocalDB | RemoteDB | 의존성관리도구 | 아키텍처 |
| :--------: | :--------: | :--------: |  :--------: | :--------: |
| <img height = 70, src = "https://i.imgur.com/q6rTXrE.png">     | <img height = 70, src = "https://i.imgur.com/DSnI74h.png">     | <img height = 70, src = "https://i.imgur.com/by0H2pU.png">    | <img height = 70, src = "https://i.imgur.com/fEhv9lS.png"> <img height = 70, src = "https://i.imgur.com/uIBJ8aO.png">     | <img height = 70, src = "https://i.imgur.com/ezwfWM7.png">     |
| UIKit | CoreData | Firebase| CocoaPods / SPM | MVVM |

(FireBase와, CoreData는 Step3에서 적용 예정입니다.)

---

## 👀 Class Diagram


| ![](https://i.imgur.com/uF4sTaz.jpg) |
| :-------------------------------------------: | 

- MVVM 패턴에서 위와같이 View 하나당, ViewModel 하나씩 짝지어 만들었을 때(현재 3쌍) MVC구조보다 오히려 구조가 더 복잡해졌다고 판단되서 EditingView, CellView의 ViewModel들을 MainViewModel 한 개로 사용하는 구조로 리팩토링 할 예정입니다.

---

## 🗂 폴더 구조
```
ProjectManager
├── AppDelegate
├── SceneDelegate
├── GoogleService-Info.plist
├── Info.plist
│
├── Model
│   ├── Project
│   └── ProjectState
│
├── View
│   └── MainView
│   │   ├── DataSource
│   │   ├── ListCell
│   │   ├── ListView
│   │   └── MainViewController
│   ├── EditingView
│   │   └── EditingViewController
│   ├── Custom
│   └── └── CircleLabel
│
└── ViewModel
│   ├── MainViewModel
│   ├── EditingViewModel
│   └── ListCellViewModel
│
├── Extension +
│   ├── Date +
│   ├── UIAlertController +
│   ├── UILabel +
│   ├── UIStackView +
│   ├── UITextField +
│   ├── UITextView +
│   └── UIView +
│
ProjectManagerTests
├── SampleData
├── MainViewModelTests
└── EditingViewModelTests
│
Pods
└── swiftlint
```

---

## 📝 프로젝트에서 경험하고 배운 것

- MVVM 디자인패턴
	 - [X] MVVM디자인 패턴을 공부하고 적용했습니다.
	 - [X] Closure를 이용해 ViewModel과 View를 바인딩했습니다.
- ViewModel의 UnitTest
	- [X] MVVM의 장점으로 ViewController에서 ViewModel로 분리된 로직들의 UnitTest가 가능하다는 장점을 살려, ViewModel의 UnitTest를 진행했습니다.
- modal의 formSheet, Alert의 PopoverStyle 사용
	 - [X] 등록/수정 뷰를 전체화면 중 중앙에 작게 보여주기위해 modal의 formSheet로 화면을 보여줍니다.
	 - [X] Cell의 이동 옵션을 메뉴로 보여주기 위해 Alert의 PopoverStyle을 사용했습니다.
- UIGestureRecognizer
     - [X] Cell을 길게 터치했을 때 액션을 추가하기 위해 Cell에 `UILongPressGestureRecognizer`로 Gesture를 추가했습니다. 

---

## ⏰ 타임라인

### 🕛 Step1 - (총 2일) 2023.01.09 ~ 2023.01.10
|   | 진행 내용 |
| :--------: | -------- |
| 1 | Local DB, 동기화 할 Remote DB 비교 후 사용할 DB선택 | 
| 2 | FireBase 라이브러리 추가 | 

<details>
<summary>[Details - DB 비교] </summary>

#### 📦 LocalDB 비교 (SQLite / CoreData / Realm)

|  ㅤ**SQLite**ㅤ   |  | 
| :--------: | -------- |
| about     | 오픈 소스 기반 DB로 서버가 필요없는 SQL DB <br> 모바일 로컬에서 많이 사용     | 
| 장점     | iOS/안드로이드 모두 사용가능하고, 공유도 가능  <br> Thread-Safe <br> 데이터 쿼리 작성 가능 >> 효율적인 검색 가능 <br> 매우 작고 가벼워 전체 데이터베이스를 하나의 디스크 파일에 저장가능 | 
| 단점     | 비교적 데이터 형식이 소수임 <br>  - 예) datetime 형식없음 >> 앱에서 형식처리를 해줘야함 <br> 객체가 단일체고 독립적이라 객체간 기본 동기화기능이없음 <br>   | 

 
|  **CoreData**  |  |
| :--------: | -------- |
| about   | DB아니고, Apple에서 persistence 솔루션으로 제공하는 프레임워크 <br> 기존 테이블 데이터베이스 방법과 비교해 객체에 더 중점을 둠 |
| 장점     | 객체간의 관계를 설정할 수 있음 >> 객체간 동기화 가능 <br> SQLite와 비교해서, 저장된 기록을 더 빨리 가져옴(큰 차이는 아님...) <br> IOS에서 자체 제공하기 때문에 비교적 안정적임|
| 단점     | Thread-Safe하지 않음 <br> SQLite와 비교해 많은 메모리/저장공간을 사용함 |


|  **Realm**  |  |
| :--------: | -------- |
| about     | 모바일에 최적화된 DB 라이브러리  | 
| 장점         | 데이터 용량이 커져도 일관된 속도 및 성능을 보장 <br> 기본적인 데이터 입출력인 모델, 쓰기, 읽기, 기본쿼리 등을 제공함 <br> 객체로 저장가능 (객체중심 DB)  |
| 단점         | 다중 쓰레드사용시 쓰레드별 객체 관리 필요함 (메인 쓰레드사용 <br> 쿼리가 다양하지 않음 |

	

#### 📦 RemoteDB 비교 (iCloud / DropBox / FireBase)

|  **iCloud**  |  |
| :--------: | -------- |
| 버전 호환    | iOS 8.0 이상 |
| 장점         | Apple의 여러 device에서 접근가능 |
| 단점         |  Android같은 다른 플랫폼과 통합 어려움 <br> 개발자 계정 사용해야해서 유료임 |

|  **DropBox**  |  |
| :--------: | -------- |
| 버전 호환    | iOS 13.1 이상 |
| 장점         | 동기화 안정성이 가장높음 - 속도가느려도 누락,에러없이 동기화 <br> 수정/삭제파일 복구가능 <br> 실시간 동기화에 최적이라 업로드 즉시 다른기기에서 바로 이어서 작업가능 |
| 단점         | 메모용 플랫폼으로 적합하지 않음 |

|  **Firebase**  |  |
| :--------: | -------- |
| 버전 호환    | iOS 10 이상, (Xcode 13.3.1 이상)|
| 장점         | 서버구축없이 빠른 개발 가능 <br> 5GB 까지 무료 저장가능하고 그 이상도 비교적 저렴 <br> 안드로이드와 공유가능 <br> 직관적이라 구조파악이 쉬움 |
| 단점         | 쿼리가 빈약해서 데이터검색이 어렵다 <br> 서버가 해외에있어 종종 처리속도가 느려진다. <br> IOS보단 안드로이드에 최적화되어있음 |

</details> </br> </br>

### 🕒 Step2 - (총 10일) 2023.01.11 ~ 2023.01.20
|   | 진행 내용 |
| :--------: | -------- |
| 1 | MVVM 아키텍쳐 공부 및 적용 |
| 2 | 메인 화면, 등록/수정/상세보기 View 및 기능 구현 | 
| 3 | 리뷰어 리뷰 후 리팩토링 | 

<details>
<summary>[Details - Step2 타입별 기능 설명]  </summary>

#### 1️⃣ Process 열거형 / Project 구조체
- Process (M)
	- 프로젝트의 진행과정을 나누어 TODO, DOING, DONE 세 과정으로 열거합니다.
	- 세 과정과 연관되어 배열로 관리 될 데이터에서 사용 할 `index`를 제공합니다.
- ProjectState (M)
	- 하나의 프로젝트를 나타내는 모델입니다
	- `diffableDataSource`에서 데이터의 고유성을 위해 `UUID`를 추가로 갖습니다.

#### 2️⃣ MainViewModel - MainViewController
세 개의 프로젝트 과정(TODO/ DOING/ DONE)을 리스트 세 개로 보여주고 컨트롤 합니다.
프로젝트 등록화면으로 이동하거나, 셀 선택 시 등록된 프로젝트를 자세히 보여주는 화면으로 이동할 수 있습니다
셀을 길게 누르면 셀을 다른 리스트로 옮길 수 있는 옵션메뉴를 띄어줍니다.
- MainViewController (V)
	- lists 세 개를 그리고 layout 합니다.
	- lists 세개와 DataSource 세 개는 배열로 관리됩니다.
	- MainViewModel의 `datas`가 변경 될 때마다 호출 될 `updateDatas`클로저를 바인딩해, 데이터 변경시마다 `dataSource`에 새로운 `snapshot`을 찍습니다.
- MainViewModel (VM)
	- 세 개의 리스트에 담길 데이터가 2차원 배열인 `datas`를 갖습니다.
	- 데이터를 추가/ 삭제/ 수정/ 이동/ 읽기를 담당하는 메서드들을 갖고, 이 메서드들을 사용해 `datas`배열 아이템들을 다룰 수 있습니다.
	- `datas`가 변할 때마다 `updateDatas`클로저를 호출합니다.
	- 그 외, 뷰에 보여줄 `ListTitles`배열, `datasCount`를 갖습니다.

#### 3️⃣ ListCellViewModel - ListCell
리스트의 각 Cell을 컨트롤합니다.
- ListCell (V)
	- 제목 / 목표날짜 / 상세내용요약 을 나타낼 View를 그리고 layout합니다.
	- `ListCellViewModel`의 제목데이터, 날짜데이터, 내용데이터가 변경될 때마다 호출 될 클로저들을 바인딩해, 데이터 변경시마다 `label`로 보여주는 Text를 변경합니다.
	- 길게 터치 시, 액션을 추가하기 위해 UILongPressGestureRecognizer가 추가되어있습니다.
- ListCellViewModel (VM)
	- `title` / `date` / `description` 을 String 타입으로 갖습니다.
	- 목표날짜를 오늘과 비교해 기한이 지났는지 확인합니다.(`isMissDeadLine`)
	- cell의 내용을 구성합니다(`setupCell`)

#### 4️⃣ EditingViewModel - EditingViewController
리스트에 새로운 프로젝트를 추가하는 뷰/ 추가 되어있던 프로젝트를 자세히 보고, 수정할 수 있는 뷰를 컨트롤합니다.
- EditingViewController (V)
	- Editable모드/ ReadOnly모드가 있습니다.
	- 제목, 상세내용, 목표날짜를 작성(수정)할 수 있는 View를 그리고 layout합니다.
	- `EditingViewModel`의 제목데이터, 날짜데이터, 내용데이터가 변경될 때 호출되는 클로저들을 바인딩해, 데이터를 보여줍니다.
	- Editable모드시 취소, 등록 버튼을 보여주고, ReadOnly모드일 때는 수정, 등록 버튼을 보여줍니다. 
- EditingViewModel (V)
	- Editable모드/ ReadOnly모드구분하고 `title` / `date` / `description` 을 String 타입으로 갖습니다.
	- 새로운 프로젝트라면 새로운 데이터를 추가하고, 기존 프로젝트라면 해당 데이터를 수정합니다. 이 때, `MainViewModel`의 `datas`를 변경해줍니다.
	
</details> </br> </br>
	
---

## 💭 고민한 부분

### 1️⃣ Local DB, Remote DB 선택 고려사항
- **1. 하위 버전 호환성에 문제 없는가?**
	- CoreData는 IOS 3.0, FireBase는 IOS 10.0 이상에서 사용이 가능합니다. 프로젝트 타겟 버전은 13이상으로 호환성 문제는 없다고 판단했습니다.

- **2. 안정적으로 운용 가능한가?**
	- CoreData는 애플제품에 맞게 애플에서 제공해주는 프레임워크이기 때문에 안정적 운용에 관해서는 IOS에는 최적이라 생각하고, Firebase는 구글에서 제공하고있는 프레임워크인데, 전세계 수백만개 회사에서도 신뢰하는 서비스이기 떄문에 안정적으로 운용이 가능할거라 판단했습니다.

- **3. 미래 지속가능성이 있는가?**
	- 미래를 예측하는것엔 확답이 불가능하지만, CoreData는 데이터모델 변화에도 마이그레이션 기능으로 확장이 가능하고, 애플은 보안에 강력하기 때문에 지속가능할거라 예상했습니다. FireData도 앱의 규모확장에 대응가능하고, 강력한 사용자 기반 보안을 사용하고있으므로 무탈하게 지속가능하다고 생각했습니다.

- **4. 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?**
	- CoreData의 리스크로는 Thread-safe하지 않다는 점이 있는데, 모든 백그라운드 업데이트가 하나의 스레드에서, 동일한 컨텍스트에서 수행되게 할 수 있습니다. 또한 CoreData사용으로 앱속도를 저하될 수 있는데, 쿼리사용과 특정시점에 필요한 데이터를 파악해 알맞게 가져오도록 해서 성능을 최적화하며 사용할 수 있습니다. 

- **5. 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**
	- CocoaPods과 SPM을 사용할 예정입니다.
(Realm은 선택 가능 목록에 없어서 대상에서 제외했습니다)

### 2️⃣ 리스트 세 개를 그리는 방법 (`UICollectionView`/ `UITableView`)

제일 처음 View를 구상할 때 어떤 방법으로 리스트를 그릴 지 고민했습니다
- **1. `UICollectionViewCompositionalLayout.list`를 `Section` 3개로 만들기**
	- `CollectionView` 에서 지원해주는 List형태를 이용해 한 개의 `CollectionView`에서 `Section`을 .todo/ .doing / .done 으로 구분해 리스트들을 그리려 했습니다.
	- `Section`으로 구분 시 각 `Section` 별 리스트들을 수평으로 그리지 못하고, 수직으로만 쌓아 그릴 수 있어서 적용하지 못했습니다. 

- **2. `UICollectionView` 를 `compositionalLayout`으로 List형태 만들기**
	- 하나의 `CollectionView`안에 `Section`으로 구분해 수평으로 쌓이는 리스트를 만들기 위해 `UICollectionView`를 `compositionalLayout`으로 옆으로 쌓이는 List형태로 만드는 방법도 고민했었습니다.
	- 이렇게 만들 시, Cell `SwipeAction`을 지원해주지 않기 때문에 별도로 구현해줘야하기 떄문에 보류했습니다.
- **3. `UITableView` 3개로 그리기 `UICollectionViewCompositionalLayout.list` 3개로 그리기**
	- Section으로 구분이 안되니 같은 리스트를 똑같이 세번씩 그려줘야 하는데, `UICollectionViewCompositionalLayout.list`를 세 개 그릴지, `UITableView`를 세 개 그릴지 고민했습니다.
	- `UICollectionViewCompositionalLayout.list`는 Cell Custom이 어려운 단점이 있고, 프로젝트 요구사항에도 cell사이에 간격이 있는것을 보고 Custom이 필요한 것 같아 Cell Custom이 더 쉬운 `UITableView`를 선택했습니다.

### 3️⃣ MVVM의 장점은 무엇인가? ➡️ UnitTest ?
MVVM 디자인패턴을 처음 공부해보고 접목해보면서 장점이 무엇인가에 대한 생각을 많이 했습니다. 

공부할 때는, MVVM의 장점으로 `ViewController`의 로직이 뷰모델로 분리되기 때문에 `UnitTest`를 더 쉽게 할수있다는 것과, 방대해지는 `ViewController`의 일을 분담시킬 수 있다는 점이 있었습니다.

확실히 ViewModel로 분리된 로직들은 쉽게 `UnitTest`할 수 있었습니다. 다만, 현재(Step2)까지는 ViewController-ViewModel 를 한 쌍씩 만듣면서 구조가 MVC보다 더 복잡해고, 리뷰어와 상의 후 ViewModel을 하나로 사용하는 방향으로 리팩토링해보고 MVVM의 장점을 다시 생각해 볼 수 있을 것 같습니다.

---

## 🚀 트러블 슈팅

### 1️⃣ TableView Cell 간격
- 아래 첨부한 요구사항 예시 화면같이, 리스트의 `Cell`사이에 `Spacing`을 만들어 줘야했습니다. 처음엔 Cell하나를 하나의 `Section`으로 만들어 `footerView`를 공백으로 추가해 Cell간 Spacing을 구현했었습니다. 뷰만 보았을 때는 요구사항의 상황과 완벽하게 똑같았습니다.
- 문제는 `TableView`에 `DiffableDataSource`를 사용하면서 나타났습니다. Cell하나를 `Section` 하나로 취급하기위해서 Section의 타입을 `Int`로 하고 프로젝트가 담긴 배열의 갯수(`projects.count`)만큼 섹션을 생성하도록 했었습니다 `(1,2,3,4,5...)` 하지만, 예들들어 5개 Section이 있을 때, 3번 셀을 삭제하고 다시 `snapShot`을 찍으면,3이 삭제되고 뒤에 4,5 Section이 빈 3번 자리로 당겨지는게 아니라 Section은 `(1,2, ,4,5)`로 5까지 이름이 있지만, 실제 셀 갯수는 4개가 되어 `Index`관리가 어려워지는 문제가 있었습니다.
 
- **✅ 수정: Cell 레이아웃을 Cell Spacing처럼 만들었습니다**
	- Cell 내부에 담기는 StackView를 Cell의 컨텐츠 사방에 Layout제약을 줄 때, 조금 간격을 주고, Cell의 배경색을 TableView의 배경색으로 만들어 마치 간격인 것 처럼 보이게 수정했습니다. 
	- 이렇게 하면 한 개의 Section에서 row로 프로젝트들을 관리할 수 있게되고, DiffableDataSource 사용에 있어서도 훨씬 편리했습니다. 다만 아래 사진처럼 CellSwipeAction시에는 실제 Cell의 크기가 나타나는 점이 남아있습니다.    
  &nbsp;
    <table>
      <tr>
    	 <td colspan="3"> <strong>요구사항 예시화면의 Cell 간격</strong> </td>
      </tr>
      <tr>
        <td>&nbsp;&nbsp;<img width = 300, src = "https://i.imgur.com/Mua53fH.png">&nbsp;&nbsp;</td>
    	  <td
        <td>&nbsp;&nbsp;<img width = 300, src = "https://i.imgur.com/4sDnZ4D.png">&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </table>

    <table>
      <tr>
    	 <td colspan="3"> <strong>레이아웃으로 Cell 간격처럼 보이도록 만든 구성</strong> </td>
      </tr>
      <tr>
        <td>&nbsp;&nbsp;<img width = 300, src = "https://i.imgur.com/4ymMiD7.png">&nbsp;&nbsp;</td>
    	  <td
        <td>&nbsp;&nbsp;<img width = 300, src = "https://i.imgur.com/aT53pOQ.png">&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </table>


## 🔗 참고 링크

[공식문서]
- [developer-UIModalPresentationStyle.formSheet](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/formsheet)
- [developer-UILongPressGestureRecognizer](https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer)
- [HIG-Popovers](https://developer.apple.com/design/human-interface-guidelines/components/presentation/popovers/)
- [developer(Article)-Displaying transient content in a popover](https://developer.apple.com/documentation/uikit/windows_and_screens/displaying_transient_content_in_a_popover)
- [developer-UIAlertController.Style.actionSheet](https://developer.apple.com/documentation/uikit/uialertcontroller/style/actionsheet)
- [developer-DatePicker](https://developer.apple.com/documentation/swiftui/datepicker)

[공식문서 외]
- [Firebase 문서 Apple 플랫폼용 Firebase](https://firebase.google.com/docs/ios/installation-methods?authuser=0&hl=ko#cocoapods)
- [Github-protocorn93/iOS-Architecture - MVVM](https://github.com/protocorn93/iOS-Architecture)
- [Kodeco-MVVM](https://www.kodeco.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc)
