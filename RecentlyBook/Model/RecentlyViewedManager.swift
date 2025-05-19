//
//  RecentlyViewedManager.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//


import Foundation

class RecentlyViewedManager { // UserDefaults 기반으로 최근 본 책 목록을 관리하는 매니저 클래스
    static let shared = RecentlyViewedManager()
    private let key = "recentlyViewedBooks"


    func add(_ book: KaKaoBook) {
        var current = fetch()

        current.removeAll { $0.title == book.title && $0.authors == book.authors }
        current.insert(book, at: 0)


        if current.count > 10 {
            current = Array(current.prefix(10))
        }


        if let data = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    
    func fetch() -> [KaKaoBook] { // 저장된 최근 본 책 리스트를 불러오기
        guard let data = UserDefaults.standard.data(forKey: key),
              let books = try? JSONDecoder().decode([KaKaoBook].self, from: data) else {
            return []
        }
        return books
    }

}

