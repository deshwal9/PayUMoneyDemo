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
    enum PaymentDetails : String{
        case merchantID  = "4929738"
        case merchantKey = "eBJWgD"
        case salt = "4FtuMTMF"
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
        txnParam.firstname = "Umang"
        txnParam.key = "eBJWgD"
        txnParam.merchantid = "4929738"
        // should be came from web
        txnParam.txnID = "txnID123"
        txnParam.surl = "http://livenutrifit.com//IosAppPayUPaymentSuccess.aspx"
        //"https://www.payumoney.com/mobileapp/payumoney/success.php"
        txnParam.furl = "http://livenutrifit.com/IosAPPPayUPaymentFail.aspx"
        //"https://www.payumoney.com/mobileapp/payumoney/failure.php"
        txnParam.productInfo = "iPhone7"
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
        let serviceprovider:String = "payu_paisa"
        let lastname = "Deshwal"
        
        let hashValue = String.localizedStringWithFormat("%@|%@|%@|%@|%@|%@|||||||||||%@",PaymentDetails.merchantKey.rawValue,txnParam.txnID!,txnParam.amount!,txnParam.productInfo!,txnParam.firstname!,txnParam.email!,PaymentDetails.salt.rawValue)
        // let hash = self.sha1(string: hashValue)
    /*
        let hash1 = "\(PaymentDetails.merchantKey.rawValue)|\(txnParam.txnID!)|\(txnParam.amount!)|\(txnParam.productInfo!)|\(txnParam.firstname!)|\(txnParam.email!)|"
        let hash2 = "\(txnParam.phone!)|\(txnParam.surl!)|\(txnParam.furl!)|\(lastname)|\(serviceprovider)|"
        let hash3 = "|||||\(PaymentDetails.salt.rawValue)"
        let completeHash = "\(hash1)\(hash2)\(hash3)"
 */
         txnParam.hashValue = hashValue.sha512()
    //    hashSequence = key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||salt.
    //    $hash = hash("sha512", $hashSequence);
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

