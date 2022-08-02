
# 💻 프로젝트 매니저
> 프로젝트 기간 2022-07-18 ~ 2022-07-29  

- [소개](#소개)
- [팀원](#팀원)
- [리뷰어](#리뷰어)
- [타임라인](#타임라인)
- [UML](#UML)
- [실행화면](#실행-화면)
- [PR](#PR)
- [트러블 슈팅](#트러블-슈팅)
    - [1️⃣ 날짜나 이미지 데이터 저장 방식]
    - [2️⃣ 백업용으로만 사용되는 NetworkRepository, MockHistoryRepository의 위치나 방식]
    - [3️⃣ 서버와 로컬의 데이터 동기화를 자동으로 vs 수동으로]
    - [4️⃣ alertController에서 title의 색상]
    - [5️⃣ 코어 데이터와 네트워크에서의 DTO 타입]
    - [6️⃣ 키보드 나오면 modal 화면 살짝 올라가게 하는 법]
    - [7️⃣ Modal View Presentation]
    - [8️⃣ SceneDIContainer]
    - [9️⃣ 데이터 저장 및 백업 정책]
- [트러블슈팅](#트러블_슈팅)


## 소개
프로젝트를 진행 상황을 todo list형태로 정리하고, 계획하는 아이패드 앱

## 팀원

|[mmim](https://github.com/JoSH0318)|[Tiana](https://github.com/Kim-TaeHyun-A) |
|:---:|:---:|
|<img src="https://i.imgur.com/GUrxJqu.jpg" height="240">|<img src="https://i.imgur.com/BSxMgfj.png" width="240"> |

## 리뷰어
[내일날씨맑음](https://github.com/SungPyo)


## 타임라인
|일시|내용 |
|:---:|:---:|
|2022.07.04(월)|STEP1 - 프로젝트 기술 스택 선정 및 기획 수립|
|2022.07.05(화)|STEP2 - UI 구현|
|2022.07.06(수)|STEP2 - Main, Detail 화면 기능 구현|
|2022.07.07(목)|STEP2 - 설계 구조 변경으로 인한 리팩토링|
|2022.07.08(금)|STEP2 - RxDataSource 적용 및 부가 기능 구현|
|2022.07.11(월)|STEP2 - Modal(Detail) 화면 및 기능 구현|
|2022.07.12(화)|STEP2 - Modal 화면 키보드 및 레이아웃 관련리팩토링|
|2022.07.13(수)|STEP2 - Project 이동 및 삭제 기능 구현|
|2022.07.14(목)|STEP2 - PR|
|2022.07.15(금)|STEP2 - README 업데이트 및 리팩토링|
|2022.07.18(월)|STEP3 - Local / Remote 관련 정책 수립|
|2022.07.19(화)|STEP3 - Local(core data) 관련 기능 및 계층 구현|
|2022.07.20(수)|STEP3 - fire base 관련 개인 학습|
|2022.07.21(목)|STEP3 - Remote(fire base) 관련 기능 및 계층 구현|
|2022.07.22(금)|STEP3 - Local, Remote 오류 수정 및 리팩토링|
|2022.07.25(월)|STEP3 - History 관련 기능 및 계층 구현|
|2022.07.26(화)|STEP3 - Local, Remote, History 관련 리팩토링|
|2022.07.27(수)|STEP3 - DIContainer 적용으로 인한 리팩토링 및 PR|
|2022.07.28(목)|STEP3 - 리뷰 이후 전면 리팩토링|
|2022.07.29(금)|STEP3 - README 업데이트 및 UnitTest|

# UML
![](https://i.imgur.com/gLUlPR5.png)

## 실행 화면
|Main / 상세 / 기록 화면|Project 등록|
|:---:|:---:|
|![](https://i.imgur.com/3oqsfxK.gif)|![](https://i.imgur.com/d6SMteN.gif)|
|Project 이동|Project 삭제|
|![](https://i.imgur.com/jezuVAT.gif)|![](https://i.imgur.com/ovXY5mv.gif)|
|Project 수정|Project 기록|
|![](https://i.imgur.com/SlHxVy0.gif)|![](https://i.imgur.com/25YExqU.gif)|
|network 동기화 기능||
|![](https://i.imgur.com/CC3nX3y.gif)||
|network condition check|
|<img width="400" src="https://i.imgur.com/APfkcpI.png"/>|

## PR 바로가기
[STEP3 PR](https://github.com/yagom-academy/ios-project-manager/pull/163)

---

## 트러블 슈팅
1️⃣ **날짜나 이미지 데이터 저장 방식**
CoreData 에서는 Date 타입, firebase realtime database에서는 String의 형태(timeintervalsince1970을 String으로 바꾼 것입니다.)로 저장한다.

2️⃣ **백업용으로만 사용되는 NetworkRepository, MockHistoryRepository의 위치나 방식**
기기에서 최초로 앱을 실행시키지 않는다면, 코어 데이터는 항상 remote 데이터보다 최신 데이터를 가진다. 기존 코드를 최대한 수정하지 않으면서 backup 기능을 구현하고 싶은 생각에 usecase에  backkup 메서드를 구현했다.
MockHistoryRepostory는 앱이 실행 중에만 변경사항이 기록한다. 지금은 수정이 필요 없어서 RC만 구현했다.
NetworkRepository가 ProjectRepository에 의존한다. 프로퍼티로 가지는 것보다는 매개변수로 의존하도록 구현했다.(synchronize 메서드)

3️⃣ **서버와 로컬의 데이터 동기화를 자동으로 vs 수동으로**
모든 동기화 작업을 자동으로 했을 경우 사용자가 흐름을 제대로 이해하지 못하면 의도한 방향으로 사용하지 못해서 UX가 좋지 못할 것이다. remote로 backup하는 것은 자동으로 하도록, remote data를 가지고 오는 것은 local data(최신 데이터)를 remote data(예전 데이터)로 덮어 쓸 위험이 있어서 수동으로 하도록 했다.

4️⃣ **alertController에서 title의 색상**
view hierarchy를 살펴보면 setValue로 설정한 색상이 들어간 것 같지만 시뮬레이터에서는 항상 회색으로 글자색이 표기된다. AlertController의 한계로 보이므로 custom으로 ViewController로 alertController를 만들어야 한다.

```swift
private func setUp(alertTitle: String, confirmButton: UIAlertAction?) {
        let cancelButton = UIAlertAction(title: "취소", style: .default)
        
        if let confirmButton = confirmButton {
            addAction(confirmButton)
        }
        addAction(cancelButton)
        
        setValue(
            NSAttributedString(
                string: alertTitle,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 20),
                    .foregroundColor: UIColor.black,
                ]
            ), forKey: "attributedTitle"
        )
}
```

<img src="https://i.imgur.com/9tbWfAD.png" height="200">   
<img src="https://i.imgur.com/QLqAeEA.png" height="200">  
<img src="https://i.imgur.com/vvQoq03.png" height="200">  



5️⃣ **코어 데이터와 네트워크에서의 DTO 타입**
코어 데이터와 네트워크에서 데이터를 제어할 때 같은 타입인 ProjectDTO를 사용한다. 그러다보니 네트워크 구현과정에서 기존 타입을 수정하게 됐다.

ex. date 형식으로 firebase에 저장할 수 없어서 String으로 변환한 timeInterval 값을 저장하기 위해 deadline 타입이 String이 됐고 PersistentManager에서 데이터를 가져오는 부분에서 데이터 포매팅 수정이 필요했다.

유연한 대응을 위해서는 다른 모델을 사용하지만 최종적으로는 하나의 모델을 사용하는 것이 적절한 것으로 보인다.

6️⃣ **키보드 나오면 modal 화면 살짝 올라가게 하는 법**
RegistrationViewController는 RegistrationViewController의 view에 modalView를 addSubview하는 방법으로 화면을 띄운다.
```swift
final class RegistrationViewController {
    private let modalView = ModalView()
    
    override func viewDidLoad() {
        self.view.addSubview(modalView)
    }
}
```
기존에는 `self.view = modalView`로 해주어서 키보드가 올라가면 modalView도 같이 올라갔다.  
<img width="400" src="https://i.imgur.com/MTQRiDK.jpg"/>  

하지만 현재의 방법으로 키보드가 올라가면 modalView는 올라가지 않는다.  
<img width="400" src="https://i.imgur.com/XSSRD2n.jpg"/>  

그래서 modalView의 TopAnchor를 설정해서 올려주려고 했지만 기기별로 사이즈가 다르기 때문에 불가능했다.
또한, centerYAnchor에서 constant를 주어서 올려주게 되면 이것 또한 기기별로 사이즈가 달라 올려주어야하는 constant 값을 예측하기 힘들었다.

#### 해결
```swift
protocol ModalDelegate: AnyObject {
    func changeModalViewTopConstant(to constant: Double)
}

extension RegistrationViewController: ModalDelegate {
    func changeModalViewTopConstant(to constant: Double) {
        topConstraint?.constant = constant
        view.layoutIfNeeded()
    }
}

final class RegistrationViewController {
    private var topConstraint: NSLayoutConstraint?

    ...
    
    private func setUpLayout() {
        view.addSubview(modalView)
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = modalView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: modalView.defaultTopConstant
        )
        
        NSLayoutConstraint.activate([
            modalView.widthAnchor.constraint(equalToConstant: ModalConstant.modalFrameWidth),
            modalView.heightAnchor.constraint(equalToConstant: ModalConstant.modalFrameHeight),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topConstraint
        ].compactMap { $0 })
    }
    ...
}

final class ModalView: UIView {
    ...
    let defaultTopConstant = (UIScreen.main.bounds.height - ModalConstant.modalFrameHeight) / 2
    weak var delegate: ModalDelegate?
    
    ...
    
    private func adjustConstraint(by keyboardHeight: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardHeight,
            right: 0
        )
    }
    ...
    
    func registerNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
        
        guard let keyboardSize = (keyboardInfo as? NSValue)?.cgRectValue else {
            return
        }
        
        if titleTextField.isFirstResponder == true {
            delegate?.changeModalViewTopConstant(to: ModalConstant.minTopConstant)
        }
        
        if bodyTextView.isFirstResponder == true {
            adjustConstraint(by: keyboardSize.height - 2 * defaultTopConstant + ModalConstant.minTopConstant)
            delegate?.changeModalViewTopConstant(to: ModalConstant.minTopConstant)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        adjustConstraint(by: .zero)
        delegate?.changeModalViewTopConstant(to: defaultTopConstant)
    }
}
```
7️⃣ **Modal View Presentation**
Swift에서 지원하는 Modal Present Style을 formSheet로 설정해준다면 손쉽게 우리가 원하는 ModalView를 구현할 수 있다. 
하지만 많은 제약 사항이 생긴다. 대표적으로 layout과 관련된 제약이 크다. 아래와 같이 의도치 않은 `UIRoundedRectShadowView`와 같은 background view가 생기는 것을 볼 수 있다.  
<img width="400" src="https://i.imgur.com/q2W0U3F.jpg"/><img width="200" src="https://i.imgur.com/r59lrTr.jpg"/>  

이러한 의도치 않은 view로 인해 keyboard event같은 이유로 modal view의 layout을 재설정해줘야 할 때 불편함을 겪는다.

#### 해결
Modal Present Style을 overCurrentContext 설정하고 Modal View의 frame을 우리가 원하는 크기와 위치로 설정해주었다. 
이전에 사용하던 NavigationBar의 frame은 정해줄 수 없기 때문에 UIView를 NavigationBar처럼 커스텀하는 방법으로 Modal을 구현했다.

8️⃣ **SceneDIContainer**
앱 전역에서 동일한 repository에 의존해야 한다. 기존 코드에서는 싱글톤으로 각 repository 타입을 구현하고 usecase가 viewModel에서 매번 새로 생성됐다. UML에 명시된 의존도와 데이터 flow에 적합하게 DIContainer 클래스인 SceneDIContainer 구현했다. SceneDelegate에서 주입하므로서 앱 전역에서 동일한 인스턴스에 접근할 수 있고, 반복적인 usecase 인스턴스 생성과 같은 불필요한 작업을 제거했다.

9️⃣ **데이터 저장 및 백업 정책**
사용자 입장에서 remote에 어떠한 방식으로 저장되는 것이 사용자 경험상 좋은지에 대해서 고민을 했다.
local과 remote 저장소를 동시에 사용하고 있기 때문에 각자의 역할을 정했다.
1. local은 데이터가 CRUD되는 시점에 저장
2. remote는 app이 종료되거나 backgrond로 나간가는 시점에 데이터를 저장
3. app이 UI에 보여주는 데이터는 local의 저장된 데이터를 불러옴
4. remote의 데이터를 local의 데이터에 적용시키는 시점은 수동으로(버튼을 이용)

처음에는 아래와 같은 백업 정책을 설정했다.  
<img width="500" src="https://i.imgur.com/KqdBd4c.png"/>  

Network Process 부분은 조건에 따라 firebase에 create, update, delete를 판단하는 과정이다.
하지만 image와 같은 큰 용량의 데이터를 firebase 저장하는 것이 아닌
단순히 text를 저장하기 때문에 위와 같은 process를 거치는 것이 효율적인지를 의논했다.

결국은 기존 데이터를 전부 삭제하고 현재 데이터를 모두 create하는 방법으로 적용하는 것으로 데이터 저장 및 백업 정책을 설정했다.

하지만 이러한 선택에는 명확한 단점이 있다. 앱 최초 실행이 아닌 이상 모두 삭제 후 재배치하는 것은 자원의 소모가 크다.
이후 서버에 저장할 데이터가 많아지고 그 크기가 크다면 이러한 정책은 바뀌어야 한다. 
