//
//  ActivitiesViewController.swift
//  CBT Velocity
//
//  Created by Ryan Hoffman on 4/5/16.
//  Copyright © 2016 Ryan Hoffman. All rights reserved.
//

import UIKit

class ActivitiesViewController: UITableViewController {
    
    var activities = Array<String>()
    let urlPath = "http://76.188.89.113/getAllActivities.php"
    
    @IBOutlet var uiTableView: UITableView!
    
    var TableData: Array<datastruct> = Array<datastruct>()
    
    enum ErrorHandler: ErrorType {
        case ErrorFetchingResults
    }
    
    struct datastruct {
        var imageURL: String?
        var description: String?
        var image: UIImage? = nil
        
        init(add: NSDictionary){
            imageURL = add["IMAGE"] as? String
            description = add["DESCRIPTION"] as? String
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTableView.dataSource = self
        uiTableView.delegate = self
        
        getActivitiesFromJson(urlPath)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this 
        // view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Retrieve the JSON array from the url.
    func getActivitiesFromJson(url: String){
        
        let url: NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let task = session.dataTaskWithRequest(request) {(let data, let response, let error) in
            guard let _: NSData = data, let _: NSURLResponse = response where error == nil else {
                print("error")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.extractJson(data!)
                return
            })
        }
        task.resume()
    }
    
    func extractJson(jsonData: NSData) {
        let json: AnyObject?
        do {
           json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        } catch {
            json = nil
            return
        }
        
        if let list = json as? NSArray {
            for i in 0 ..< list.count{
                if let dataBlock = list[i] as? NSDictionary {
                    TableData.append(datastruct(add: dataBlock))
                    print(dataBlock)
                }
            }
            refreshTable()
        }
    }
    
    func refreshTable(){
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the TableView
        return TableData.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ReusableCell",
                                                               forIndexPath: indexPath)

        // Configure the cell.
        let data = TableData[indexPath.row]
        cell.textLabel?.text = data.description
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView,
                            canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, 
            // and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, 
     moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView,
                            canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before 
    // navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
