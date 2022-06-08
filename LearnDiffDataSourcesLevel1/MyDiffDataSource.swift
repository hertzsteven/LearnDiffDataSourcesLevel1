//
//  MyDiffDataSource.swift
//  LearnDiffDataSourcesLevel1
//
//  Created by Steven Hertz on 6/8/22.
//

import UIKit


enum Section: CaseIterable {
    case networks
}


final class MyDiffDataSource: UIViewController {

    //  MARK: -  Used for  DiffDataSource
    
    var dataSource: UITableViewDiffableDataSource<Section,MYNumber>! = nil
    var snapshot: NSDiffableDataSourceSnapshot<Section,MYNumber>! = nil
    
    
    //  MARK: -  UI Objects
   
    let tableView = UITableView()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        tv.text = """
      hello,
      goodbye,
      seeyou
      later
    """
        return tv
    }()
    
    
    //  MARK: -  Items Loaded into the table
    var items: [MYNumber] = [
        MYNumber(numberName: "one"),
        MYNumber(numberName: "two"),
        MYNumber(numberName: "three"),
        MYNumber(numberName: "four"),
        MYNumber(numberName: "five"),
        MYNumber(numberName: "six"),
        MYNumber(numberName: "seven"),
        MYNumber(numberName: "eight"),
        MYNumber(numberName: "nine"),
        MYNumber(numberName: "ten")
    ]
    
    
    //  MARK: -  View ControllerLifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UITableViewDiffableDataSource<Section,MYNumber>(tableView: tableView) {
                (tableView: UITableView,
                 indexPath: IndexPath,
                 item: MYNumber) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.numberName
            return cell
        }
        
        tableViewSetup()
        textViewSetup()
        setupView()
        updateUI()
    }
    
    fileprivate func textViewSetup() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textView)
        
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
    
    fileprivate func tableViewSetup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
}
extension MyDiffDataSource  {

    func updateUI(animated: Bool = true) {
//        guard let controller = self.wifiController else { return }
//
        snapshot = NSDiffableDataSourceSnapshot<Section, MYNumber>()
        
        let sortedItems = items.sorted { $0.numberName < $1.numberName }
        
        snapshot.appendSections([.networks])
        snapshot.appendItems(sortedItems, toSection: .networks)
        
        self.dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func removeItemsandupdateUI()  {
        items.remove(at: 2)
        items.remove(at: 4)
        updateUI()
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = items[indexPath.row]
//        print(" in \(#function) at line \(#line)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = item.numberName
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
}

extension MyDiffDataSource {
    
    private func setupView() {
        
            // 1. create a button
        let button1 = UIButton(configuration: UIButton.Configuration.filled(),
                               primaryAction: UIAction(title: "Hello From One") { action in
            print(action.title)
            self.removeItemsandupdateUI()
        }
        )
        
            // 3. create a second buttton
        let button2 = UIButton(configuration: UIButton.Configuration.filled(),
                               primaryAction: UIAction(title: "Hello From The second one") { action in
            print(action.title)
        }
        )
        
            // 4. pass it to the stackView
        setupStackView(button1, button2)
        
    }
    
        // stackView gets created and get cofigured into the view
    fileprivate func setupStackView(_ views: UIView...) {
            // Instantiate the StackView
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 16
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()
        
        views.forEach { btn in
            stackView.addArrangedSubview(btn)
        }
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textView)
        
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    

}

