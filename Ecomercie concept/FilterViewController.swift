//
//  FilterViewController.swift
//  Ecomercie concept
//
//  Created by Georgy on 21.09.2022.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ExpandableHeaderViewDelegate {
    func ToogleSections(header: ExpandableHeaderView, section: Int) {
        sections[section].Expanded.toggle()
        FilterTableView.beginUpdates()
        for row in 0..<sections[section].Filter.count{
            FilterTableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        FilterTableView.endUpdates()
    }
    
    
    var sections = [
        Sections(Filter: "Brand", FilterFill: ["Samsung","Apple","Huawei"], Expanded: false),
        Sections(Filter: "Price", FilterFill: ["500-1000$","1000-2000$","2000$-3000$"], Expanded: false),
        Sections(Filter: "Size", FilterFill: ["1-2m","2-3m","3-4m"], Expanded: false)
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].FilterFill.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].FilterFill[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].Expanded{
            return 44
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.setup(withTitle: sections[section].Filter, Section: section, delegate: self)
       return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    var ButtonPressed = [true,true,true]
    
    @IBOutlet weak var ModalView: UIView!
    
    @IBOutlet weak var FilterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FilterTableView.delegate = self
        FilterTableView.dataSource = self
    }
    
    @IBAction func ChekButton(_ sender: UIButton) {
        if sender.currentImage !== UIImage(systemName: "checkmark",withConfiguration: UIImage.SymbolConfiguration(scale: .small)){
        
            sender.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        }
        else{
            sender.setImage(UIImage(named: "Bag"), for: .normal)
        }
    }
    
    @IBAction func BackToView(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
