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
    
    let countries = ["Poland", "Canada", "Ukraine", "Belarus", "Latvia"]
    
    var rxUniversities = BehaviorRelay<[University]>(value: [])
    var universities: [University]? {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "univerCell")
//        loadData()
        setupBinding()
    }
    
    //rxswift
    private func setupBinding() {
        apiClient.countries(with: countries)
            .subscribe(onNext: { [weak self] univers in
                self?.rxUniversities.accept(univers)
            })
            .disposed(by: disposeBag)

        rxUniversities
            .bind(to: tableView.rx.items(cellIdentifier: "univerCell", cellType: CountryTableViewCell.self)) { index, model, cell in
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
    
    //async await
    private func loadData() {
        Task {
            let startTime = CFAbsoluteTimeGetCurrent()
            
            universities = try await apiClient.getCountries(with: countries)
            
            let endTime = CFAbsoluteTimeGetCurrent()
            print(String(format: "%.5f", endTime - startTime))
        }
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return universities?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "univerCell", for: indexPath) as? CountryTableViewCell,
//              let universities else { return UITableViewCell() }
//
//        cell.stringView.clipsToBounds = true
//        cell.stringView.layer.cornerRadius = 7
//        cell.setupView(with: universities[indexPath.row])
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let universities else { return }
//
//        let url = URL(string: universities[indexPath.row].web_pages[0])!
//        let vc = SFSafariViewController(url: url)
//        present(vc, animated: true)
//    }
//
//}


