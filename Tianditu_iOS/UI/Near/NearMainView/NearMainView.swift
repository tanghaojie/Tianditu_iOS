//
//  NearMainView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/3.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class NearMainView: UIView, JTNibLoader {
   
    @IBAction func main_DeliciousTpuchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._delicious
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_HotelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.hotel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_ParkingLotTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._parkingLot
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_StationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._station
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_ATMTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._ATM
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_EntertainmentTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.entertainment
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_shoppingTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.shoppingService
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_GASTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._GAS
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_HealthCareTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.healthCare
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func main_ToiletTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._toilet
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    @IBAction func deliciousTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._delicious
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func sichuanFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._sichuanFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func chineseFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.chineseFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func hotpotTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._hotpot
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func specialDeliciousFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.specialDelicousFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func exoticismFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.exoticismFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func japanFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._japanFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func specialSnackFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._specialSnackFood
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func cookedFoodTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.cookedFoodStore
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    @IBAction func entertainmentTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.entertainment
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func culturalFacilitiesTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.culturalFacilities
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func parkTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._park
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func movieThreaterTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._movieTheater
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func threaterTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._theater
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func entertainmentSubTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._entertainment
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func KTVTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._KTV
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func barTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._bar
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func internetCafeTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._internetCafe
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func exerciseTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._exercise
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func swimTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._swim
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func golfTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._golf
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func badmintonTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._badminton
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func tennisTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._tennis
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func yogaTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._yoga
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func shoppingServiceTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.shoppingService
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func supermarketTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._supermarket
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func mallTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._mall
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func digitalAndEletricStoreTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._digitalAndElectricStore
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func localSpecialtyTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._localSpecialty
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func furnitureBuildingMaterialsTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._furnitureBuildingMaterials
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func dailyServiceTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.dailyService
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func waterAndElectricityAndGasTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._waterAndElectricityAndGas
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func housingAgencyTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._housingAgency
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func beautySalonsTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._beautySalons
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func ticketSalesTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._ticketSales
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func toiletTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._toilet
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    
    @IBAction func hotelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.hotel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func starHotelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._starHotel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func businessHotelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._businessHotel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func guestHotelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._guestHotel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    
    @IBAction func healthCareTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.healthCare
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func hospitalTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._hospital
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func clinicTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._clinic
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func medicalExaminationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._medicalExamination
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func healthCareSubTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._healthCare
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func animalHospitalTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._animalHospital
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func drugStoreTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._drugStore
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func stationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._station
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func trainStationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._trainStation
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func subwayStationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._subwayStation
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func carStationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._carStation
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func financeAndInsuranceTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.financeAndInsurance
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func bankTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._bank
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func ATMTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._ATM
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func securitiesTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._securities
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func educationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._education
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func collegeTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.college
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func middleAndPrimarySchoolTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.middleAndPrimarySchool
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func carServiceTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.carService
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func gasTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._GAS
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func parkingLotTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._parkingLot
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    @IBAction func carServiceAreaTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType._carServiceArea
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func travelTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.travel
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
    
    
    @IBAction func mediaAndCommunicationTouchUpInside(_ sender: Any) {
        let type = Tianditu_NameSearchType.mediaAndCommunication
        let v = SearchMapViewController(type: type, withEnvelope: true)
        jtGetResponder()?.navigationController?.pushViewController(v, animated: false)
    }
}
