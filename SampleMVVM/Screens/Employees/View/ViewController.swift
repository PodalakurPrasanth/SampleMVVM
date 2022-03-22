//
//  ViewController.swift
//  SampleMVVM
//
//  Created by Prasanth Podalakur on 22/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainTableView : UITableView!
    
    lazy var viewModel = {
        EmployeesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
    }

    func initView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        mainTableView.separatorColor = .white
        mainTableView.separatorStyle = .singleLine
        mainTableView.tableFooterView = UIView()
        mainTableView.allowsSelection = false

        mainTableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
    }
    
    func initViewModel(){
        viewModel.getEmployees()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as? EmployeeCell else { return UITableViewCell() }
        cell.cellViewModel = viewModel.employeeCellViewModels[indexPath.row]
        return cell
    }
    
    
}
