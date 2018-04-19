//
//  Tianditu_NameSearchType.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import JTFramework
enum Tianditu_NameSearchType: String {
    case unknown = ""
    case goverment = "政府机构"
    case company = "企事业单位"
    case naturalGeographicalName = "自然地理名"
    case humanGeographicalName = "人文地理名"
    case middleAndPrimarySchool = "中小学"
    case college = "大学"
    case healthCare = "医疗卫生"
    case exoticismFood = "异国风味"
    case chineseFood = "中餐"
    case specialDelicousFood = "特色美食"
    case cookedFoodStore = "熟食品店"
    case culturalFacilities = "文化设施"
    case entertainment = "休闲娱乐"
    case exercise = "体育健身"
    case travel = "出行旅行"
    case hotel = "宾馆"
    case religion = "宗教设施"
    case shoppingService = "购物服务"
    case financeAndInsurance = "金融保险"
    case carService = "汽车服务"
    case dailyService = "日常服务"
    case mediaAndCommunication = "传媒与通信"
    case welfareInstitution = "福利机构"
}
extension Tianditu_NameSearchType: JTEnum {
    var image: UIImage? {
        return nil
    }
    
    var strNum: String {
        switch self {
        case .unknown: return "0"
        case .goverment: return "03"
        case .company: return "16"
        case .naturalGeographicalName: return "01"
        case .humanGeographicalName: return "02"
        case .middleAndPrimarySchool: return "041"
        case .college: return "042"
        case .healthCare: return "05"
        case .exoticismFood: return "061"
        case .chineseFood: return "062"
        case .specialDelicousFood: return "063"
        case .cookedFoodStore: return "064"
        case .culturalFacilities: return "071"
        case .entertainment: return "072"
        case .exercise: return "073"
        case .travel: return "074"
        case .hotel: return "08"
        case .religion: return "09"
        case .shoppingService: return "10"
        case .financeAndInsurance: return "11"
        case .carService: return "12"
        case .dailyService: return "13"
        case .mediaAndCommunication: return "14"
        case .welfareInstitution: return "17"
        }
    }
}
