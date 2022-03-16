import UIKit

class ProjectDetailViewController: UIViewController {
    let projectDetailView: ProjectDetailView = {
        let view = ProjectDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        self.view.addSubview(projectDetailView)
        configureLayout()
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.projectDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.projectDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.projectDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.projectDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func createViewData() -> Project {
        return Project(
            id: UUID(),
            state: .todo,
            title: projectDetailView.titleTextField.text ?? "",
            body: projectDetailView.bodyTextView.text ?? "",
            date: projectDetailView.datePicker.date)
    }
    
    func updatedViewData(with oldProject: Project) -> Project {
        return Project(
            id: oldProject.id,
            state: oldProject.state,
            title: projectDetailView.titleTextField.text ?? "",
            body: projectDetailView.bodyTextView.text ?? "",
            date: projectDetailView.datePicker.date)
    }
}
