//
//  KaKaoBook.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//


import Foundation

struct KaKaoBook: Codable {
    let title: String
    let authors: [String]
    let price: Int
    let thumbnail: String
    let contents: String
}
