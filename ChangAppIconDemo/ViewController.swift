//
//  ViewController.swift
//  ChangAppIconDemo
//
//  Created by GuoYongming on 2020/11/30.
//

import UIKit

struct IconItem {
    var iconName = ""
    var imageName = ""
    var displayName = ""
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var iconData = [IconItem(iconName: "", imageName: "Icon1", displayName: "Icon1"),
                    IconItem(iconName: "Icon2", imageName: "Icon2", displayName: "Icon2"),
                    IconItem(iconName: "Icon3", imageName: "Icon3", displayName: "Icon3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    func initUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let iconItem = iconData[indexPath.row]
        cell?.imageView?.image = UIImage(named: iconItem.imageName)
        cell?.textLabel?.text = iconItem.displayName
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 30)
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        var iconName: String? = nil
        let iconItem = iconData[indexPath.row]
        if !iconItem.iconName.isEmpty {
            iconName = iconItem.iconName
        }
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if error != nil {
                debugPrint("There something wrong with changing app icon!")
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
