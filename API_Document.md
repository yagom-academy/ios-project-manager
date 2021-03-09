# API Document

## GET - 할일 목록 조회

- `Path`: /todoList
- `HTTP Status Code`
    - Success: 200
    - Error: 400, 404, 500

| Response Body             ||
| ------------| ------------ |
| === JSON Object ===       ||
| todoList    | Object Array |
| === JSON Object ===       ||
| id          | Int          |
| title       | String       |
| description | String?      |
| deadline    | Date?        |
| status      | Int          |
| statusIndex | Int          |

### Success data sample

~~~swift
{
    "todoList": [
        {
            "id": 1,
            "title": "태태의 볼펜 똥 채우기",
            "description": "볼펜 똥이 다 떨어져서 볼펜 똥을 오픈마켓에서 사오자",
            "deadline": 20210310,
            "status": 0,
            "statusIndex": 0
        },
        {
            "id": 2,
            "title": "오동나무 물주기",
            "description": "오동나무 물은 일주일에 3번씩 화요일날 주어야한다!",
            "deadline": 20210316,
            "status": 1,
            "statusIndex": 0
        },
        {
            "id": 3,
            "title": "라자냐 먹기",
            "description": "오늘 저녁은 라자냐를 먹어야겠다,,",
            "deadline": 20210309,
            "status": 2,
            "statusIndex": 0
        }
    ]
}
~~~

### Error data sample

~~~swift
{
  "error": true
}
~~~


## POST - 할일 등록

- `Path`: /todo
- `HTTP Status Code`
    - Success: 201
    - Error: 400, 404, 500

| Request Body         || | Response Body        ||
| ----------- | ------- |-| ------------| ------- |
| === JSON Object ===  || | === JSON Object ===  ||
| -           | -       | | id          | Int     |
| title       | String  | | title       | String  |
| description | String? | | description | String? |
| deadline    | Date?   | | deadline    | Date?   |
| status      | Int     | | status      | Int     |
| statusIndex | Int     | | statusIndex | Int     |

## PATCH - 할일 수정

- `Path`: /todo/:id
- `HTTP Status Code`
    - Success: 200
    - Error: 400, 404, 500

| Request Body         || | Response Body        ||
| ----------- | ------- |-| ------------| ------- |
| === JSON Object ===  || | === JSON Object ===  ||
| id          | Int     | | id          | Int     |
| title       | String? | | title       | String  |
| description | String? | | description | String? |
| deadline    | Date?   | | deadline    | Date?   |
| status      | Int?    | | status      | Int     |
| statusIndex | Int?    | | statusIndex | Int     |

## DELETE - 할일 삭제

- `Path`: /todo/:id
- `HTTP Status Code`
    - Success: 200
    - Error: 400, 404, 500

| Request Body         || | Response Body        ||
| ----------- | ------- |-| ------------| ------- |
| === JSON Object ===  || | === JSON Object ===  ||
| id          | Int     | | id          | Int     |
  