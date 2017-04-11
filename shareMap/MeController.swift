//
//  MeController.swift
//  shareMap
//
//  Created by Labuser on 4/10/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//
import UIKit

class MeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var theData: [String] = []
    
    
    private func setupTableView() {
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            theData.remove(at: indexPath.row)
            var array=UserDefaults.standard.stringArray(forKey: "movieKey") ?? [String]()
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array,forKey:"movieKey")
            tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel!.text = "testPost\(indexPath.row)";//theData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4; // theData.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath);
        if indexPath.row != 5{
            let detailedView = Detailed();
            self.navigationController?.pushViewController(detailedView, animated: true);
        }
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        setupTableView()
        //fetchData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
