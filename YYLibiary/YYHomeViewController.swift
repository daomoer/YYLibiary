//
//  YYHomeViewController.swift
//  YYLibiary
//
//  Created by YY on 2017/5/18.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
// 列表展示界面

class YYHomeViewController: UITableViewController {
    var classVCList:[[String:Any]] = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YYLibiary"
        
        classVCList.append(["title":"YYScrollViewController",
                           "class":YYScrollViewController.self])
            
        classVCList.append(["title":"YYCollectionViewController",
                            "class":YYCollectionViewController.self])
        
        classVCList.append(["title":"YYBannerViewController",
                            "class":YYBannerViewController.self])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classVCList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier);
        }
        cell?.textLabel?.text = classVCList[indexPath.row]["title"] as? String
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:UIViewController = (self.classVCList[indexPath.row]["class"] as! UIViewController.Type).init()
        vc.title = classVCList[indexPath.row]["title"]as?String
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
