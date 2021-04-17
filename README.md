## 팀원

|                 팀원                  |                          사용 언어                           |
| :-----------------------------------: | :----------------------------------------------------------: |
| [Joons](https://github.com/elddy0948) | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |
|  [Glenn](https://github.com/iluxsm)   | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |
|   [꼬말](https://github.com/hakju)    | <img width="200" alt="Swift" src="https://user-images.githubusercontent.com/40102795/114259983-f7a4f480-9a0c-11eb-8f57-2da635febfd9.png"> |



## 사용한 기술

- UICollectionView
- UICollectionViewDiffableDataSource
- UICollectionViewDragDelegate, UICollectionViewDropDelegate





## Refactor

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



## 문제점

- CollectionView Drag and Drop 기능 구현 중 하나의 CollectionView에 있는 cell을 다른 CollectionView로 이동하려고 할 때 이전의 cell은 지워지지 않고 그대로 남아있는 현상.

  - 원인 : Diffable DataSource에서 Delete를 진행하는 과정에서 DataSource에서 해당 데이터를 찾지 못함.

  - 해결 방법 : 기존의 struct로 생성되어있던 Thing 모델을 class로 바꾸는 과정에서 Diffable DataSource에서 필요로 하는 Hashable 과 Equatable에 대한 정의를 해주지 않았음. 

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

    object에 대한 hash값과 isEqual을 정의해주며 id값을 비교하여 Diffable DataSource에서 데이터를 찾을 수 있게 해주었다.

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

  Required init? 과 init의 구현을 똑같이 해주려고 하는데 기존의 init은 collectionType이라는 파라미터를 하나 더 받아온다. 하지만 required init?에 collectionType이라는 파라미터를 넣으면 required init?을 또 생성하라는 에러메시지가 나오는 문제 

