//
//  QuoteView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/26.
//

import Foundation
import SwiftUI

struct QuoteView: View {
    let length:String
    @State private var quoteTitle:String = ""
    @State private var quoteSubTitle:String = ""
    
    init(length: String) {
        self.length = length
    }
    func setRandomShorteQuote() {
        let randomInt = getRandomNumber()
        self.quoteTitle = Constants.shotQuotes[randomInt]
        self.quoteSubTitle = Constants.shotQuoteBy[randomInt]
    }
    
    func setRandomLongQuote() {
        let randomInt = getRandomNumber()
        self.quoteTitle = Constants.longQuotes[randomInt]
        self.quoteSubTitle = Constants.longQuotesBy[randomInt]
    }
    
    private func getRandomNumber() -> Int {
        Int.random(in: 0...Constants.longQuotes.count - 1)
    }
    
    
    var body: some View {
        
        VStack {
            Text(quoteTitle)
                .multilineTextAlignment(.center)
            Text(quoteSubTitle)
        }.onAppear {
            if self.length == "short" {
                self.setRandomShorteQuote()
            } else {
                self.setRandomLongQuote()
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(length: "short")
    }
}
