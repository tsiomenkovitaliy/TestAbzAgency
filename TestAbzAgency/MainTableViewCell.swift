import UIKit

final class MainTableViewCell: UITableViewCell {
	
	static let reuseIdentifier = String(describing: MainTableViewCell.self)
	
	let titleLabel: UILabel = {
	 let label = UILabel()
	 label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
	 label.numberOfLines = 0
	 return label
		}()
 
	 let subtitleLabel: UILabel = {
		 let label = UILabel()
		 label.textColor = .gray
		 label.font = UIFont.systemFont(ofSize: 14)
		 label.numberOfLines = 0
		 return label
	 }()
 
	 let detailLabel: UILabel = {
		 let label = UILabel()
		 label.textColor = .lightGray
		 label.font = UIFont.systemFont(ofSize: 12)
		 label.numberOfLines = 0
		 return label
	 }()
 
	 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		 super.init(style: style, reuseIdentifier: reuseIdentifier)
		 
		 addSubview(titleLabel)
		 addSubview(subtitleLabel)
		 addSubview(detailLabel)
		 
		 titleLabel.snp.makeConstraints { make in
			 make.top.equalToSuperview().offset(8)
			 make.leading.equalToSuperview().offset(16)
			 make.trailing.equalToSuperview().offset(-16)
		 }
		 
		 subtitleLabel.snp.makeConstraints { make in
			 make.top.equalTo(titleLabel.snp.bottom).offset(8)
			 make.leading.equalToSuperview().offset(16)
			 make.trailing.equalToSuperview().offset(-16)
		 }
		 
		 detailLabel.snp.makeConstraints { make in
			 make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
			 make.leading.equalToSuperview().offset(16)
			 make.trailing.equalToSuperview().offset(-16)
			 make.bottom.equalToSuperview().offset(-8)
		 }
	 }
	 
	 required init?(coder aDecoder: NSCoder) {
		 fatalError("init(coder:) has not been implemented")
	 }
}
