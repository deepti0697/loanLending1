//
//  Model.swift
//  ASOEBI
//
//  Created by apple on 03/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SwiftyJSON
import Photos

class User{
    
    var country_code  : String!
    var language:String!
    var staffId:String!
    var name:String!
    var company:String!
    var city:String!
    var gender:String!
    var image:String!
    var mobile    : String!
    var id   : String!
    var verificationId:String!
    var email:String!
    var password:String!
    var token:String!
    var status:String!
    var isMobileVerified:String!
    var isArchived:String!
    var created_at:String!
    var updated_at:String!
    
    
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        
        
        email               = json["email"].stringValue
        mobile              = json["mobile"].stringValue
        token               = json["token"].stringValue
        country_code        = json["country_code"].stringValue
        language            = json["language"].stringValue
        staffId             = json["staffId"].stringValue
        name                = json["name"].stringValue
        company             = json["company"].stringValue
        city                = json["city"].stringValue
        gender              = json["gender"].stringValue
        image               = json["image"].stringValue
        mobile              = json["mobile"].stringValue
        id                  = json["id"].stringValue
        verificationId      = json["verificationId"].stringValue
        email               = json["email"].stringValue
        password            = json["password"].stringValue
        token               = json["token"].stringValue
        status              = json["status"].stringValue
        isMobileVerified    = json["isMobileVerified"].stringValue
        isArchived          = json["isArchived"].stringValue
        created_at          = json["created_at"].stringValue
        updated_at          = json["updated_at"].stringValue
    }
}



class LanguageDTo {
    
    
    
    var currency: String!
    var code                 : String!
    var id                    : String!
    
    var name             : String!
    
    init() {
        
    }
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        code               = parseData["code"].stringValue
        id                  = parseData["id"].stringValue
        currency             = parseData["currency"].stringValue
        name           = parseData["name"].stringValue
        
    }
}
class MyLoanSection {
    var status:String!
    var loans = [MyLoanList]()
    
    init() {
        
    }
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        let sortData = parseData["loans"].arrayValue
        status = parseData["status"].stringValue
        for value in sortData {
            let sortByData = MyLoanList(fromJson: value)
            self.loans.append(sortByData)
        }
    }
}

class LoanHistory {
    var id:String!
    var lender:MyLender?
    var amount:String!
    var status:String!
    var updated_at:String!
    
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        let getLenderData = parseData["lender"]
        id = parseData["id"].stringValue
        amount = parseData["amount"].stringValue
        status = parseData["status"].stringValue
        updated_at = parseData["updated_at"].stringValue
        lender = MyLender(fromJson: getLenderData)
    }
}
class MyLoanType {
    var id :String!
    var fr_name:String!
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        id = parseData["id"].stringValue
        fr_name = parseData["fr_name"].stringValue
        
    }
}
class MyLender {
    var name:String!
    var processingFee:String!
    var logo:String!
    var id:String!
    var email:String!
    var interest:String!
    
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        name = parseData["name"].stringValue
        processingFee = parseData["processingFee"].stringValue
        logo = parseData["logo"].stringValue
        id = parseData["id"].stringValue
        email = parseData["email"].stringValue
        interest = parseData["interest"].stringValue
    }
}
class MyLoanList {
    var id: String!
    var loanId:String!
    var purpose:String!
    var amount:String!
    var tenure:String!
    var interest:String!
    var processingFee:String!
    var emi: String!
    var bankAccount:String!
    var wallet:String!
    var paySlips:String!
    var status:String!
    var isArchived:String!
    var created_at: String!
    var updated_at:String!
    var lender:  MyLender?
    var loan_type: LoanType?
    init() {
        
    }
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        let getLenderData = parseData["lender"]
        let getLoanData = parseData["loan_type"]
        id = parseData["id"].stringValue
        loanId = parseData["loanId"].stringValue
        purpose = parseData["purpose"].stringValue
        amount = parseData["amount"].stringValue
        tenure = parseData["tenure"].stringValue
        interest = parseData["interest"].stringValue
        processingFee = parseData["processingFee"].stringValue
        emi = parseData["emi"].stringValue
        bankAccount = parseData["bankAccount"].stringValue
        wallet = parseData["wallet"].stringValue
        paySlips = parseData["paySlips"].stringValue
        status = parseData["status"].stringValue
        isArchived = parseData["isArchived"].stringValue
        created_at = parseData["created_at"].stringValue
        updated_at = parseData["updated_at"].stringValue
        
        lender = MyLender(fromJson: getLenderData)
        
        
        loan_type = LoanType(fromJson: getLoanData)
        
    }
}

class LoanList {
    
    var id: String!
    var name:String!
    var logo:String!
   
//
//    var loanTypes = [LoanType]()
    init() {
        
    }
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
    
        id          = parseData["id"].stringValue
        name        = parseData["name"].stringValue
        logo       = parseData["logo"].stringValue
        
    }
}

class LoanType {
    var name:String!
    
    var min_amount:String!
    var max_amount:String!
    var interest_type:String!
    var min_tenure:String!
    var max_tenure:String!
    var interest:String!
    var processingFee:String!
    var loan_type: productLoanDetail?
    var id:String!
//   var purposeMarrige = [PurposeMarrige]()
    
    init() {
        
    }
    
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        name = parseData["name"].stringValue
        min_amount = parseData["min_amount"].stringValue
        max_amount = parseData["max_amount"].stringValue
//        let purposeM = parseData["purposes"].arrayValue
        let loantype = parseData["loan_type"]
        id          = parseData["id"].stringValue
        interest_type  = parseData["interest_type"].stringValue
        min_tenure = parseData["min_tenure"].stringValue
        max_tenure = parseData["max_tenure"].stringValue
        interest = parseData["interest"].stringValue
        processingFee = parseData["processingFee"].stringValue
//        loan_type = parseData["loan_type"].stringValue
        loan_type = productLoanDetail(fromJson: loantype)
        id = parseData["id"].stringValue
//        for value in purposeM {
//            let sortByData = PurposeMarrige(fromJson: value)
//            self.purposeMarrige.append(sortByData)
//        }
    }
}
class PurposeMarrige {
    var value:String!
    var name:String!
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        value = parseData["value"].stringValue
        name = parseData["name"].stringValue
}
}
class productLoanDetail {
    var id : String!
   
    var name:String!
    var fr_name:String!
    var status:String!
    var isArchived:String!
    var created_at:String!
    var updated_at:String!
    var image:String!
    init(fromJson parseData: JSON!){
        
        if parseData?.isEmpty ?? false{
            return
        }
        id          = parseData["id"].stringValue
        name        = parseData["name"].stringValue
        fr_name     = parseData["fr_name"].stringValue
        status      = parseData["status"].stringValue
        isArchived  = parseData["isArchived"].stringValue
        created_at  = parseData["created_at"].stringValue
        updated_at  = parseData["updated_at"].stringValue
        image        = parseData["image"].stringValue
    }
}
class CategoryDTo {
    
    var id               : String!
    var cat_name            : String!
    var isSelected : Bool = false
    var img : String!
    var subcat_id:String!
    var subcat_name:String!
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        cat_name             = parseData["cat_name"].stringValue
        id          = parseData["id"].stringValue
        img = parseData["cat_image"].stringValue
        subcat_id = parseData["subcat_id"].stringValue
        subcat_name = parseData["subcat_name"].stringValue
    }
}






class LanguageListModel{
    var title: String!
    var lang_code: String!
    var id: String!
    
    
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        title = parseData["title"].stringValue
        lang_code = parseData["lang_code"].stringValue
        id = parseData["id"].stringValue
        
    }
}


class CountriesListModel{
    var shortname: String!
    var name: String!
    var id: String!
    
    
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        shortname = parseData["shortname"].stringValue
        name = parseData["name"].stringValue
        id = parseData["id"].stringValue
        
    }
}


struct mediamodel {
    var mediaassest: PHAsset!
    var thumbnail: UIImage?
    var mediaurl:URL?
    var mediaisvideo: Bool!
    var mediaisimage:Bool!
    
    init(mediaassest: PHAsset? = nil,thumbnail: UIImage? = nil,mediaurl:URL? = nil,mediaisvideo:Bool = false,mediaisimage:Bool = false)
    
    {
        self.mediaassest = mediaassest
        self.thumbnail = thumbnail
        self.mediaurl = mediaurl
        self.mediaisvideo = mediaisvideo
        self.mediaisimage = mediaisimage
        
    }
}


struct similarPrdModel{
    
    var prd_img: String!
    var total_like: String!
    var third_category_id: String!
    var status:String!
    var id:String!
    var description:String!
    var visibility:String!
    var user_id:String!
    var subcategory_id:String!
    var title:String!
    var likeornot:String!
    var created_at:String!
    var total_view:String!
    var wishstatus:String!
    var category_id:String!
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        prd_img = parseData["prd_img"].stringValue
        total_like = parseData["total_like"].stringValue
        third_category_id = parseData["third_category_id"].stringValue
        status = parseData["status"].stringValue
        id = parseData["id"].stringValue
        description = parseData["description"].stringValue
        visibility = parseData["visibility"].stringValue
        user_id = parseData["user_id"].stringValue
        subcategory_id = parseData["subcategory_id"].stringValue
        title = parseData["title"].stringValue
        likeornot = parseData["likeornot"].stringValue
        created_at = parseData["created_at"].stringValue
        total_view = parseData["total_view"].stringValue
        wishstatus = parseData["wishstatus"].stringValue
        category_id = parseData["category_id"].stringValue
    }
}

struct prdDetailModel{
    
    
    var mediaRecord = [mediaRecordModel]()
    var prdRecord = [prdRecordModel]()
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        let mediarec = parseData["mediarec"].arrayValue
        let prdrec = parseData["prdrec"].arrayValue
        mediaRecord.removeAll()
        prdRecord.removeAll()
        
        for media in mediarec{
            let model = mediaRecordModel(fromJson: media)
            mediaRecord.append(model)
        }
        
        for prd in prdrec{
            let model = prdRecordModel(fromJson: prd)
            prdRecord.append(model)
        }
        
        
    }
}


struct mediaRecordModel {
    
    var media_type: String!
    var product_image: String!
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        media_type = parseData["media_type"].stringValue
        product_image = parseData["product_image"].stringValue
        
    }
}


struct prdRecordModel {
    
    var sellersince: String!
    var sellercountrycode: String!
    var sellername: String!
    var prd_id: String!
    var sellerimage: String!
    var batering: String!
    var title: String!
    var sellermobile: String!
    var trade: String!
    var total_view: String!
    var price: String!
    var description: String!
    var selleremail: String!
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        sellersince = parseData["sellersince"].stringValue
        sellercountrycode = parseData["sellercountrycode"].stringValue
        sellername = parseData["sellername"].stringValue
        prd_id = parseData["prd_id"].stringValue
        sellerimage = parseData["sellerimage"].stringValue
        batering = parseData["batering"].stringValue
        title = parseData["title"].stringValue
        trade = parseData["trade"].stringValue
        total_view = parseData["total_view"].stringValue
        price = parseData["price"].stringValue
        description = parseData["description"].stringValue
        selleremail = parseData["selleremail"].stringValue
        
    }
}



struct myWishListPrdModel{
    
    var price: String!
    var visibility: String!
    var total_view: String!
    var created_at:String!
    var user_id:String!
    var image:String!
    var batering:String!
    var trade:String!
    var is_draft:String!
    var shipping_cost_type:String!
    var is_deleted:String!
    var expiry_date:String!
    var third_category_id:String!
    var address:String!
    var rating:String!
    var state_id:String!
    var total_like:String!
    var shipping_cost:String!
    var city_id:String!
    var title:String!
    var product_condition:String!
    var category_id:String!
    var shipping_time:String!
    var hit:String!
    var zip_code:String!
    var under_package:String!
    var quantity:String!
    var country_id:String!
    var currency:String!
    var offer_price:String!
    var subcategory_id:String!
    var id:String!
    var status:String!
    var description:String!
    var is_sold:String!
    var updated_at:String!
    var slug:String!
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        price = parseData["price"].stringValue
        visibility = parseData["visibility"].stringValue
        total_view = parseData["total_view"].stringValue
        created_at = parseData["created_at"].stringValue
        user_id = parseData["user_id"].stringValue
        image = parseData["image"].stringValue
        batering = parseData["batering"].stringValue
        trade = parseData["trade"].stringValue
        is_draft = parseData["is_draft"].stringValue
        shipping_cost_type = parseData["shipping_cost_type"].stringValue
        is_deleted = parseData["is_deleted"].stringValue
        created_at = parseData["created_at"].stringValue
        total_view = parseData["total_view"].stringValue
        expiry_date = parseData["expiry_date"].stringValue
        third_category_id = parseData["third_category_id"].stringValue
        address = parseData["address"].stringValue
        rating = parseData["rating"].stringValue
        state_id = parseData["state_id"].stringValue
        total_like = parseData["total_like"].stringValue
        shipping_cost = parseData["shipping_cost"].stringValue
        city_id = parseData["city_id"].stringValue
        title = parseData["title"].stringValue
        product_condition = parseData["product_condition"].stringValue
        shipping_time = parseData["shipping_time"].stringValue
        hit = parseData["hit"].stringValue
        category_id = parseData["category_id"].stringValue
        under_package = parseData["under_package"].stringValue
        zip_code = parseData["zip_code"].stringValue
        quantity = parseData["quantity"].stringValue
        country_id = parseData["country_id"].stringValue
        currency = parseData["currency"].stringValue
        offer_price = parseData["offer_price"].stringValue
        subcategory_id = parseData["subcategory_id"].stringValue
        id = parseData["id"].stringValue
        status = parseData["status"].stringValue
        description = parseData["description"].stringValue
        is_sold = parseData["is_sold"].stringValue
        updated_at = parseData["updated_at"].stringValue
        slug = parseData["slug"].stringValue
        
    }
}

struct prdReviewRatingModel{
    var rating: String!
    var ratingdate: String!
    var user_name: String!
    var comment:String!
    
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        rating = parseData["rating"].stringValue
        ratingdate = parseData["ratingdate"].stringValue
        user_name = parseData["user_name"].stringValue
        comment = parseData["comment"].stringValue
    }
}


struct followsModel {
    var userid: String!
    var following_id: String!
    var follower_id: String!
    var user_name:String!
    var email:String!
    var image:String!
    var option:String!
    
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        userid = parseData["userid"].stringValue
        following_id = parseData["following_id"].stringValue
        follower_id = parseData["follower_id"].stringValue
        user_name = parseData["user_name"].stringValue
        email = parseData["email"].stringValue
        image = parseData["image"].stringValue
        option = parseData["option"].stringValue
    }
}


struct myAdsModel{
    var id: String!
    var title: String!
    var status: String!
    var visibility:String!
    var total_like:String!
    var total_view:String!
    var created_at:String!
    var expiry_date:String!
    var file_name:String!
    var productstatus:String!
    var tradestatus:String!
    
    
    init(fromJson parseData: JSON!){
        
        if parseData.isEmpty{
            return
        }
        
        id = parseData["id"].stringValue
        title = parseData["title"].stringValue
        status = parseData["status"].stringValue
        visibility = parseData["visibility"].stringValue
        total_like = parseData["total_like"].stringValue
        total_view = parseData["total_view"].stringValue
        created_at = parseData["created_at"].stringValue
        expiry_date = parseData["expiry_date"].stringValue
        file_name = parseData["file_name"].stringValue
        productstatus = parseData["productstatus"].stringValue
        tradestatus = parseData["tradestatus"].stringValue
    }
}



