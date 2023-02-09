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

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadButton: UIButton!
    
    let disposeBag = DisposeBag()
    let activityIndicator = ActivityIndicator()
    
    let network = NetworkManager()
        
    let progress = ProgressHUD(theme: .systemMaterialDark)
    
    let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
    
    var rxUniversities = BehaviorRelay<[University]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nib, forCellReuseIdentifier: "univerCell")
        
        searchBar.colorImageBar()
        searchBar.layer.cornerRadius = 10
        
        view.addSubview(progress)
        
        setupBinding()
    }
    
    func setupBinding() {
        // load data
        loadButton.rx.tap
            .flatMapLatest { [self] in
                network.getCountries()
                    .trackActivity(activityIndicator)
            }
            .subscribe(onNext: { [weak self] univers in
                guard let self else { return }
                self.rxUniversities.accept(self.rxUniversities.value + univers)
            })
            .disposed(by: disposeBag)
        
        activityIndicator.asDriver()
            .drive(progress.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // search bar & table view bindings
        
        rxUniversities
            .map { !$0.isEmpty }
            .bind(to: searchBar.rx.isActive)
            .disposed(by: disposeBag)
        
        let queary = searchBar.rx.text.orEmpty.distinctUntilChanged()
        
        Observable.combineLatest(rxUniversities, queary) { [unowned self] (universities, queary) -> [University] in
            return self.filteredUniversities(with: universities, query: queary)
        }
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
    
    func filteredUniversities(with allUniversities: [University], query: String) -> [University] {
        guard !query.isEmpty else { return allUniversities }
        
        return allUniversities.filter { $0.name.range(of: query, options: .caseInsensitive) != nil || $0.country.range(of: query, options: .caseInsensitive) != nil }
    }
}


