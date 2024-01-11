//
//  WeatherKitExtension.swift
//  whatseason
//
//  Created by namdghyun on 1/11/24.
//

import WeatherKit

extension WeatherCondition {
    /// 날씨 상태를 한글로 변환하는 메서드입니다.
    func translateWeatherCondition() -> String {
        switch self {
        case .blizzard:
            return "눈보라"
        case .blowingDust:
            return "먼지바람"
        case .blowingSnow:
            return "눈바람"
        case .breezy:
            return "약한 바람"
        case .clear:
            return "맑음"
        case .cloudy:
            return "흐림"
        case .drizzle:
            return "이슬비"
        case .flurries:
            return "소나기"
        case .foggy:
            return "안개"
        case .freezingDrizzle:
            return "얼어붙는 이슬비"
        case .freezingRain:
            return "얼어붙는 비"
        case .frigid:
            return "추위"
        case .hail:
            return "우박"
        case .haze:
            return "실안개"
        case .heavyRain:
            return "폭우"
        case .heavySnow:
            return "폭설"
        case .hot:
            return "더위"
        case .hurricane:
            return "허리케인"
        case .isolatedThunderstorms:
            return "간헐적 뇌우"
        case .mostlyClear:
            return "대체로 맑음"
        case .mostlyCloudy:
            return "대체로 흐림"
        case .partlyCloudy:
            return "구름 조금"
        case .rain:
            return "비"
        case .scatteredThunderstorms:
            return "산발적 뇌우"
        case .sleet:
            return "진눈깨비"
        case .smoky:
            return "연기"
        case .snow:
            return "눈"
        case .strongStorms:
            return "강한 폭풍"
        case .sunFlurries:
            return "해"
        case .sunShowers:
            return "여우비"
        case .thunderstorms:
            return "뇌우"
        case .tropicalStorm:
            return "열대폭풍"
        case .windy:
            return "바람"
        case .wintryMix:
            return "차가운 바람"
        default:
            return "알 수 없음"
        }
    }
    
    /// 날씨 상태에 맞는 Lottie 배경 Asset 이름을 반환하는 메서드입니다.
    func conditionToLottieName() -> String {
        switch self {
            /*
             case .mostlyCloudy:
             return "cloudy-bg"
             */
        default:
            return "spring-bg"
        }
    }
}
