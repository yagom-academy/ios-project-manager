# 🧑‍💻 프로젝트 매니저 🧑‍💻

칸반보드를 이용하여 프로젝트의 작업들을 관리하는 앱입니다.
***개발 기간 : 2023-01-09 ~ 2023-01-27***

<br>

## 📜 목차
1. [소개](#-프로젝트-소개)
2. [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
3. [팀원](#-팀원)
4. [아키텍쳐 모식도](#-아키텍쳐-모식도)
5. [타임라인](#-타임라인)
6. [UML](#-UML)
7. [실행화면](#-실행-화면)
8. [트러블 슈팅 및 고민](#-트러블-슈팅-및-고민)
9. [참고링크](#-참고-링크)

<br>

## 💯 프로젝트 소개
일정을 까먹어서 매번 혼나셨나요?
현재 작업의 흐름이 헷갈려서 혼랍스럽지는 않으신가요?

그렇다면 이 앱을 사용해보세요!! 프로젝트 매니저!!!
당신도 일정관리의 달인이 될 수 있습니다👍

<br>

## 💻 개발환경 및 라이브러리

[![Swift](https://img.shields.io/badge/swift-5.7-orange)]() [![Xcode](https://img.shields.io/badge/Xcode-14.2-blue)]() [![RxSwift](https://img.shields.io/badge/RxSwift-6.5-green)]() [![Firebase](https://img.shields.io/badge/Firebase-9.6-red)]()

<br>

## 🧑 팀원
|Ayaan|jpush|
|:---:|:---:|
|<img src= "https://i.imgur.com/Unq1bdd.png" width ="200"/>|<img src = "https://i.imgur.com/UuIoJON.jpg" width=200 height=200>|

<br>

## ⚒️ 아키텍쳐 모식도

### ⏺ MVVM & Clean Architecture

![](https://i.imgur.com/DmsyUEh.png)
Data Layer 추가 예정

#### ✔️ MVVM
- MVVM을 이용하여 VC는 View를 그려주는 역할 및 View Model은 데이터를 이용하여 비지니스 로직을 수행하는 역할을 담당하게 했습니다.
- View Model의 비지니스 로직을 단위 테스트를 이용하여 검증할 수 있게 했습니다.
- Observable 타입을 이용해서 바인딩을 시켜 결합도가 높아지는 문제를 해결할 수 있었습니다.
#### ✔️ Clean Architecture
- 각 계층마다 관심사를 분리시키고 외부계층이 내부계층만을 의존하게 해서 외부가 변경되어도 내부가 수정될 필요가 없도록 해서 새로운 로직이 들어오거나 기존 로직이 변경되었을 때 수정이 용이하도록 했습니다.

<br>

## 🕖 타임라인

### STEP 1 - [23.01.09 ~ 23.01.10]
- 2023.01.09
    - 의존성 관리 도구 선택
- 2023.01.10
    - 아키텍쳐 선택
    - Local DB 선택
    - Remote DB 선택

### STEP 2 - [23.01.11 ~ 23.01.13]
- 2023.01.11 ~ 2023.01.12
    - 아키텍쳐 설계 (Domain Layer)
    - 아키텍쳐 설계 (Presentation Layer)
- 2023.01.13
    - UML 설계

<br>

## 📊 UML

- KanbanBoardScene
    - 작업 리스트 화면
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/mkFGviH.png"/></details>
    - 추가 화면
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/HxJcORr.png"/></details>
    - 수정화면
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/m0BcTaa.png"/></details>
    - 상세화면
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/LNezKct.png"/></details> 
    - popOver Controller
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/9cZwASK.png"/></details>
    - Model
        <details open><summary>이미지 보기</summary><img src= "https://i.imgur.com/bVERS6W.png"/></details>

<br>

## 💻 실행 화면

추후 작성 예정

<br>

## 🎯 트러블 슈팅 및 고민


### 💡 usecase의 정의에 대한 고민

![](https://i.imgur.com/47yjpI1.png)

처음에는 단순히 usecase는 비즈니스 로직이 추상화 되어 있는 것이라 생각했습니다. 
하지만 좀 더 찾아본 결과 usecase는 비즈니스 로직이 필요로 하는 엔티티를 가져다 주는 것(하나의 비지니스 로직은 하나의 유즈케이스만 사용) 인 것 같다고 생각했고 그렇다면 여러 비즈니스 로직에서 같은 엔티티가 필요하다면 하나의 유즈케이스만 사용해도 되지 않을까? 생각했습니다. 

좀 더 클린아키텍처 관점에서 생각해본 결과 Use Case는 entity라는 Enterprise Business 계층에서 사용하는 모델을 Interface Adapter 계층에서 필요한 모델로 변환시켜 비즈니스 로직을 통해 처리해서 필요한 엔티티를 가져다 주는 것으로 알게되었습니다. 비즈니스 로직을 통해서 처리하기 때문에 같은 비즈니스 로직이라도 로직을 나눠놓았다면 다르게 발전할 가능성이 있어 Frameworks 계층에서 요청한 로직당 하나의 유즈케이스를 쓰는 것이 옳다고 생각하게 되었습니다.

### 💡 Task Create, Update 로직 수행 후 List 갱신 방법에 대한 고민

추가 및 수정 로직이 완료된 후 첫번째 뷰의 TableView를 갱신할 때 클린 아키텍처를 망가뜨리지 않기 위한 고민을 했습니다.
처음에는 ViewModel간에 Delegate 패턴을 이용하여 추가 및 수정이 완료되었음을 알리는 방법을 생각했습니다. 하지만 이 방법은 UseCase가 가지고 있는 배열이 갱신되지 않아서 Delegate로 TableView UseCase의 로직을 사용해 주어야 했습니다. 
이 방법은 맞지 않다고 생각해서 TableView Use Case와 추가 및 수정 Use Case간에 Delegate 패턴을 이용하여 추가 및 수정이 완료되었음을 알리고 이를 통해 TableView Use Case의 Task List가 갱신되도록 구현했습니다.

<br>

## 📚 참고 링크

[Clean Architecture](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) 
