# 🗒프로젝트 관리 앱(To Do List)
> 프로젝트 기간 2022-07-04 ~ 2022-07-15

팀원 : [두기](https://github.com/doogie97)
리뷰어 : [TTOzzi](https://github.com/TTOzzi)

## 실행화면
![](https://i.imgur.com/URI5yiS.gif)

## 기능 구현
- Rx를 이용해 데이터 화면에 표시

## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.2-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.6-skyblue)]()
- [![xcode](https://img.shields.io/badge/SwiftLint-red)]()

## Trouble Shooting
### 1. 뷰컨트롤러에 구성 vs 뷰 생성후 뷰컨트롤러에서 사용
mvvm 패턴을 구현함에 있어 viewcontroller도 뷰의 역할을 하도록 하려고 했는데 지금 
`MainView`처럼 뷰컨트롤러에서 뷰구성을 다 하는게 좋을지 
아니면 `DetailView`처럼 뷰를 만들고 그 뷰를 뷰컨트롤러에서 가져와 쓰면서 추가적으로 구성을 해야하는 경우가 있다면 그럴때만 뷰컨트롤러에서 만들면 좋을지
(ex mainviewcontroller의 navigationBar에 접근하기 위해서는 view에서 접근을 못하니 어쩔 수 없이 뷰컨트롤러에서 추가해줘야함) 

이 부분을 가장 고민을 많이 했는데 아직 어떤게 더 좋을 지 기준이 서지 않아 해결 필요

### 2. 뷰의 입체성(?)
|내가 구성한 뷰|요구서의 뷰|
|:-:|:-:|
|![image](https://user-images.githubusercontent.com/82325822/177760552-1793f8f0-2445-429c-83f0-3a0648ab83f4.png)|![image](https://user-images.githubusercontent.com/82325822/177760740-5f5709c8-8d5e-43e7-b86c-d232860c2a17.png)|

위 뷰 요소들을 스토리보드에서 옵션 하나하나 살펴봐도 이렇게 입체성을 나타내는 옵션을 찾지 못했으며 이 부분도 해결 필요 

## 배운 개념
- RxSwift
- MVVM

## 커밋 룰
Commit message
커밋 제목은 최대 50자 입력

💎feat : 새로운 기능 구현

✏️chore : 사소한 코드 수정, 내부 파일 수정, 파일 이동 등

🔨fix : 버그, 오류 해결

📝docs : README나 WIKI 등의 문서 개정

♻️refactor : 수정이 있을 때 사용 (이름변경, 코드 스타일 변경 등)

⚰️del : 쓸모없는 코드 삭제

🔬test : 테스트 코드 수정

📱storyboard : 스토리 보드를 수정 했을 때
