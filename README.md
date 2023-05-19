# 프로젝트 매니저
> 해야할 일, 하고 있는 일, 완료한 일 등을 보여주는 아이패드 전용 Todo리스트 어플입니다.

---
## 목차 📋
1. [팀원 소개](#1-팀원-소개)
2. [타임 라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행화면)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [Reference](#6-Reference)
7. [팀 회고](#7-팀-회고)

---
## 1. 팀원 소개
|레옹아범|
|:--:|
|<img src="https://github.com/hyemory/ios-bank-manager/blob/step4/images/leon.jpeg?raw=true" width="150">|
| [<img src="https://i.imgur.com/IOAJpzu.png" width="22"/> Github](https://github.com/fatherLeon) |

## 2. 타임라인
    
|날짜|진행 내용|
|:--:|:--:|
|2023.5.15.(월)|기술 스택 사전조사|
|2023.5.16.(화)|기술 스택 결정 및 프로젝트 환경 설정|
|2023.5.17.(수)|Model 설계|
|2023.5.18.(목)|MainViewController UI구현|
|2023.5.19.(금)|README 작성 및 TodoViewController 구현|


</details>

## 3. 프로젝트 구조

### 1️⃣ 폴더 구조
### 2️⃣ 클래스 다이어그램

## 4. 실행화면

## 5. 트러블 슈팅

### 1️⃣ UITableView vs UICollectionView
#### 고민한 점
* UITableView와 UICollectionView 두가지 UI중 어느것을 구현할지에 대해 고민했습니다.
* iOS14이상 부터 UICollectionView가 UITableView와 같은 리스트 형태의 UI를 제공합니다.
* UITableView의 경우 iOS2.0까지 하위 버전을 커버할 수 있으며, UICollectionView에 비해 풍부한 레퍼런스가 존재합니다.

#### UICollectionView 결정 이유
* 테이블 뷰와 UI측면에서 리스트로 보여진다는 점에서 큰 차이는 없지만 UICollectionView는 UITableView에 비해 다음과 같은 이유로 구현 이점이 있습니다.

1. Section마다 서로 다른 레이아웃을 가질 수 있다.
2. `reloadData()`, `performBatchUpdates(_:completion:)`를 사용하지 않고, UI에 보여질 데이터를 변경할 수 있으며, 자연스러운 애니메이션이 발생한다.
3. 상대적으로 확장성에 대한 이점을 가진다.

* 위와 같은 이유로 UICollectionView를 통하여 리스트형태의 UI를 구현하였습니다.

## 6. Reference
[Apple - Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
[Apple - UITextField: textRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619636-textrect)
[Apple - UITextField: editingRect(forBounds:)](https://developer.apple.com/documentation/uikit/uitextfield/1619589-editingrect)
[Apple - CALayer: layer.shadowOffset](https://developer.apple.com/documentation/quartzcore/calayer/1410970-shadowoffset)
