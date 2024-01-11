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
    
    func conditionToDayIconName() -> String {
        switch self {
        case .blizzard:
            return "extream-snow"
        case .blowingDust:
            return "dust-wind"
        case .blowingSnow:
            return "wind-snow"
        case .breezy:
            return "wind"
        case .clear:
            return "clear-day"
        case .cloudy:
            return "cloudy"
        case .drizzle:
            return "drizzle"
        case .flurries:
            return "rain"
        case .foggy:
            return "fog"
        case .freezingDrizzle:
            return "drizzle"
        case .freezingRain:
            return "sleet"
        case .frigid:
            return "thermometer-snow"
        case .hail:
            return "hail"
        case .haze:
            return "haze"
        case .heavyRain:
            return "extreme-rain"
        case .heavySnow:
            return "extreme-Snow"
        case .hot:
            return "thermometer-sun"
        case .hurricane:
            return "hurrincane"
        case .isolatedThunderstorms:
            return "thunderstorms-rain"
        case .mostlyClear:
            return "partly-cloudy-day"
        case .mostlyCloudy:
            return "cloudy"
        case .partlyCloudy:
            return "partly-cloudy-day"
        case .rain:
            return "rain"
        case .scatteredThunderstorms:
            return "thunderstorms"
        case .sleet:
            return "sleet"
        case .smoky:
            return "smoke"
        case .snow:
            return "snow"
        case .strongStorms:
            return "thunderstorms-extream"
        case .sunFlurries:
            return "sun-hot"
        case .sunShowers:
            return "partly-cloudy-day-drizzle"
        case .thunderstorms:
            return "thunderstorms"
        case .tropicalStorm:
            return "hurrincane"
        case .windy:
            return "wind"
        case .wintryMix:
            return "wind-snow"
        default:
            return "알 수 없음"
        }
    }
    
    /// 날씨 상태에 맞는 Lottie 배경 Asset 이름을 반환하는 메서드입니다.
    func conditionToLottieName() -> String {
        switch self {
        case .blizzard:
            return "cloudy-bg"
        case .blowingDust:
            return "cloudy-bg"
        case .blowingSnow:
            return "spring-bg"
        case .breezy:
            return "spring-bg"
        case .clear:
            return "clear-bg"
        case .cloudy:
            return "cloudy-bg"
        case .drizzle:
            return "cloudy-bg"
        case .flurries:
            return "cloudy-bg"
        case .foggy:
            return "cloudy-bg"
        case .freezingDrizzle:
            return "cloudy-bg"
        case .freezingRain:
            return "cloudy-bg"
        case .frigid:
            return "cloudy-bg"
        case .hail:
            return "cloudy-bg"
        case .haze:
            return "cloudy-bg"
        case .heavyRain:
            return "cloudy-bg"
        case .heavySnow:
            return "cloudy-bg"
        case .hot:
            return "cloudy-bg"
        case .hurricane:
            return "cloudy-bg"
        case .isolatedThunderstorms:
            return "cloudy-bg"
        case .mostlyClear:
            return "clear-bg"
        case .mostlyCloudy:
            return "cloudy-bg"
        case .partlyCloudy:
            return "cloudy-bg"
        case .rain:
            return "cloudy-bg"
        case .scatteredThunderstorms:
            return "cloudy-bg"
        case .sleet:
            return "cloudy-bg"
        case .smoky:
            return "cloudy-bg"
        case .snow:
            return "spring-bg"
        case .strongStorms:
            return "cloudy-bg"
        case .sunFlurries:
            return "clear-bg"
        case .sunShowers:
            return "cloudy-bg"
        case .thunderstorms:
            return "cloudy-bg"
        case .tropicalStorm:
            return "cloudy-bg"
        case .windy:
            return "spring-bg"
        case .wintryMix:
            return "cloudy-bg"
        default:
            return "알 수 없음"
        }
    }
}
