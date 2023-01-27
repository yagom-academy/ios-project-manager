![](https://i.imgur.com/aV9BOnU.png)
 
# 목차


- [사용된 기술 스택](#---------)
- [구조](#구조)
    + [File Tree](#File-Tree)
    + [Layer 구조](#Layer-구조)
- [화면 구성 방식](#화면-구성-방식)
- [실행화면](#실행화면)
  * [경험하고 배운 것](#경험하고-배운-것)
- [고민한 점](#고민한-점)
- [해결해야할 점](#해결해야할-점)


# 사용된 기술 스택

|             목적     | 기술 이름 |
|--------------------	|---------------------------	|
| UI Framework       	| **UIKit**                 	|
| Concurrency        	| **GCD**                   	|
| Local DB           	| **Core Data**             	|
| Remote DB          	| **Firestore**             	|
| Architecture       	| **Clean Architecture + RxSwift + MVVM**        	|
| Dependency Manager 	| **Swift Package Manager** 	|

# 구조
### File Tree

```ProjectManager
├── Extension
│   ├── Date + converted.swift
│   └── UITableView + didLongPress.swift
├── Resources
│   ├── Assets.xcassets
│   ├── LaunchScreen.storyboard
│   └── Info.plist
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Presentation
│   ├── EditTask
│   │   ├── EditTaskViewModel.swift
│   │   └── EditTaskViewController.swift
│   ├── AddTask
│   │   ├── AddTaskViewModel.swift
│   │   └── AddTaskViewController.swift
│   ├── SwitchTask
│   │   ├── SwitchTaskViewModel.swift
│   │   └── SwitchTaskViewController.swift
│   ├── TaskCell.swift
│   ├── TaskItemViewModel.swift
│   ├── TaskStatusView.swift
│   ├── ProjectManagerViewController.swift
│   └── ProjectManagerViewModel.swift
├── Domain
│   ├── UseCase
│   │   ├── TaskUseCaseType.swift
│   │   └── TaskItemsUseCase.swift
│   └── Entities
│       └── Task.swift
└── Data
    ├── DataSourceType.swift
    └── MemoryDataSource.swift
```

### Layer 구조
<!-- <img src="https://i.imgur.com/cZL4Pip.png"/> -->

| 01.25.2022 프로젝트 Layer 구조 |
| -------- |
| <img src="https://i.imgur.com/Q8msGcZ.png)"/>    |


# 화면 구성 방식

| 메인 화면 화면 구성 방식 |
| -------- |
| <img src="https://i.imgur.com/cxkRVbP.png" width="400px"/>    |


| Bar Add Action | Cell LongPress Action |
| -------- | -------- |
| <img src="https://i.imgur.com/en4uABJ.png" width="200px"/>    | <img src="https://i.imgur.com/l9Qlbk3.png" width="200px"/>    |


# 실행화면
![](https://i.imgur.com/88HN9g7.gif)

## 경험하고 배운 것
- Clean Architecture를 통해 각 계층간의 관심사 분리를 하였고 이는 의존성 전이 문제를 해결해줄 수 있었고 변경에 용이한 형태로 구현할 수 있었습니다.
- MVVM을 활용하여 View의 책임을 줄이고 ViewModel을 통해 비즈니스 로직을 수행합니다. View는 다른 View가 무엇을 하는지 알아야 될 필요가 없어서 매우 편리합니다. 👍
- RxSwift를 활용해 View와 ViewModel간의 Binding을 쉽게 구현해볼 수 있었습니다.

# 고민한 점

#### Clean Architecture, MVVM 초기 적용

![](https://i.imgur.com/rKgLGT7.png) 

`🥪 서론` 프로젝트의 요구사항대로 Task가 메모리에만 저장되는 형태로 구현을 시도했습니다.

`🥪 문제` Data 레이어에 해당하는 Local DB나 RemoteDB가 존재하지 않는 상황에서 
임시적으로 ViewModel에서 저장을 하도록 구현을 하려고 했지만 객체간 의존성 문제가 발생했습니다. 

`🥪 이유` 메모리에 저장하기 위해서 다른 View가 Task를 저장하는 View의 ViewModel에 접근하여 저장하는 올바르지 않은 형태로 구현을 시도했고 Clean Architecture의 구조와 흐름을 모두 무시하고 초기 구현을 시도해 발생한 문제입니다.

`🥪 해결` 임시적으로 메모리에 저장하는 싱글턴 MemoryDataSource 객체를 구현하여 Clean Architecture흐름을 무시하지 않으면서 객체간 의존성 문제를 해결했습니다.


# 해결해야할 점
- Cell edit창 진입 이후 deselect 되지않는 점
- ~~Edit창에서 이미 expired된 date를 수정할 시 검은 텍스트로 변경되지 않는 점~~
    - prepareForReuse에서 attributedText = nil 설정하여 해결
- Cell switching view가 edit 진입 이후에만 확실하게 작동하는 점 
