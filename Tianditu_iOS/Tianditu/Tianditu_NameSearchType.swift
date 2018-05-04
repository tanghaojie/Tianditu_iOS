//
//  Tianditu_NameSearchType.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import JTFramework
enum Tianditu_NameSearchType: String {
    
    static let allValues = [unknown]
    
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
    
    case _delicious = "美食"
    case _hotpot = "火锅"
    case _specialSnackFood = "特色小吃"
    case _japanFood = "日本料理"
    case _sichuanFood = "川菜"
    case _carStation = "汽车站"
    case _subwayStation = "地铁站"
    case _trainStation = "火车站"
    case _GAS = "加油站"
    case _parkingLot = "停车场"
    case _carServiceArea = "服务区"
    case _starHotel = "星级宾馆"
    case _businessHotel = "商务宾馆"
    case _guestHotel = "招待所"
    case _supermarket = "超市"
    case _mall = "商场"
    case _digitalAndElectricStore = "数码电器"
    case _furnitureBuildingMaterials = "家具建材"
    case _localSpecialty = "地方特产"
    case _KTV = "KTV"
    case _movieTheater = "电影院"
    case _theater = "剧院"
    case _bar = "酒吧"
    case _internetCafe = "网吧"
    case _park = "公园"
    case _exercise = "健身"
    case _badminton = "羽毛球"
    case _swim = "游泳"
    case _yoga = "瑜伽"
    case _golf = "高尔夫"
    case _tennis = "网球"
    case _bank = "银行"
    case _ATM = "ATM"
    case _securities = "证劵"
    case _hospital = "医院"
    case _drugStore = "药店"
    case _clinic = "诊所"
    case _healthCare = "保健"
    case _medicalExamination = "体检"
    case _animalHospital = "动物医院"
    case _ticketSales = "售票处"
    case _waterAndElectricityAndGas = "水电气"
    case _beautySalons = "美容美发"
    case _toilet = "公共卫生间"
    case _housingAgency = "房屋中介"
    case _education = "教育"
    case _entertainment = "娱乐"
    case _safetyAndFireAndEmergency = "公安消防应急"
    case _station = "车站"
}
extension Tianditu_NameSearchType: JTEnum {
    var strNum: String {
        switch self {

        case .naturalGeographicalName: return "01"
            
        case .humanGeographicalName: return "02"
        case ._station: return "02305"
        case ._trainStation: return "0230501"
        case ._subwayStation: return "0230503"
        case ._carStation: return "0230505"
        
        case .goverment: return "03"
            
        case ._education: return "04"
        case .middleAndPrimarySchool: return "041"
        case .college: return "042"
            
        case .healthCare: return "05"
        case ._hospital: return "0510001"
        case ._clinic: return "0510010"
        case ._medicalExamination: return "0520002"
        case ._healthCare: return "053"
        case ._animalHospital: return "054"
        case ._drugStore: return "055"
            
        case ._delicious: return "06"
        case .exoticismFood: return "061"
        case .chineseFood: return "062"
        case ._sichuanFood: return "0620001"
        case .specialDelicousFood: return "063"
        case ._hotpot: return "0630001"
        case ._japanFood: return "0630006"
        case ._specialSnackFood: return "0630008"
        case .cookedFoodStore: return "064"
    
        case .entertainment: return "07"
        case .culturalFacilities: return "071"
        case ._entertainment: return "072"
        case ._park: return "0720001"
        case ._movieTheater: return "0720005"
        case ._theater: return "0720006"
        case ._KTV: return "0720008"
        case ._bar: return "0720015"
        case ._internetCafe: return "0720016"
        case .exercise: return "073"
        case ._swim: return "0730002"
        case ._golf: return "0730004"
        case ._badminton: return "0730005"
        case ._tennis: return "0730006"
        case ._exercise: return "0730008"
        case ._yoga: return "0730009"
   
        case .travel: return "074"
            
        case .hotel: return "08"
        case ._starHotel: return "0810001"
        case ._businessHotel: return "0810002"
        case ._guestHotel: return "0810004"
            
        case .religion: return "09"
            
        case .shoppingService: return "10"
        case ._supermarket: return "1010002"
        case ._mall: return "1010004"
        case ._digitalAndElectricStore: return "102"
        case ._localSpecialty: return "103"
        case ._furnitureBuildingMaterials: return "105"
            
        case .financeAndInsurance: return "11"
        case ._bank: return "1110002"
        case ._ATM: return "11100052"
        case ._securities: return "113"
    
        case .carService: return "12"
        case ._GAS: return "1200001"
        case ._parkingLot: return "1200002"
        case ._carServiceArea: return "1200003"
            
        case .dailyService: return "13"
        case ._waterAndElectricityAndGas: return "131"
        case ._housingAgency: return "1320004"
        case ._beautySalons: return "1320005"
        case ._toilet: return "1320016"
        case ._ticketSales: return "133"
     
        case .mediaAndCommunication: return "14"
            
        case ._safetyAndFireAndEmergency: return "15"
            
        case .company: return "16"
            
        case .welfareInstitution: return "17"

            
        case .unknown: return ""
   
        }
    }
    var image: UIImage? {
        return nil
    }
}
