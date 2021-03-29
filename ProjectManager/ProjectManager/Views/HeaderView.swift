import UIKit

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: HeaderView.self)
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(headerName: String) {
        headerLabel.text = headerName
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
