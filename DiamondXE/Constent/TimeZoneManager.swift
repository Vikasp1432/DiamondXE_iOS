//
//  TimeZoneManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/06/24.
//

import Foundation
import UIKit

class TimeZoneMatcher {
    
    // Static list of time zones and their corresponding country codes
    private let timeZoneDict: [String: String] = [
        "America/Adak": "US",
        "America/Anchorage": "US",
        "America/Boise": "US",
        "America/Chicago": "US",
        "America/Denver": "US",
        "America/Detroit": "US",
        "America/Indiana/Indianapolis": "US",
        "America/Indiana/Knox": "US",
        "America/Indiana/Marengo": "US",
        "America/Indiana/Petersburg": "US",
        "America/Indiana/Tell_City": "US",
        "America/Indiana/Vevay": "US",
        "America/Indiana/Vincennes": "US",
        "America/Indiana/Winamac": "US",
        "America/Juneau": "US",
        "America/Kentucky/Louisville": "US",
        "America/Kentucky/Monticello": "US",
        "America/Los_Angeles": "US",
        "America/Menominee": "US",
        "America/Metlakatla": "US",
        "America/New_York": "US",
        "America/Nome": "US",
        "America/North_Dakota/Beulah": "US",
        "America/North_Dakota/Center": "US",
        "America/North_Dakota/New_Salem": "US",
        "America/Phoenix": "US",
        "America/Sitka": "US",
        "America/Yakutat": "US",
        "Pacific/Honolulu": "US",
        "Europe/London": "GB",
        "Asia/Dubai": "AE",
        "Asia/Singapore": "SG",
        "Pacific/Auckland": "NZ",
        "Pacific/Chatham": "NZ",
        "Asia/Calcutta": "IN",
        "Asia/Kolkata": "IN",
        "America/Atikokan": "CA",
        "America/Blanc": "CA",
        "America/Cambridge_Bay": "CA",
        "America/Creston": "CA",
        "America/Dawson": "CA",
        "America/Dawson_Creek": "CA",
        "America/Edmonton": "CA",
        "America/Fort_Nelson": "CA",
        "America/Glace_Bay": "CA",
        "America/Goose_Bay": "CA",
        "America/Halifax": "CA",
        "America/Inuvik": "CA",
        "America/Iqaluit": "CA",
        "America/Moncton": "CA",
        "America/Nipigon": "CA",
        "America/Pangnirtung": "CA",
        "America/Rainy_River": "CA",
        "America/Rankin_Inlet": "CA",
        "America/Regina": "CA",
        "America/Resolute": "CA",
        "America/St_Johns": "CA",
        "America/Swift_Current": "CA",
        "America/Thunder_Bay": "CA",
        "America/Toronto": "CA",
        "America/Vancouver": "CA",
        "America/Whitehorse": "CA",
        "America/Winnipeg": "CA",
        "America/Yellowknife": "CA",
        "Antarctica/Macquarie": "AU",
        "Australia/Adelaide": "AU",
        "Australia/Brisbane": "AU",
        "Australia/Broken_Hill": "AU",
        "Australia/Currie": "AU",
        "Australia/Darwin": "AU",
        "Australia/Eucla": "AU",
        "Australia/Hobart": "AU",
        "Australia/Lindeman": "AU",
        "Australia/Lord_Howe": "AU",
        "Australia/Melbourne": "AU",
        "Australia/Perth": "AU",
        "Australia/Sydney": "AU"
    ]
    
    private func getDeviceTimeZoneIdentifier() -> String {
           return TimeZone.current.identifier
       }
       
       // Method to find and return the matching time zone and country code
       func findAndPrintMatchingTimeZone() -> (String, String?) {
           let deviceTimeZoneIdentifier = getDeviceTimeZoneIdentifier()
           
           if let countryCode = timeZoneDict[deviceTimeZoneIdentifier] {
               return (deviceTimeZoneIdentifier, countryCode)
           } else {
               return (deviceTimeZoneIdentifier, nil)
           }
       }
}
