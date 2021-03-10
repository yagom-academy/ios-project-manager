### 메모 조회

#### 메모 조회 요청 방식

- GET /memos

#### 메모 조회 응답 파라미터

- memos: object array
- index: number
- title: string
- description: string
- date: number
- column: string

```json
{
    "memos": [
        {
            "index": 1,
            "title": "아침먹기",
            "description": "오늘의 아침은 순대국밥",
            "date": 1615219025.119415,
            "column": "todo"
        },
        {
            "index": 2,
            "title": "점심먹기",
            "description": "오늘의 점심은 서브웨이",
            "date": 1615219025.119415,
            "column": "todo"
        }
    ]
}
```

---

### 메모 저장

#### 메모 저장 요청 방식

- POST /memo

#### 메모 저장 요청 파라미터

- title: string
- description: string
- date: number
- column: string

```json
{
    "title": "아침먹기",
    "description": "오늘의 아침은 순대국밥",
    "date": 1615219025.119415,
    "column": "todo"
}
```

#### 메모 저장 응답 파라미터

- index: number

```json
{
    "index": 1
}
```

---

### 메모 수정

#### 메모 수정 요청 방식

- PATCH /memo/{index}

#### 메모 수정 요청 파라미터

- index: number
- title: string
- description: string
- date: number
- column: string

```json
{
    "title": "아침먹기",
    "description": "오늘의 아침은 순대국밥",
    "date": 1615219025.119415,
    "column": "todo"
}
```

#### 메모 수정 응답 파라미터

- index: number

```json
{
    "index": 1
}
```

---

### 메모 삭제

#### 메모 삭제 요청 방식

DELETE /memo/{index}

#### 메모 삭제 요청 파라미터

- index: number

#### 메모 삭제 응답 파라미터

- index: number

```json
{
    "index": 1
}
```

---

### 히스토리 요청

#### 히스토리 조회 요청 방식

- GET /history

#### 히스토리 조회 응답 파라미터

- histories: object array
- title: string
- date: number

```json
{
    "histories": [
        {
            "title": "Moved '아침먹기' from TODO to DOING.",
            "date": 1615219025.119415
        },
        {
            "title": "Added '점심먹기'",
            "date": 1615219025.119415
        }
    ]
}
```



