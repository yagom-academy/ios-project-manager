    private func generatePopoverAlertController(_ tableView: UITableView, _ indexPath: IndexPath) -> UIAlertController? {
        let popoverAlertController = UIAlertController()
        
        addAlertActions(to: popoverAlertController, indexPath: indexPath)
        settingPopoverView(of: popoverAlertController, indexPath: indexPath)
        
        return popoverAlertController
    }
    
    private func addAlertActions(to alertController: UIAlertController, indexPath: IndexPath) {
        guard let currentStatus = self.statusType else { return }
        let statusList = TodoStatus.allCases.filter { $0 != currentStatus }
        
        statusList.forEach { selectedStatus in
            let newAction = UIAlertAction(
                title: "Move to \(selectedStatus.upperCasedString)",
                style: .default
            ) { [weak self] _ in
                self?.moveToButtonTapped(from: currentStatus, indexPath: indexPath, to: selectedStatus)
            }
            
            alertController.addAction(newAction)
        }
    }
    
    private func settingPopoverView(of alertController: UIAlertController, indexPath: IndexPath) {
        guard let selectedCellView = self.tableView?.cellForRow(at: indexPath) else { return }
        
        let popoverPresentationController = alertController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = selectedCellView
        popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: 0,
            width: selectedCellView.frame.width,
            height: selectedCellView.frame.height / 2
        )
        
        alertController.modalPresentationStyle = .popover
    }
