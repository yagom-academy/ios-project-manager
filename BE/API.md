### 메모 요청

메모 요청 방식

- GET /memos

메모 응답

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
        },
    ]
}
```

### 메모 저장

POST /memo

- title
- description
- date
- column

### 메모 수정

PATCH /memo/{index}

- title
- description
- date
- column

### 메모 삭제

DELETE /memo/{index}

### 히스토리 요청

GET /history

