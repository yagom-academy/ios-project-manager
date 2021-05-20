## 팀원

|                 팀원                  |                          사용 언어                           |
| :-----------------------------------: | :----------------------------------------------------------: |
| [Joons](https://github.com/elddy0948) | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |
|  [Glenn](https://github.com/iluxsm)   | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |
|   [꼬말](https://github.com/hakju)    | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |

## 목차

- [기여한 내용](#what-did-i-do)
- [리팩토링](#refactor-list)
- [해결해봤어요](#think-complete)
- [고민중](#still-thinking)
- [앱 화면](#app-screen)



## <a name="what-did-i-do">기여한 내용</a>

- UICollectionViewDragDelegate, UICollectionViewDropDelegate를 활용하여 3개의 CollectionView 사이에서의 Drag and Drop기능을 구현하였습니다. 

  ```swift
  //DragDelegate
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
  	guard let collectionView = collectionView as? ListCollectionView,
  		let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
  			return []
  	}
          
  	let itemProvider = NSItemProvider(object: thing)
  	let dragItem = UIDragItem(itemProvider: itemProvider)
  	return [dragItem]
  }
  ```

  DropDelegate를 활용하여 사용자가 특정 Cell을 Drop하는 이벤트를 관리해주었습니다.

  ```swift
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
  	var dropProposal = UICollectionViewDropProposal(operation: .cancel)
  	guard session.items.count == 1 else {
  		return dropProposal
  	}
  	if collectionView.hasActiveDrag {
  		dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
  	} else {
  		dropProposal = UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
  	}
  	return dropProposal
  }
  ```

  ```swift
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
  	guard let collectionView = collectionView as? ListCollectionView else {
  		return
  	}
  	let destinationIndexPath: IndexPath
  	if let indexPath = coordinator.destinationIndexPath {
  		destinationIndexPath = indexPath
  	} else {
  		let section = collectionView.numberOfSections - 1
  		let row = collectionView.numberOfItems(inSection: section)
  		destinationIndexPath = IndexPath(row: row, section: section)
  	}
  	coordinator.session.loadObjects(ofClass: Thing.self) { [weak self] (items) in
  		guard let self = self else { return }
  		guard let thingItem = items as? [Thing],
  					let thing = thingItem.first else { return }
  		let state = collectionView.collectionType
  		self.deleteFromBefore(thing: thing)
  		thing.state = state
  		collectionView.reorderDataSource(destinationIndexPath: destinationIndexPath, thing: thing)
  	}
  }
  ```

- Custom CollectionView를 구현하여 3개의 각각 Todo, Doing, Done CollectionView를 만들어주었습니다. 

  ```swift
  private let todoCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .todo)
  private let doingCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .doing)
  private let doneCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .done)
  
  //viewDidLoad()
  stackView.addArrangedSubview(todoCollectionView)
  stackView.addArrangedSubview(doingCollectionView)
  stackView.addArrangedSubview(doneCollectionView)
  ```

  

- UICollectionViewDiffableDataSource

- 

## <a name="refactor-list">리팩토링</a>

- 기존에 PopOverViewController의 View들을 Private으로 설정해줄 수 없었다. -> ViewController에서 접근하고 있었기때문이다. 그래서 ViewController에서는 PopOverViewController에 사용할 Thing만 넘겨주고, 그 Thing의 유무에 따라 Add를 위한 PopOverViewController인지 Edit를 위한 PopOverViewController인지 결정해주었습니다.

  - ```swift
        init(collectionView: ListCollectionView, thing: Thing?) {
            super.init(nibName: nil, bundle: nil)
            self.collectionView = collectionView
            
            if let thing = thing {
                configureEdit(with: thing)
            } else {
                configureAdd()
            }
        }
    ```

    그래서 기존에 ViewController에서 접근하여 설정했던 값들을 PopOverViewController에서 설정하여 View들에게 접근제한자를 설정해줄 수 있게 해주었습니다.

- 기존에 PopOverViewController가 화면에 보여지지 않을 CollectionView를 소유하고 있었는데 이를 PopOverViewController에 Protocol을 생성해주면서 Delegate 패턴을 사용하여 해결해 주었습니다. 

  - ```swift
    //PopOverViewController.swift
    protocol PopOverViewDelegate: AnyObject {
        func addThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
        func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
    }
    
    //ViewController.swift
    extension ViewController: PopOverViewDelegate {
        func addThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing) {
            todoCollectionView.insertDataSource(thing: thing, state: .todo)
        }
        
        func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing) {
            guard let state = thing.state else { return }
            switch state {
            case .todo:
                todoCollectionView.updateThing(thing: thing)
            case .doing:
                doingCollectionView.updateThing(thing: thing)
            case .done:
                doneCollectionView.updateThing(thing: thing)
            }
        }
    }
    ```

    그래서 더이상 PopOverViewController가 불필요하게 CollectionView를 들고다니지 않을 수 있게 리팩토링 해주었습니다.

## <a name="think-complete">해결해봤어요</a>

- CollectionView Drag and Drop 기능 구현 중 하나의 CollectionView에 있는 cell을 다른 CollectionView로 이동하려고 할 때 이전의 cell은 지워지지 않고 그대로 남아있는 현상을 발견했습니다..

  - 원인 : Diffable DataSource에서 Delete를 진행하는 과정에서 DataSource에서 해당 데이터를 찾지 못했습니다.

  - 해결 방법 : 기존의 struct로 생성되어있던 Thing 모델을 class로 바꾸는 과정에서 Diffable DataSource에서 필요로 하는 Hashable 과 Equatable에 대한 정의를 해주지 않았습니다. 

  - ```swift
        //Thing.swift
            override var hash: Int {
            var hasher = Hasher()
            hasher.combine(id)
            return hasher.finalize()
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let object = object as? Thing else { return false }
            return self.id == object.id
        }
    ```

    object에 대한 hash값과 isEqual을 정의해주며 id값을 비교하여 Diffable DataSource에서 데이터를 찾을 수 있게 해주었습니다.


## <a name="still-thinking">고민중</a>

- ```swift
      init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, collectionType: State) {
          super.init(frame: frame, collectionViewLayout: layout)
          self.collectionType = collectionType
          things = DataSource.shared.getDataByState(state: collectionType)
          configureCollectionView()
          configureDataSource()
          configureSnapshot()
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          preconditionFailure("모르겠어요.")
          self.collectionType = collectionType	//Error!
          things = DataSource.shared.getDataByState(state: collectionType)
          configureCollectionView()
          configureDataSource()
          configureSnapshot()
      }
  ```

  Required init? 과 init의 구현을 똑같이 해주려고 하는데 기존의 init은 collectionType이라는 파라미터를 하나 더 받아옵니다. 하지만 required init?에 collectionType이라는 파라미터를 넣으면 required init?을 또 생성하라는 에러메시지가 나오는 문제가 발생했습니다.

## <a name="app-screen">앱 화면</a>

![Simulator Screen Recording - iPad Pro (12 9-inch) (5th generation) - 2021-05-20 at 21 51 42](https://user-images.githubusercontent.com/40102795/118982183-23c17700-b9b6-11eb-8f6d-88964d458bc8.gif)![Simulator Screen Recording - iPad Pro (12 9-inch) (5th generation) - 2021-05-20 at 21 51 58](https://user-images.githubusercontent.com/40102795/118982221-2cb24880-b9b6-11eb-977f-5de73c63780e.gif)![Simulator Screen Recording - iPad Pro (12 9-inch) (5th generation) - 2021-05-20 at 21 52 32](https://user-images.githubusercontent.com/40102795/118982262-3471ed00-b9b6-11eb-8cfd-16a65c74d5c2.gif)
