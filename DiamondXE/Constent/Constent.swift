//
//  Constent.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/04/24.
//

import Foundation
import UIKit

var getAppVersion = "Version - \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"


struct ConstentString {
    static let emailErr = "Email is required."
    static let passErr = "Password is required."
    static let oldpassErr = "Old Password is required."
    static let newpassErr = "New Password is required."
    static let confirmpassErr = "Confirm Password is required."
    
    static let firestNErr = "First name is required."
    static let lastNErr = "Last name is required."
    static let mobileErr = "Phone number is required."
    static let cnPassErr = "Confirm Password is required."
    static let cityPin = "City pin code is required."
    static let address = "Adress is required."
    static let cityErr = "City name is required."
    static let stateErr = "State name is required."
    static let countryErr = "Country name is required."
    static let gstErr = "GST number is required."
    static let panErr = "PAN number is required."
    static let copnayTypeError = "Company type is required."
    static let copnayNameError = "Company name is required."
}

struct TVCellIdentifire {
    static let buyerCell1 = "BuyerCell1"
    static let dealer_KycCell = "Dealer_KYCCell"
    static let dealer_headerCell = "Dealer_HeaderView"

    static let dealer_BasicCell = "Dealer_BasicCell"
    static let dealer_OtherDocCell = "Dealer_OtherDocCell"
    static let dealer_CompanyDetailCell = "Dealer_CompanyDetailsCell"
    static let supplier_CompanyDetailCell = "Supplier_CompanyDetails"
    static let supplier_BankInfoCell = "Supplier_BankInfoCell"
    static let supplier_AuthoriseInfoCell = "Supplier_AuthorisedPersonCell"
    static let fotterCell = "FooterCell"
    
     static let customAlertStoryboardName = "CustomAlerts"
     static let customAlertController = "CountryListVC"
}


// my account
var account_ = "My Account"
var account_order = "My Order"
var account_wallet = "Wallet"
var account_auction = "Auction"
var account_markup = "Dealer Markup"
var account_refer = "Refre a Friend"
var account_program = "loyalty Program"
var account_payment = "Custom Payment"
var account_solution = "API Solution"
var account_delete = "Delete Account"
var account_profile = "Profile"
var account_address = "Address"
var account_kycV = "KYC Verification"
var account_password = "Change Password"


// Other Strings
var nv_home = "Home"
var nv_searchDiamond = "Search Diamonds"
var nv_createDemand = "Create Demand"
var nv_jewellery = "Jewellery"
var nv_DXELUX = "DXE LUXE"
var nv_diamondEducation = "Diamond Education"
var nv_explore = "Explore Now"
var nv_priceCalc = "Price Calculator"
var nv_more = "More"
var nv_contactUS = "Contact us"
var nv_rateUS = "Rate us"
var nv_logout = "Logout"
var nv_logIN = "Login"


var nv_naturalDiamond = "Natural Diamond"
var nv_labGrownDiamond = "Lab Grown Diamond"
//var nv_fancyDiamond = "Fancy Colour Diamond"
var nv_rings = "Rings"
var nv_earrings = "Earrings"
var nv_pendent = "Pendants"
var nv_bracelets = "Bracelets"
var nv_bangles = "Bangles"
var nv_jeweller = "Jeweller"
var nv_supplier = "Supplier"
var nv_aboutUS = "About us"
var nv_whyUS = "Why us"
var nv_blogs = "Blogs"
var nv_mediaGalley = "Media Galley"
var nv_support = "Support"
var nv_termCondition = "Terms & Conditions"
var nv_privacyPolicy = "Privacy Policy"
var nv_emial = "support@diamondxe.com"
var nv_whatsapp = "+91 9892003399"

var nv_searchDiamondICN = [UIImage(named: "Natural Diamonds")!,UIImage(named: "Lab-Grown Diamonds")!]//,UIImage(named: "Fancy Diamonds")!

var nv_jewelleryICN = [UIImage(named: "Rings")!,UIImage(named: "Earrings")!,UIImage(named: "Pendant")!,UIImage(named: "Bracelet")!,UIImage(named: "Bangles")!]

var nv_exploreICN = [UIImage(named: "Jeweller")!,UIImage(named: "Supplier")!]

var nv_moreICN = [UIImage(named: "About us")!,UIImage(named: "Why Us")!,UIImage(named: "Blog")!,UIImage(named: "Media Gallery")!,UIImage(named: "contact")!,UIImage(named: "t&c")!,UIImage(named: "privacyPolicy")!]

var nv_contactICN = [UIImage(named: "Email")!,UIImage(named: "Contact Us")!]

// var nv_mainICN = [UIImage(named: "Home")!,UIImage(named: "Search Diamonds")!,UIImage(named: "Create Demand")!,UIImage(named: "jewellery")!,UIImage(named: "DXE LUXE")!,UIImage(named: "Diamond Education")!,UIImage(named: "Explore Now")!,UIImage(named: "Price Calculator")!,UIImage(named: "More")!,UIImage(named: "Support")!,UIImage(named: "Rate us")!,UIImage(named: "logout")!]

var nv_mainICN = [UIImage(named: "Home")!,UIImage(named: "Search Diamonds")!,UIImage(named: "Diamond Education")!,UIImage(named: "Explore Now")!,UIImage(named: "Price Calculator")!,UIImage(named: "More")!,UIImage(named: "Support")!,UIImage(named: "Rate us")!,UIImage(named: "logout")!]



//var account_icons = [UIImage(named: "myAccount")!,UIImage(named: "myOrder")!,UIImage(named: "wallet")!,UIImage(named: "acution")!,UIImage(named: "dealerMarkup")!,UIImage(named: "referAFriend")!,UIImage(named: "loyaltyProgram")!,UIImage(named: "customPayment")!,UIImage(named: "apiSolutions")!,UIImage(named: "delteAccount")!]

var account_icons = [UIImage(named: "myAccount")!,UIImage(named: "myOrder")!,UIImage(named: "dealerMarkup")!,UIImage(named: "customPayment")!,UIImage(named: "delteAccount")!]

var account_Profileicons = [UIImage(named: "profile")!,UIImage(named: "address")!,UIImage(named: "kvcVerification")!,UIImage(named: "Change Password")!]

var nv_mainTitle = [ nv_home,
                     nv_searchDiamond,
                     nv_createDemand,
                     nv_jewellery,
                     nv_DXELUX,
                     nv_diamondEducation,
                     nv_explore,
                     nv_priceCalc,
                     nv_more,
                     nv_contactUS,
                     nv_rateUS,
                     nv_naturalDiamond,
                     nv_labGrownDiamond,
                    // nv_fancyDiamond,
                     nv_rings,
                     nv_earrings,
                     nv_pendent,
                     nv_bracelets,
                     nv_bangles,
                     nv_jeweller,
                     nv_supplier,
                     nv_aboutUS,
                     nv_whyUS,
                     nv_blogs,
                     nv_mediaGalley,
                     nv_support,
                     nv_logout]


var fancyColor = ["Yellow-Bn",
                  "Green-Blue",
                  "Brown-Pink",
                  "Black",
                  "Blue",
                  "Brown",
                  "Gray",
                  "Gray-Blue",
                  "Green",
                  "Yellow",
                  "Orange",
                  "Other",
                  "Pink",
                  "Purple",
                  "Red",
                  "Violet",
                  "Pink-Brown"]

var attributeTypeWhite = "STONE COLOR"
var attributeTypeFancy = "FANCY COLOR"
var attributeTypeClarity = "CLARITY"
var attributeTypeCertificate = "LAB NAME"
var attributeTypeFluorescence = "FLUORESCENCE INTENSITY"
var attributeTypeMake = "MAKE"

var attributeTypeCut = "CUT GRADE"
var attributeTypePolish = "POLISH"
var attributeTypSymmetry = "SYMMETRY"
var attributeTypeTechnology = "TECHNOLOGY"

var attributeTypeIntensity = "FANCY COLOR INTENSITY"
var attributeTypeOvertone = "FANCY COLOR OVERTONE"
var attributeTypTablePer = "TABLE PERCENTAGE"
var attributeTypeDepthPer = "DEPTH PERCENTAGE"
var attributeTypePavillion = "PAVILION ANGLE"
var attributeTypeCrown = "CROWN ANGLE"

var attributeTypeEyeClean = "EYE CLEAN"
var attributeTypeShade = "SHADE"
var attributeTypeLuster = "LUSTER"




// calc DXE ConstentVal

var diamondShapes = ["Round","Pear", "Princess", "Marqise", "Sq. Emerald", "Oval", "Radiant", "Emerald","Trilliant", "Heart", "European Cut", "Old Miner", "Flanders", "Cushion Brilliant", "Cushion Modified","Baguette", "Kite", "Star", "Other", "Half Moon", "Trapezoid", "Bullets", "Hexagonal", "Lozenge", "Pentagonal", "Rose", "Shield", "Square", "Triangular", "Briolette", "Octagonal", "Tapered Baguette", "Calf", "Circular", "Circular Brilliant"]
var diamondColor = ["D","E", "F", "G", "H", "I", "J", "K","L", "M"]
var diamondClarity = ["IF", "VVS1", "VVS2", "VS1", "VS2", "SI1", "SI2","SI3", "I1", "I2", "I3"]
