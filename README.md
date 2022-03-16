## 🗂 프로젝트 매니저

#### 🗓️ 프로젝트 기간: 2022.02.28 - 진행중

#### Contributor
🐹 [제리](https://github.com/llghdud921)


## 프로젝트 설명

### ✔️ 구현모습
![Simulator Screen Recording - iPad Pro (12 9-inch) (5th generation) - 2022-03-17 at 01 01 05 (1)](https://user-images.githubusercontent.com/40068674/158636542-f8246f05-bb8a-440c-a623-fc4aac38f09a.gif)

[프로젝트 매니저]

✔️ 프로젝트 할일 관리 (생성, 편집, 삭제)

✔️ 할일 TODO, DOING, DONE 상태 변경 지원


## ❐ UML

![](https://i.imgur.com/V3BGscD.png)


## Step 1. 프로젝트 적용기술 선정

### 💡 1-1. keyword

- realm, FireBase, swiftLint
- Swift Package Manager

### 🤔 1-2. 기술을 적용하게 된 계기

**realm database** 

현업에서 자주 사용되는 기술로 무료에 성능이 뛰어나고 realm studio를 통해 데이터를 직접 확인할 수 있다는 장점을 가지고 있습니다.
해당 프로젝트는 대용량의 데이터를 다루지는 않아 sqlite, core data로 간단하게 구현가능하지만 현업에서 많이 활용하고 있다는 리뷰어의 조언에 따라 기술을 경험해보고 싶어 해당 기술을 선택하게 되었습니다.

**Firebase firestore**

Firebase는 database, Analytics, FCM 와 같은 여러 기능을 지원하기 때문에 서비스를 손쉽게 구축할 수 있습니다.
현업에서는 백엔드 서비스를 직접 구축하여 사용하는 경우가 많지만 스타트업이나 데이터가 처리가 적은 해당 프로젝트에는 Firebase database 서비스가 적합하다고 생각하였습니다.



## Step 2-1. 프로젝트 할일 리스트 및 MVVM 구조 설계

### 💡 2-1. keyword

- SwiftUI, MVVM

### 🤔 2-2. MVVM 구조 설계

**Model Layer**
- **TaskRepository**
    TaskEntity List 프로퍼티와 입출력을 담당하는 타입.
현재 DB 연결이 되어있지 않아 TaskEntity List는 빈 배열로 정의되어있습니다.
- **TaskEntity**
DB나 API에서 내려오는 데이터 구조에 맞추어 Parsing하게끔 정의된 타입. Task 타입과 Mapping을 위한 메소드가 구현되어있습니다.

**ViewModel Layer**

- **TaskEnvironment**
    ViewModel에서 Model 타입의 TaskRepository를 가지고있는 타입으로 두 계층을 연결하는 역할입니다.  
- **TaskViewModel**
    Task list 프로퍼티와 해당 프로퍼티 관련 로직을 수행하는 ViewModel 타입.
    @ObservableObejct를 채택하고 Task list 변경을 관찰할 수 있도록 tasks를 @Published로 선언하였습니다.
- **Task**
  View에 보여지는 프로퍼티와 관련된 로직을 수행을 위한 Property로 구성된 class 타입
    @ObservableObejct 채택하고 변경을 관찰할 프로퍼티를 @Published로 선언하였습니다.

**View Layer**  
- **MainScene**
    TaskViewModel 객체를 가지고있는 View타입
    TaskViewModel을 @EnvironmentObject 선언하여 데이터가 변경될 시에 자동으로 뷰가 업데이트되도록 구현하였습니다.

### 🤔 2-3. 고민했던 점

**View를 분리해서 정의**
- SwiftUI로 View를 구현하면서 View가 굉장히 많이 생겨서 최대한 View를 분리하면서 정의하였습니다.
- Scene은 화면을 구성하는 View들을 모아두는 기준으로 분리하였고 그 외 Scene을 구성하는 View는 Views폴더에 모아두었습니다.

**EnvironmentObject vs ObservableObject**
- View layer에 ViewModel 객체를 주입하는 과정에서 데이터의 흐름을 관리하기 쉬운 ObservableObject - ObservedObject property wrapper를 적용하였습니다.
- 하지만 View 분리하는 과정에서 ViewModel을 전달하는 코드가 너무 많아지고 ViewModel은 view 전역에서 사용하고 있어 EnvionmentObject로 적용하였습니다.
