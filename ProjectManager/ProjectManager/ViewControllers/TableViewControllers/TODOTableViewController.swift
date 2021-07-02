//
//  TODOTableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class TODOTableViewController: UITableViewController {
    var todoLists: [TODOModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.separatorStyle = .none
        
        let header: UIView = {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
            header.backgroundColor = .systemGray6

            return header
        }()
        
        let headerLabel : UILabel = {
            let label = UILabel(frame: header.bounds)
            label.text = "TODO"
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()
        
        let countView: UIView = {
            let countView = UIView()
            countView.backgroundColor = .black
            countView.translatesAutoresizingMaskIntoConstraints = false
            countView.clipsToBounds = true
            countView.layer.cornerRadius = 11.5
            
            return countView
        }()
        
        let countLabel: UILabel = {
            let count = UILabel(frame: header.bounds)
            count.textColor = .white
            count.text = "\(todoLists.count)"
            count.font = UIFont.preferredFont(forTextStyle: .title3)
            count.textAlignment = .center
            count.translatesAutoresizingMaskIntoConstraints = false

            return count
        }()
        
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.tableHeaderView = header
                
        let padding: CGFloat = 20.0
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: padding),
            headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: padding),
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),

            countView.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 10),
            countView.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 0),
            countView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.06),
            countView.heightAnchor.constraint(equalTo: countView.widthAnchor, multiplier: 1),

            countLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor)
        ])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.backgroundColor = .magenta

            return cell
        }()
        
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.backgroundColor = .blue
            titleLabel.text = "title"
            titleLabel.lineBreakMode = .byTruncatingTail
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            return titleLabel
        }()

        let descriptionLabel: UILabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.backgroundColor = .yellow
            descriptionLabel.text = """
I'm on the next level yeah절대적 룰을 지켜내 손을놓지말아결속은 나의 무기광야로 걸어가알아 네 homeground위협에 맞서서제껴라 제껴라 제껴라상상도 못한 black out유혹은 깊고 진해(Too hot too hot)(Ooh ooh wee) 맞잡은 손을 놓쳐난 절대 포기 못해I'm on the next level저 너머의 문을 열어Next level널 결국엔 내가 부셔Next levelKosmo에 닿을 때까지Next level제껴라 제껴라 제껴라
"""
            descriptionLabel.numberOfLines = 3
            descriptionLabel.lineBreakMode = .byTruncatingTail
            descriptionLabel.textColor = .black
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            return descriptionLabel
        }()

        let dateLabel: UILabel = {
            let dateLabel = UILabel()
            dateLabel.backgroundColor = .red
            dateLabel.text = "date"
            dateLabel.translatesAutoresizingMaskIntoConstraints = false

            return dateLabel
        }()
        
        cell.addSubview(titleLabel)
        cell.addSubview(descriptionLabel)
        cell.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            cell.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
        
            titleLabel.topAnchor.constraint(equalTo: cell.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            
            descriptionLabel.widthAnchor.constraint(equalTo: cell.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            dateLabel.widthAnchor.constraint(equalTo: cell.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
        ])
        
        return cell
    }
}

