

### 메모 조회

#### 메모 조회 요청 방식

- GET /memos

#### 메모 조회 응답 파라미터

- memos: object array
- index: string
- title: string
- description: string
- date: number
- status: string

```json
{
    "memos": [
        {
            "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AFF8",
            "title": "아침먹기",
            "description": "오늘의 아침은 순대국밥",
            "date": "2020-04-03T00:00:00Z",
            "status": "todo"
        },
        {
            "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AFF9",
            "title": "점심먹기",
            "description": "오늘의 점심은 서브웨이",
            "date": "2020-04-03T00:00:00Z",
            "status": "todo"
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
- status: string

```json
{
    "title": "아침먹기",
    "description": "오늘의 아침은 순대국밥",
    "date": "2020-04-03T00:00:00Z",
    "status": "todo"
}
```

#### 메모 저장 응답 파라미터

- result: bool
- item: object
- index: string
- title: string
- description: string
- date: string
- status: string

```json
{
    "result": true,
    "item": {
        "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AFF8",
        "title": "아침먹기",
        "description": "오늘의 아침은 순대국밥",
        "date": "2020-04-03T00:00:00Z",
        "status": "todo"
    }
}
```

---

### 메모 수정

#### 메모 수정 요청 방식

- PATCH /memo/{index}

#### 메모 수정 요청 파라미터

- index: string
- title: string
- description: string
- date: string
- column: string

```json
{
  	"index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
    "title": "아침먹기",
    "description": "오늘의 아침은 순대국밥",
    "date": "2020-04-03T00:00:00Z",
    "status": "todo"
}
```

#### 메모 수정 응답 파라미터

- result: bool
- item: object
- index: string
- title: string
- description: string
- date: string
- status: string

```json
{
  	"result": true,
  	"item": {
        "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
        "title": "아침먹기",
        "description": "오늘의 아침은 순대국밥",
        "date": "2020-04-03T00:00:00Z",
        "status": "todo"
		}
}
```

---

### 메모 삭제

#### 메모 삭제 요청 방식

DELETE /memo/{index}

#### 메모 삭제 요청 파라미터

- index: number

#### 메모 삭제 응답 파라미터

- result: bool
- item: object
- index: string
- title: string
- description: string
- date: string
- status: string

```json
{
    "result": true,
  	"item": {
        "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
        "title": "아침먹기",
        "description": "오늘의 아침은 순대국밥",
        "date": "2020-04-03T00:00:00Z",
        "status": "todo"
		}
}
```

---

### 히스토리 요청

#### 히스토리 조회 요청 방식

- GET /history

#### 히스토리 조회 응답 파라미터

- histories: object array
- index: string
- title: string
- fromStatus: string?
- toStatus: string?
- behavior: string
- modifiedDate: string

```json
{
    "histories": [
        {
            "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
            "title": "Moved '아침먹기' from TODO to DOING.",
            "fromStatus": "todo",
            "toStatus": "doing",
            "behavior": "moved",
            "modifiedDate": "2020-04-03T00:00:00Z"
        },
        {
            "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
            "title": "Added '점심먹기'",
            "behavior": "added",
            "modifiedDate": "2020-04-03T00:00:00Z",
        },
        {
            "index": "48E2E85B-9FC4-4FA7-AE98-D0F2BE71AF10",
            "title": "Added '점심먹기'",
            "fromStatus": "done",
            "behavior": "removed",
            "modifiedDate": "2020-04-03T00:00:00Z",
        }
    ]
}
```
