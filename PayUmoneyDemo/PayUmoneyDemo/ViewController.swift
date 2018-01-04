//
//  ViewController.swift
//  PayUmoneyDemo
//
//  Created by Ankit Deshwal on 08/11/17.
//  Copyright © 2017 Ankit Deshwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kcolor_TabBar = UIColor(netHex:0x00B2D8);
    let kcolor_TitleColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1);
    let kcolor_ButtonColor = UIColor(red: 127/255, green: 191/255, blue: 0/255, alpha: 1);
    let kcolor_ButtonText = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1);
    let merchantName = "Shopmatics"
    // configuration
    let isCompletionDisable:Bool = false
    let isWalletDisable:Bool = false
    let isCardsDisable:Bool = false
    let isNetbankDisable:Bool = false
    
    // IBOutlet object
    @IBOutlet weak var mobileTxtfld: UITextField!
    @IBOutlet weak var emailTxtfld: UITextField!
    @IBOutlet weak var amountTxtfld: UITextField!
    @IBOutlet weak var paymentBtn: UIButton!
    /*
     get this details from payUmoney account after creating account on that
    */
    /*
    enum PaymentDetails : String{
        case merchantID  = "5943938"
        case merchantKey = "0Ar5nsZ8"
        case salt = "5rADLfzSxX"
        case baseUrl = "https://test.payu.in"
    }
 */
 enum TestPaymentDetails : String{
     case merchantID  = "396132"
     case merchantKey = "40747T"
     case salt = "cJHb2BC9"
     case baseUrl = "https://test.payu.in"
     }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // IBOutlet action method
    @IBAction func paymentTappedAction(_ sender: Any) {
        let txnParam:PUMTxnParam = PUMTxnParam()
       
        //Set the parameters
        txnParam.phone = "9717410858"
        txnParam.email = "umangarya336@gmail.com"
        txnParam.amount = "100"
        txnParam.environment = PUMEnvironment.test
        txnParam.firstname = "test"
        txnParam.key = TestPaymentDetails.merchantKey.rawValue
        txnParam.merchantid = TestPaymentDetails.merchantID.rawValue
        //  transactionid should be came from backend
        // dynamicly creating transactionid for demo purpose only
        let uuid = UUID().uuidString
        let transaction = uuid.sha512()
        let transactionid = (transaction as NSString).substring(to: 20)
        txnParam.txnID = transactionid
        txnParam.txnID = "txnID123"
        // url which will show when transaction succeed
        txnParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
        // url which will show when transaction failed
        txnParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
        // Product info which user going to buy
        txnParam.productInfo = "iPhone7"
        // User define parameter
        txnParam.udf1 = ""
        txnParam.udf2 = ""
        txnParam.udf3 = ""
        txnParam.udf4 = ""
        txnParam.udf5 = ""
        txnParam.udf6 = ""
        txnParam.udf7 = ""
        txnParam.udf8 = ""
        txnParam.udf9 = ""
        txnParam.udf10 = ""
      
        let hashValue = String.localizedStringWithFormat("%@|%@|%@|%@|%@|%@|||||||||||%@",TestPaymentDetails.merchantKey.rawValue,txnParam.txnID!,txnParam.amount!,txnParam.productInfo!,txnParam.firstname!,txnParam.email!,TestPaymentDetails.salt.rawValue)
        // let hash = self.sha1(string: hashValue)
    /*
        let hash1 = "\(PaymentDetails.merchantKey.rawValue)|\(txnParam.txnID!)|\(txnParam.amount!)|\(txnParam.productInfo!)|\(txnParam.firstname!)|\(txnParam.email!)|"
        let hash2 = "\(txnParam.phone!)|\(txnParam.surl!)|\(txnParam.furl!)|\(lastname)|\(serviceprovider)|"
        let hash3 = "|||||\(PaymentDetails.salt.rawValue)"
        let completeHash = "\(hash1)\(hash2)\(hash3)"
 */
         txnParam.hashValue = hashValue.sha512()
        PlugNPlay.presentPaymentViewController(withTxnParams: txnParam, on: self) { (paymentResponse, error, extraParam) in
            
            
            print(paymentResponse ?? "paymentResponse is having none value")
            print(error ?? "error is having none value")
            print(paymentResponse ?? "paymentResponse IS HAVING NONE VALUE")
            
        }

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension String {
    
    func sha512() -> String {
        let data = self.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes({
            _ = CC_SHA512($0, CC_LONG(data.count), &digest)
        })
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
}

