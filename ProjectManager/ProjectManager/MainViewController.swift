import UIKit

class MainViewController: UIViewController {
    private var todoCollectionView: UICollectionView!
    private var doingCollectionView: UICollectionView!
    private var doneCollectionView: UICollectionView!
    
    private var todoDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    private var doingDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    private var doneDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    
    private var todoSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, Item>()
    
    private var todoHeaderItem = [
        HeaderItem(title: "todo", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
        ])
    ]
    
    private var doingHeaderItem = [
        HeaderItem(title: "doing", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
            Item(title: "전설의 시작.", description: "zdo", date: "2021-01-01"),
        ])
    ]

    private var doneHeaderItem = [
        HeaderItem(title: "done", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
            Item(title: "Let's get it!.", description: "zdo", date: "2021-01-01"),
            Item(title: "Lin step1이 많이 늦었습니다.😅", description: "😎", date: "2021-01-01"),
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

