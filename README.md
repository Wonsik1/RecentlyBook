# 📚 RecentlyBook

책을 검색하고, 최근 본 책과 내가 담은 책을 관리할 수 있는 iOS 앱입니다.  
카카오 책 검색 API를 활용하여 실시간 검색 기능을 제공하며,  
Core Data를 활용해 원하는 책을 저장할 수 있습니다.

---

## 🧑‍💻 개발 환경

- iOS 17+
- Xcode 15.0+
- Swift 5.0
- UIKit + SnapKit
- Core Data
- Kakao Book API

---

## 📌 주요 기능

### 🔍 책 검색
- 카카오 책 검색 API를 사용하여 실시간 책 검색
- 제목, 저자, 가격 등 기본 정보 표시
- 셀 클릭 시 상세 정보 확인 가능

### 🕘 최근 본 책
- 책 상세페이지를 열면 자동으로 최근 본 책 리스트에 추가
- 최근 10개까지 저장 가능

### 📥 담은 책 관리
- 상세 페이지에서 ‘담기’ 버튼을 누르면 Core Data에 저장
- 저장된 책은 담은 책 탭에서 목록으로 확인 가능
- 개별 삭제, 전체 삭제 기능 제공

---


## 🗂️ 디렉토리 구조

---
```
RecentlyBook/
├── Controller/
│   ├── DetailViewController.swift         // 책 상세 화면
│   ├── MainTabBarController.swift         // 탭바 컨트롤러
│   ├── RecentBookCell.swift               // 최근 본 책 셀
│   ├── SaveCell.swift                     // 담은 책 셀
│   ├── SavedBookViewController.swift      // 담은 책 리스트
│   ├── SearchCell.swift                   // 검색 결과 셀
│   └── SearchCollectionViewController.swift // 검색 리스트 화면
│
├── Model/
│   ├── CoreDataManager.swift              // CoreData 저장/불러오기
│   ├── KaKaoBook.swift                    // KakaoBook 모델
│   └── RecentlyViewedManager.swift        // 최근 본 책 UserDefaults 관리
│
├── View/
│   ├── DetailView.swift                   // 상세 화면 구성
│   ├── SavedBookView.swift                // 담은 책 화면 구성
│   └── SearchBookView.swift               // 검색 결과 화면 구성
│
├── BookModel.xcdatamodeld                 // CoreData 모델
```
## 📦 API Key 설정 방법

1. Kakao Developers에서 REST API 키 발급
2. `URLRequest` Header에 아래 형식으로 포함

```swift
request.setValue("KakaoAK [발급받은 키]", forHTTPHeaderField: "Authorization")
