import UIKit

class ProjectListCell: UITableViewCell {
    weak var delegate: ProjectListCellDelegate?
    private var indexPath: IndexPath?
    private var state: ProjectState?
    private var dateLabelColor = UIColor.label
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = Design.defaultTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = Design.previewTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = Design.defaultTextLine
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, previewLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = Design.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var moveToToDoAction: UIAlertAction {
        let action = UIAlertAction(title: "MOVE TO TODO", style: .default) { _ in
            self.delegate?.didTapTodoAction(self.state, indexPath: self.indexPath)
        }
        
        return action
    }
    
    private var moveToDoingAction: UIAlertAction {
        let action = UIAlertAction(title: "MOVE TO DOING", style: .default) { _ in
            self.delegate?.didTapDoingAction(self.state, indexPath: self.indexPath)
        }
        
        return action
    }
    
    private var moveToDoneAction: UIAlertAction {
        let action = UIAlertAction(title: "MOVE TO DONE", style: .default) { _ in
            self.delegate?.didTapDoneAction(self.state, indexPath: self.indexPath)
        }
        
        return action
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            containerView.layer.cornerRadius = Design.selectedCornerRadius
            containerView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
            previewLabel.textColor = .white
            dateLabel.textColor = .white
        } else {
            containerView.layer.cornerRadius = Design.defaultCornerRadius
            containerView.backgroundColor = .systemBackground
            titleLabel.textColor = .label
            previewLabel.textColor = .secondaryLabel
            dateLabel.textColor = dateLabelColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        previewLabel.text = nil
        state = nil
        indexPath = nil
    }
    
    func setupCell(of indexPath: IndexPath, with project: Project) {
        self.indexPath = indexPath
        self.state = project.state
        titleLabel.text = project.title
        previewLabel.text = project.body
        dateLabel.text = project.formattedDate
        setupDateLabel(with: project)
    }
    
    private func setupDateLabel(with project: Project) {
        if project.isExpired {
            dateLabelColor = .systemRed
        } else {
            dateLabelColor = .label
        }
    }

    private func commonInit() {
        contentView.addSubview(labelStackView)
        setupBackgroundColor()
        setupLabelStackViewLayout()
        addLongPressGesture()
    }
    
    private func addLongPressGesture() {
        let longPressGestrue = UILongPressGestureRecognizer(target: self, action: #selector(presentLongPressMenu(_:)))
        containerView.addGestureRecognizer(longPressGestrue)
    }
    
    private func makePopoverAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        switch state {
        case .todo:
            alert.addAction(moveToDoingAction)
            alert.addAction(moveToDoneAction)
        case .doing:
            alert.addAction(moveToToDoAction)
            alert.addAction(moveToDoneAction)
        case .done:
            alert.addAction(moveToToDoAction)
            alert.addAction(moveToDoingAction)
        case .none:
            break
        }
        
        return alert
    }
    
    @objc private func presentLongPressMenu(_ longPresss: UILongPressGestureRecognizer) {
        if longPresss.state == .began {
            let alert = makePopoverAlert()
            alert.popoverPresentationController?.sourceView = containerView
            delegate?.presentPopover(alert)
        }
    }
    
    private func setupBackgroundColor() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    private func setupLabelStackViewLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.layoutMargin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Design.layoutMargin),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Design.layoutMargin),
            labelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Design.layoutMargin),
            labelStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Design.layoutMargin)
        ])
    }
}

private enum Design {
    static let defaultTextLine = 1
    static let previewTextLine = 3
    static let stackViewSpacing: CGFloat = 10
    static let defaultCornerRadius: CGFloat = 0
    static let selectedCornerRadius: CGFloat = 10
    static let layoutMargin: CGFloat = 10
}
