import UIKit

class popoverUIView: UIView {

    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "top"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bottomLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "bottom"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addUIComponents()
        self.configureLayout()
    }
    
    private func addUIComponents() {
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bottomLabel)
        self.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
