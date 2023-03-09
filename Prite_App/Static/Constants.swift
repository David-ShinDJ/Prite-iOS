//
//  Constants.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/26.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class Constants {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 37.5511, longitude: 126.9882)
    static let mapMagnitude = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)

    static let shotQuotes = [
        "작가란 오늘 아침에 글을 쓴 사람이다",
        "작가는 다른 사람들보다 글쓰기를 어려워 하는 사람이다.",
        "제대로 쓰려고 말고, 무조건 써라.",
        "인류에 대해 쓰지말고, 한 인간에 대해 쓰라.",
        "지금 쓰고 있는 글을 당신이 즐기지 못하면 아무도, 즐기지 못한다.",
        "말하는 것처럼 쓰라.",
        "나는 일필휘지를 믿지 않는다",
        
    ]
    
    static let shotQuoteBy = [
        "-로버타 진 브라이언트-",
        "-토마스만-",
        "-제임스 서버-",
        "-엘윈 브룩 화이트-",
        "-마르티나 콜-",
        "-볼테르-",
        "-최명희-"
    ]
    
    static let longQuotes = [
        "글을 쓰고 싶다면 종이와 펜 혹은 컴퓨터, 그리고 약간의 배짱만 있으면 된다.",
        "당신만이 전할 수 있는 이야기를 써라 당신보다 더 똑똑하고 우수한 작가들은 많다.",
        "글쓰기 재능을 연마하기 전에 뻔뻔함을 기르라고 말하고 싶다.",
        "가능한 자주 글을 써라 그게 출판 될 거라는 생각으로가 아니라, 악기 연주를 배운다는 생각으로.",
        "바빠서 글을 쓸 수 없다는 사람은 시간이 있어도 글을 쓰지 못한다.",
        "영감이 찾아오길 기다려선 안된다, 몽둥이를 들고 그걸 쫒아가야 한다.",
        "당신이 읽고 싶은 책이 있는데, 그 이야기가 책으로 나오지 않았다면, 당신은 그 이야기를 쓰면 된다."
        
        
    ]

    static let longQuotesBy = [
        "-로버타 진 브라이언트-",
        "-닐 게이먼-",
        "-하퍼 리-",
        "-J. B. 프리슬리-",
        "-찰스 램-",
        "-잭 런던-",
        "-토니 모리슨-"
    ]

}

class Example {
    private let images:[Image] = [
        Image("image0"),
        Image("image0"),
        Image("image0"),
        Image("image0"),
        Image("image0"),
        Image("image0")]
    private let titles:[String] = [
        "아메리칸 국도투어",
        "아메리칸 국도투어",
        "아메리칸 국도투어",
        "아메리칸 국도투어"
    ]
    private let descriptions:[String] = [
        "무작정 떠난 국도투어 설레는 마음에 시작을 알리는 사진을 한반 찍어본다. 지금의 느김을 언젠가 다시 느끼기위해 이렇게 글을 작성한다 이곳의 날씨와 모습들은 생생히 묘사 가능하다 전날까지 비가왔지만 비온뒤 맑음이 되듯이 하늘이 뻥뚫려있고 그로인해서 상쾌한공기가 맑게 들이마셔진다. 도로의 냄새는 풀냄새가 조금나고 매우 커다란 절벅과 바위에서 느껴지는 무색무취의 강렬한 향이 존재하는거같다 배낭한개와 국도를 투어하는 자동차하나만 있으면 못 갈곳도 없다 지금 느끼는 자유야 말로 해방감에 제일 가까운것같다..",
        "무작정 떠난 국도투어 설레는 마음에 시작을 알리는 사진을 한반 찍어본다. 지금의 느김을 언젠가 다시 느끼기위해 이렇게 글을 작성한다 이곳의 날씨와 모습들은 생생히 묘사 가능하다 전날까지 비가왔지만 비온뒤 맑음이 되듯이 하늘이 뻥뚫려있고 그로인해서 상쾌한공기가 맑게 들이마셔진다. 도로의 냄새는 풀냄새가 조금나고 매우 커다란 절벅과 바위에서 느껴지는 무색무취의 강렬한 향이 존재하는거같다 배낭한개와 국도를 투어하는 자동차하나만 있으면 못 갈곳도 없다 지금 느끼는 자유야 말로 해방감에 제일 가까운것같다..",
        "무작정 떠난 국도투어 설레는 마음에 시작을 알리는 사진을 한반 찍어본다. 지금의 느김을 언젠가 다시 느끼기위해 이렇게 글을 작성한다 이곳의 날씨와 모습들은 생생히 묘사 가능하다 전날까지 비가왔지만 비온뒤 맑음이 되듯이 하늘이 뻥뚫려있고 그로인해서 상쾌한공기가 맑게 들이마셔진다. 도로의 냄새는 풀냄새가 조금나고 매우 커다란 절벅과 바위에서 느껴지는 무색무취의 강렬한 향이 존재하는거같다 배낭한개와 국도를 투어하는 자동차하나만 있으면 못 갈곳도 없다 지금 느끼는 자유야 말로 해방감에 제일 가까운것같다..",
        "무작정 떠난 국도투어 설레는 마음에 시작을 알리는 사진을 한반 찍어본다. 지금의 느김을 언젠가 다시 느끼기위해 이렇게 글을 작성한다 이곳의 날씨와 모습들은 생생히 묘사 가능하다 전날까지 비가왔지만 비온뒤 맑음이 되듯이 하늘이 뻥뚫려있고 그로인해서 상쾌한공기가 맑게 들이마셔진다. 도로의 냄새는 풀냄새가 조금나고 매우 커다란 절벅과 바위에서 느껴지는 무색무취의 강렬한 향이 존재하는거같다 배낭한개와 국도를 투어하는 자동차하나만 있으면 못 갈곳도 없다 지금 느끼는 자유야 말로 해방감에 제일 가까운것같다.."
    ]
    
    func getImage(number:Int) -> Image {
        self.images[number]
    }
    func getTitle(number:Int) -> String {
        self.titles[number]
    }
    func getDescription(number:Int) -> String {
        self.descriptions[number]
    }

}


var dateString:String {
    let nowDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.string(from: nowDate)
}
