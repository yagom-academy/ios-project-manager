# 프로젝트 매니저

<br>

## STEP 1 프로젝트 할일 리스트 


<br>
<br>

### 기능구현


<br>
<br>

### 타임라인

#### 06.28~07.03
- [팀그라운드룰 작성](https://github.com/SoKoooool/ios-project-manager/blob/main/Docs/%ED%8C%80%EA%B7%B8%EB%9D%BC%EC%9A%B4%EB%93%9C%EB%A3%B0.md)
- `UITableView`의 `Drag and Drop` 기능 공식문서 공부
- drag and drop 문서만 3일
#### 07.04~07.11
- UIDatePicker
- VC 데이터전달
- StackView
- TextField
- TextView
- UIBarButtonItem
- UITableView swipe Delete
- drag and drop
#### 07.12~07.16
- deleteRows()
- insertRows()
- editMode

<br>
<br>

### 트러블슈팅 (Troubleshooting)
1. delegate패턴 사용시 delegate위임 꼭 해주기
2. tableView에서 cell사이에 간격을 줄 수 없었다. 
   - Section에 빈 headerView를 추가하여 변경하였다.
3. cell을 추가할 때 data의 Array의 Index값을 indexPath.row로 주었더니 계속 동일한 element가 호출되었다. 
   - data Array의 index값을 indexPath.section으로 변경하여 해결
4. stackView 내에 존재하는 contents들의 layout을 직접 지정해주었더니 경고메세지발생 
   - contents들의 layout을 잡아줄 때는 위치는 변경하지않고 크기만 조절해줘야한다.
5. cell 사이에 간격을 주기 위해 section을 사용하였는데, drag and drop을 구현함에 있어서 row관련 메서드가 많아서 난황을 겪고 있음 
   - 일단 section보다는 row로 해보는 방향으로!!
    
<br>
<br>

### 참고 링크

<details>
<summary>참고 링크 세부사항</summary>
<div markdown="1">


공식문서
- [Supporting Drag and Drop in Table Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/supporting_drag_and_drop_in_table_views)
- [Adopting Drag and Drop in a Table View](https://developer.apple.com/documentation/uikit/drag_and_drop/adopting_drag_and_drop_in_a_table_view)
- [DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)
- [tableView(_:editingStyleForRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614869-tableview?changes=_9)
- [Pickers](https://developer.apple.com/design/human-interface-guidelines/ios/controls/pickers/)
- [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
- [Scheduling a Notification Locally from Your App](https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app)
- [Handling Notifications and Notification-Related Actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)
- [UndoManager](https://developer.apple.com/documentation/foundation/undomanager)
   
Drag and Drop
- [[WWDC] Drag and Drop 2017](https://developer.apple.com/videos/play/wwdc2017/223/)
- [[WWDC] Mastering Drag and Drop](https://developer.apple.com/videos/play/wwdc2017/213/)
- [[블로그] iPadOS ) Drag and Drop (1) - Zedd](https://zeddios.tistory.com/1024)
- [[GitHub] StanfordLectureMemo_11~12.md](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_11~12.md#lecture-11-1)
- [[유투브] Stanford - Developing iOS 11 Apps with Swift - 11. Drag and Drop, Table View, and Collection View](https://www.youtube.com/watch?v=noowieVV8nA)
- [[raywenderlich] Drag and Drop](https://www.raywenderlich.com/3121851-drag-and-drop-tutorial-for-ios)
- [Swift Talk - ](https://talk.objc.io/)
- [[블로그] Drag and Drop Issue - panther](https://velog.io/@panther222128/Drag-and-Drop-Issue)
- [[블로그] Creating a NSItemProvider for custom model class (Drag & Drop API) - Osama Naeem](https://exploringswift.com/blog/creating-a-nsitemprovider-for-custom-model-class-drag-drop-api)

스토리보드 없이 코드로 짜기
- [[블로그, iOS - swift] init(frame:), required init?(coder aDecoder: NSCoder), prepareForInterfaceBuilder(), awakeFromNib() 초기화의 정체 - jakekim](https://ios-development.tistory.com/222)
- [[블로그] [iOS][Swift] - 스토리보드 없이 코드로만 UI 구현하기 - 엘림](https://velog.io/@lina0322/iOSSwift-%EC%8A%A4%ED%86%A0%EB%A6%AC%EB%B3%B4%EB%93%9C-%EC%97%86%EC%9D%B4-%EC%BD%94%EB%93%9C%EB%A1%9C%EB%A7%8C-UI-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-SceneDelegate%EC%97%90%EC%84%9C-window%EC%84%A4%EC%A0%95)
  
VC 데이터 전달
- [[블로그] [iOS] View Controller들 사이에서 Data 주고받는 6가지 방법 - sweetdev](https://sweetdev.tistory.com/110)
- [[블로그] iOS UITableView, reloadData 개요 및 참고사항 - MungGu](https://0urtrees.tistory.com/159)
- [iOS ) Delegate를 이용한 ViewController간 Data전달방법](https://zeddios.tistory.com/310)
  
DatePicker
- [[블로그] UIKit - Date Picker 사용하기, iOS 14 변경사항 정리 - Kas](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/#datepicker-style)
- [[블로그] UIKit - Calendar 와 Date 기초 익히기 - Kas](https://kasroid.github.io/posts/ios/20201026-uikit-handling-date/)
- [[블로그] [iOS UIKit in Swift 4] UIDatePicker 사용하기 - 콤씨](https://calmone.tistory.com/entry/iOS-UIKit-in-Swift-4-UIDatePicker-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)

Navigation bar
- [[블로그] iOS ) Navigation bar Title 변경방법 - Zedd](https://zeddios.tistory.com/181)

UIToolbar
- [[블로그] UIToolbar Align items Programmatically - 삼쓰](https://woongsios.tistory.com/44)
  
UITextField
- [[블로그] iOS ) Navigation bar Title 변경방법 - Zedd](https://zeddios.tistory.com/181)
  
UIModalPresentation
- [[developer.apple] UIModalPresentationStyle.formSheet](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/formsheet)
- [[블로그] UIModalPresentationStyle - 기린](https://giraff-ios.tistory.com/5)

StackView
- [[블로그] iOS - StackView(기본) - brody](https://brody.tistory.com/115)
  
UIBarButton
- [[블로그] [iOS UIKit in Swift 4] UIBarButtonItem 사용하기 - 콤씨](https://calmone.tistory.com/entry/iOS-UIKit-in-Swift-4-UIBarButtonItem-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)
- [[블로그] iOS Swift View, Button 그림자 넣기 - GonsiOS](https://gonslab.tistory.com/23)

TableViewCell Swipe Delete 
- [[블로그] iOS Swift 테이블뷰 스와이프 삭제 (TableView swipe delete) - GonsiOS](https://gonslab.tistory.com/43)


</div>
</details>
