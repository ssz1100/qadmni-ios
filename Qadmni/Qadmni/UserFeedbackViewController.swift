//
//  UserFeedbackViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 11/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class UserFeedbackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var orderId : Int32 = 0
    var reviewItemResModel : [ReviewItemResModel] = []

    @IBOutlet var tableView: UITableView!
    @IBAction func submitButtontapped(_ sender: UIButton) {
        
        var items : [SubmitFeedbackItemModel] = []
        for reviewItem in reviewItemResModel{
            var itemReviewed : SubmitFeedbackItemModel = SubmitFeedbackItemModel()
            itemReviewed.itemId = reviewItem.itemId
            itemReviewed.rating = reviewItem.review
            items.append(itemReviewed)
        }
        let submitFeebackDataReqModel = SubmitFeebackDataReqModel()
        submitFeebackDataReqModel.orderId = orderId
        submitFeebackDataReqModel.items = items
        let customerSubmitFeedbackUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerSubmitFeedback(customerDataRequest: submitFeebackDataReqModel,
                                                 customerUserRequest: customerSubmitFeedbackUser,
                                                 customerLangCodeRequest: customerLangCode,
                                                 completionHandler: {
                                                    response in
                                                    debugPrint(response)
                                                    if (response?.errorCode == 0)
                                                    {
                                                        let alertView = UIAlertController.init(title:NSLocalizedString("success.title", comment: "") , message: response?.message, preferredStyle: .alert)
                                                        let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "UserOrderHistoryNavigation") as! UINavigationController
                                                            self.present(vc, animated: true)
                                                        }
                                                        let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
                                                        alertView.addAction(defaultAction)
                                                        alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                                        self.present(alertView, animated: true)
                                                    }
                                                    else{
                                                        self.showAlertMessage(title: NSLocalizedString("serverError", comment: ""), message: (response?.message)!)
                                                        
                                                    }

        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let reviewItemReqModel = ReviewItemReqModel()
        reviewItemReqModel.orderId = orderId
        let customerReviewListUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerReviewItem(customerDataRequest: reviewItemReqModel,
                                             customerUserRequest: customerReviewListUser,
                                             customerLangCodeRequest: customerLangCode,
                                             completionHandler: {
                                                response in
                                                self.reviewItemResModel = response as! [ReviewItemResModel]
                                                self.tableView.reloadData()
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewItemResModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubmitFeedbackTableViewCell
        cell.itemname.text = self.reviewItemResModel[indexPath.row].itemName
        cell.ratingView.rating = 0
        cell.ratingView.didTouchCosmos = {rating in
        self.reviewItemResModel[indexPath.row].review = rating
        }
        
        cell.ratingView.settings.fillMode = .half
        
        return cell

    }


}
