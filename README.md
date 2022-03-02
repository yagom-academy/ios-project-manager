## iOS 커리어 스타터 캠프

# 📂 프로젝트 매니저

### 개요

- 팀원 : 나무, 숲재
- 기간 : 22/02/28 ~ 22/03/11
- 리뷰어 : 내일날씨맑음

로컬과 리모트 데이터의 동기화를 지원하는 iPad ToDo 앱

### 키워드

- `RxSwift` , `RxCocoa`
- `MVVM`, `단방향 데이터 바인딩`
- `Firebase` , `Firestore`
- `SPM`
- `UserNotification`
- `UndoManager`

## STEP 1 - ****적용기술 선정****

### 뷰 바인딩
→ RxCocoa + MVVM

### 로컬과 리모트의 데이터 동기화 및 로컬 데이터 저장 
→ Firebase(Firestore)

리모트 데이터를 업로드하기 위해 Firestore를 사용하기로 했으며, Firestore의 오프라인 저장 기능으로 로컬 저장까지 통합하여 구현하기로 했습니다.  
[오프라인으로 데이터에 액세스 | Firebase Documentation](https://firebase.google.com/docs/firestore/manage-data/enable-offline?hl=ko#configure_cache_size)

- 하위 버전 호환성에는 문제가 없는가?

    Firebase 7.4 버전에서는 ios 10부터 지원한다고 합니다. 프로젝트의 minimum target을 ios 13으로 잡았기 때문에, 문제 없다고 판단됩니다.
- 안정적으로 운용 가능한가?
    
    로컬 및 리모트 데이터 운용을 동일 프레임워크에서 담당하므로, 호환성 측면이나 예측하지 못한 에러 등에서 좀 더 자유로울 수 있다고 생각했습니다.
    
- 미래 지속가능성이 있는가?

    Google의 서비스이고, 이미 수많은 앱 개발자들이 사용하고 있는 라이브러리이므로 지속가능성 측면에서는 우려가 없다고 판단됩니다.
- 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?

    Firebase의 서버가 해외에 있기에 속도 측면에서 리스크가 있으며 일정 용량을 초과하면 유료 과금이 되지만,
자료에 영상, 이미지 등 고용량의 데이터가 들어가지 않는다는 특성 상 Firebase의 용량 제한 및 속도 이슈에서도 어느정도 자유로울 수 있다고 기대합니다.   
Firebase가 지원하는 국가에도 제한이 있습니다. 과거보다 서비스 지역이 늘어나고 있는 상황이지만, 여전히 미지원 국가가 있으므로 리스크가 될 것 같습니다. 
[프로젝트의 위치 선택 | Firebase Documentation](https://firebase.google.com/docs/projects/locations)
    
- 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
    
    Firebase는 CocoaPods, 카르타고, SPM을 모두 지원합니다. 저희는 SPM을 선택했습니다.
    
- 이 앱의 요구기능에 적절한 선택인가?
    
    로컬과 리모트의 데이터의 경합을 어떻게 처리할지에 주안점을 두었습니다. FireStore는 로컬과 리모트의 데이터 변경사항을 추적하고 처리하는데 용이한 기능을 제공합니다.
