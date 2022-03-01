# 💾 프로젝트 관리 앱 저장소
현재 진행 중이거나, 계획하고 있는 프로젝트(Todo / Doing / Done으로 구성)를 관리할 수 있는 프로젝트입니다. 

## 🛠 사용한 기술 스택
|UI 및 비동기 처리|코딩 컨벤션|데이터베이스|
|--|--|--|
|RxSwift / RxCocoa|SwiftLint|Firebase|

### ✅ 기술 선정 이유
**1️⃣ 하위 버전 호환성에는 문제가 없는가?**
- `RxCocoa / RxSwift`: iOS 9까지 지원하며 현재 프로젝트 타겟의 경우 14.1로 되어 있기에 호환성에는 전혀 문제가 없다고 판단했습니다.
- `Firebase`: 21.5.11일 기준 iOS 10까지 지원을 하기 때문에 이 또한 문제가 없다고 판단했습니다. 

또한 [애플 문서](https://developer.apple.com/kr/support/app-store/)에 따르면 현재 iOS 15는 72%, iOS14는 26%의 사용률을 보이고 있어 현재 해당 기술을 사용하더라도 대부분의 사용자는 사용이 가능하다고 판단했습니다. 

**2️⃣ 안정적으로 운용 가능한가?**
- `RxCocoa / RxSwift`: Github의 `star`도 21.7k이고 15년도부터 나온 라이브러리인 만큼 충분히 안정적으로 운용이 가능하다 생각했습니다. 

<Contributors 추이>
<img width="976" alt="스크린샷 2022-03-01 오후 6 51 34" src="https://user-images.githubusercontent.com/90880660/156146330-b5a0dc95-a08a-4ac5-a826-9a02dc855667.png">

<5년간 검색 관심도>
<img width="1122" alt="스크린샷 2022-03-01 오후 6 50 24" src="https://user-images.githubusercontent.com/90880660/156146415-ebfc05e8-71bf-4d8b-a0ba-7e32373518cc.png">
다만 Contributors 추이나 5년간 검색 관심도로 미뤄볼 때 미래에도 지속해서 사용할 기술인가에 대해선 어느 정도 의문이 들긴 했습니다.

<br>

- `Firebase`: 업데이트도 꾸준히 되고 있고 구글에서 운영하는 것인 만큼 충분히 안정적으로 운용이 가능하다고 생각했습니다. 또한 많은 사람들이 사용하고 있는 만큼 관련된 자료도 많아 Trouble Shooting도 원활하다고 판단했습니다. 

<Contributors 추이>
<img width="985" alt="스크린샷 2022-03-01 오후 6 48 43" src="https://user-images.githubusercontent.com/90880660/156145905-aa887bac-29c3-461a-9624-ffa80e6c2016.png">
Contributors가 꾸준히 존재하고 있으며, 비교적 다양한 Contributors가 존재하고 있어 안정적인 운용이 예상됩니다. 

<5년간 검색 관심도>
<img width="1125" alt="스크린샷 2022-03-01 오후 6 45 40" src="https://user-images.githubusercontent.com/90880660/156145452-daebd25e-130c-4bda-a0e2-b95b29fa6d52.png">

<br>

- `SwiftLint`: 이 또한 15년도부터 나온 라이브러리이고, 이전 2개의 프로젝트에서 사용하며 놓치기 쉬운 컨벤션을 Alert / Error로 잡아줘서 유용하게 사용할 수 있었습니다. 따라서 이번 프로젝트에서도 적용했습니다. 또한 Contributors의 경우도 어느정도 꾸준히 존재하고 있어 안정적으로 운용이 될 것이라 생각합니다.

<Contributors 추이> 
<img width="1012" alt="스크린샷 2022-03-01 오후 6 40 39" src="https://user-images.githubusercontent.com/90880660/156144557-560e9b50-cf16-44c4-8b86-178ad0d0f345.png">

<5년간 검색 관심도>
<img width="1129" alt="스크린샷 2022-03-01 오후 6 43 33" src="https://user-images.githubusercontent.com/90880660/156144942-ebe771b7-4b2b-49bb-9a58-3b775828d67c.png">

**3️⃣ 미래 지속가능성이 있는가?**
- `RxCocoa / RxSwift`: SwiftUI가 대중화되면서 Combine 프레임워크가 많이 사용된다면 지속적으로 사용되진 않을 수 있다고 판단했습니다. 다만 현재에도 적지 않은 기업들이 사용 중이기 때문에 향후 1~2년은 지속해서 사용할 것이라 판단했습니다. 
- `Firebase`: 구글이 제공하고 있는 서비스이고, 현재 다양한 곳에서 사용 중이기 때문에 충분히 지속가능성이 있다고 판단했습니다. 

**4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?**
- `Firebase`: 일정 사용량이 초과할 경우 비용이 발생할 수 있다고 알고 있습니다. 또한 어떤 서버를 사용할 지 등과 같이 백엔드에 대한 컨트롤을 할 수 없다는 점도 리스크 중 하나라고 생각합니다. 하지만 현재 프로젝트 수준에선 일정 사용량이 초과할 경우는 발생하지 않는다고 판단했고, 서버 또한 현재 관리를 할 수 없기 때문에 큰 리스크는 아니라고 판단했습니다. 
 
**5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?**
- `RxCocoa / RxSwift`: SPM, CocoaPods, Carthage
- `Firebase`: SPM, CocoaPods, Carthage
- `SwiftLint`: CocoaPods

의존성 관리 도구의 경우 RxSwift를 SPM으로 사용했을 경우 버그가 있다는 것을 확인했습니다. 따라서 현재 다양한 회사에서 사용 중인 `CocoaPods`를 사용하기로 결정했습니다. 

**6️⃣ 이 앱의 요구기능에 적절한 선택인가?**
- `Firebase`: 빠르게 프로토타입의 앱을 만드는데 최적화된 데이터베이스인 만큼 해당 프로젝트에서 가장 적절한 데이터베이스 관련 라이브러리라고 판단했습니다. 
