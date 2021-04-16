import UIKit

final class MemoHeaderCell: UICollectionViewListCell {
    private var title: String!
    private var memoCount: Int!
    private var currentMemoCountLabel = UILabel()
    private let titleLabel = UILabel()
    
    func updateWithHeaderItem(_ title: String, _ memoCount: Int) {
        self.title = title
        self.memoCount = memoCount
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        setupConstraints()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        currentMemoCountLabel.text = nil
    }
    
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(currentMemoCountLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        currentMemoCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            currentMemoCountLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            currentMemoCountLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            currentMemoCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            currentMemoCountLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.heightAnchor),
        ])
    }
    
    private func setupUI() {
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 30)
        
        currentMemoCountLabel.text = String(memoCount)
        currentMemoCountLabel.font = .systemFont(ofSize: 25)
        currentMemoCountLabel.backgroundColor = .systemGray
        currentMemoCountLabel.textAlignment = .center
        currentMemoCountLabel.textColor = .systemBackground
        currentMemoCountLabel.layer.cornerRadius = contentView.bounds.size.height / 3
        currentMemoCountLabel.layer.masksToBounds = true
    }
}
