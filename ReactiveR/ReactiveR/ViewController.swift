//
//  ViewController.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let apiClient = NetworkClient()
    private let disposeBag = DisposeBag()
    
    let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
    
    var countries = BehaviorRelay<[University]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "univerCell")
        tableView.backgroundColor = .systemGray4
        setupBinding()
    }

    func setupBinding() {
        apiClient.countries()
            .subscribe(onNext: { [weak self] univers in
                let sorted = univers.sorted(by: { $0.name < $1.name })
                self?.countries.accept(sorted)
            })
            .disposed(by: disposeBag)
        
        countries
            .bind(to: tableView.rx.items(cellIdentifier: "univerCell", cellType: CountryTableViewCell.self)) { index, model, cell in
                cell.backgroundColor = .systemGray4
                cell.setupView(with: model)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(University.self)
            .map { URL(string: $0.web_pages.first ?? "")! }
            .map { SFSafariViewController(url: $0) }
            .subscribe(onNext: { [weak self] SafariVC in
                self?.present(SafariVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return poland.count
//        case 1:
//            return ukraine.count
//        case 2:
//            return belarus.count
//        case 3:
//            return usa.count
//        case 4:
//            return latvia.count
//        default:
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
//
//        switch indexPath.section {
//        case 0:
//            cell.setupView(with: poland[indexPath.row])
//        case 1:
//            cell.setupView(with: ukraine[indexPath.row])
//        case 2:
//            cell.setupView(with: belarus[indexPath.row])
//        case 3:
//            cell.setupView(with: usa[indexPath.row])
//        case 4:
//            cell.setupView(with: latvia[indexPath.row])
//        default:
//            break
//        }
//
//        return cell
//    }
//
//}


