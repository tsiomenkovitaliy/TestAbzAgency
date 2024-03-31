import UIKit
import SnapKit

protocol RequestViewModelDelegate: AnyObject {
	func requestsUpdated()
}

final class ViewController: UIViewController {
	
	var viewModel: RequestViewModel!
	
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .insetGrouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViewModel()
		setupTableView()
		viewModel.fetchRequests {
			self.tableView.reloadData()
		}
	}
	
	private func setupViewModel() {
		let coreDataManager = CoreDataManager.shared
		viewModel = RequestViewModel(dataManager: coreDataManager)
		viewModel.delegate = self
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.requests.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
		
		let request = viewModel.requests[indexPath.row]
		cell.titleLabel.text = "\(request.text ?? "")"
		let dateStr = DateFormatter.localizedString(from: request.timestamp ?? Date(), dateStyle: .short,timeStyle: .short)
		cell.detailLabel.text = dateStr
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.deleteRequest(at: indexPath.row) {
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

extension ViewController: RequestViewModelDelegate {
	func requestsUpdated() {
		viewModel.fetchRequests {
			self.tableView.reloadData()
		}
	}
}
