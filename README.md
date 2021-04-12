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

