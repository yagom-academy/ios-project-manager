import UIKit

class HeaderView: UICollectionReusableView {
    static let identifier = String(describing: HeaderView.self)
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        addSubview(countLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(headerType: State, count: Int) {
        headerLabel.text = headerType.rawValue.uppercased()
        countLabel.text = "\(count)"
        countLabel.layer.cornerRadius = self.frame.height - 8
        backgroundColor = .systemGray6
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 8.0
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: padding),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -padding),
            countLabel.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -padding)
        ])
    }
}
