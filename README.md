# Table of Contents
1. [Description](#description)
2. [Timeline](#timeline)
3. [Demo](#demo)
4. [Features](#features)
5. [Requirements](#requirements)
6. [Stacks](#stacks)
7. [ProjectStructure](#projectStructure)
8. [Developer](#developer)

# 🔎BookList App📒

<img src="https://img.shields.io/badge/Apple-%23000000.svg?style=for-the-badge&logo=apple&logoColor=white" height="20"> <img src="https://img.shields.io/badge/iOS-17.4%2B-green"> <img src="https://img.shields.io/badge/Library-Combine-orange"> <img src="https://img.shields.io/badge/Library-SnapKit-orange"> <img src="https://img.shields.io/badge/Library-KingFisher-orange"> <img src="https://img.shields.io/badge/Library-Alamofire-orange">

책을 검색하고 담을 수 있는 BookList App!

## Description

원하는 책을 검색하고, 정보확인도 한번에, 담지 않았더라도, 최근 확인 한 책 확인을 통해 정보 재확인도 가능. 책 정보는 이제 한번에 해결하세요.

## Timeline
<details>
   <summary>24.05.04</summary>
    <pre>● UI 기본틀 구성
    </pre>
</details>

<details>
   <summary>24.05.05</summary>
        <pre>● SearchBar 기능 구현
   ○ SearchBar - API Binding
● TableView 구현
   ○ TableView - API Result Binding
● 상세페이지 구현
        </pre>
</details>

<details>
   <summary>24.05.06</summary>
    <pre>● 상세페이지 추가기능 구현
   ○ 돌아가기 기능
   ○ 담기 기능 (Coredata)
    </pre>
</details>

<details>
   <summary>24.05.07</summary>
   <pre>● 최근 본 책 기능 구현
● Wish페이지 구현
● 검색한 내용의 셀 클릭시 코어데이터에 저장 기능 구현 (최근 본 책)
   </pre>
</details>

<details>
   <summary>24.05.08</summary>
   <pre>● Wish페이지에서 추가기능 구현
   ○ 추가 버튼 클릭시 main화면의 searchbar 활성화
   ○ Swipe Action으로 Cell 삭제
   ○ 전체삭제
● 최근 본책 저장된 갯수만 나오던 부분을 최근 기준으로 10개로 한정
   </pre>
</details>

<details>
   <summary>24.05.09</summary>
   <pre>● 무한스크롤 기능 구현
   ○ 타이머를 통한 과도한 Request 방지
● 예외처리
   </pre>
</details>    

<details>
   <summary>24.05.10</summary>
   <pre>● ReadMe 작성
● 예외처리
   </pre>
</details> 

<details>
   <summary>24.05.11</summary>
   <pre>● Network / Coredata Functions VM으로 부터 분리 (Service Group)
● Datasource → DiffableDatasource 적용
   </pre>
</details> 

<details>
   <summary>24.05.12</summary>
   <pre>● 예외처리
   </pre>
</details> 

## Demo
<p float="left">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/8be13234-e646-4c10-992b-0c6af85ac713" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/52bf328c-ee8e-4e5a-9d7c-039d1793c41e" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/4e6081c1-d892-4bdd-82a1-8e414644d4d2" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/1c99c591-f5c9-4dde-8654-7327fa18c43e" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/a95e5a93-d186-4854-838b-e43efe683c4a" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/910c47ab-bb19-457b-bad0-0f2270a11920" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/3b990718-e59c-4429-92fd-3427a0ca52ea" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/1842d8b8-ba13-4b58-bde3-fbc9d476f8fd" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/9863925e-29c2-442f-8130-2b3494c23632" width="200" height="430">
<img src="https://github.com/Haroldfromk/BookList/assets/97341336/470c5e10-68d2-49e2-9beb-7d637230e959" width="200" height="430">
</p>

## Features

### 검색
- 원하는 책을 검색

### 최근 본 책 확인
- 검색을 하고 책 정보를 확인한 순간 최근 본 책에 등록
- 최근 본책에서도 상세 정보 재확인 가능.

### 상세페이지 기능
- 검색 후 원하는 책에 대한 상세페이지 확인

### 담기 기능
- 정보 확인 후, 원하는 책을 담을수 있는 담기 기능

### 담은 페이지 구현
- 별도의 Tabbar로 분류되어있는 담은 페이지 구현
- 선택적 삭제
- 전체 삭제

## Requirements
- App requires **iOS 17.4 or above**

## Stacks
- **Environment**

    <img src="https://img.shields.io/badge/-Xcode-147EFB?style=flat&logo=xcode&logoColor=white"/> <img src="https://img.shields.io/badge/-git-F05032?style=flat&logo=git&logoColor=white"/>

- **Language**

    <img src="https://img.shields.io/badge/-swift-F05138?style=flat&logo=swift&logoColor=white"/> 

- **API**

    <img src="https://img.shields.io/badge/-Kakao-FFCD00?style=flat&logo=Kakao&logoColor=white"/>

## Project Structure

```markdown
Book
├── Service
│   ├── NetworkManager
│   └── CoredataManager
│
├── Making
│   └── TextLabel
│
├── Extension
│   ├── Diffable+Extension
│   ├── CollectionView+Extension
│   ├── Int+Extension
│   ├── TableView+Extension
│   ├── UITextField+Extension
│   └── UIResponder+Extension
│
├── Model
│   ├── DiffableSectionModel
│   ├── BookModel
│   └── CoreModel(Coredata)
│
├── View
│   ├── Main
│   │   ├── SearchView
│   │   ├── RecentView
│   │   ├── ResultView
│   │   ├── RecentCollectionViewCell
│   │   └── ResultTableViewCell
│   │
│   ├── Detail
│   │   ├── TitleView
│   │   ├── ImageView
│   │   ├── BodyView
│   │   └── ButtonView
│   │
│   ├── Wishlist
│   │   ├── HeaderView
│   │   ├── BodyTableView
│   └── └── ButtonView
│
├── Controller
│   ├── MainViewController
│   ├── DetailViewController
│   └── WishlistViewController
│
├── Constants
└ 
```

## Developer
*  **송동익** ([Haroldfromk](https://github.com/haroldfromk))
