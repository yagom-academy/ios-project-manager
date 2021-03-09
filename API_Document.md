# API Document

## GET - 할일 목록 조회

- Path: /todo

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

## POST - 할일 등록

- Path: /todo

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

- Path: /todo:id

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

- Path: /todo:id

| Request Body         || | Response Body        ||
| ----------- | ------- |-| ------------| ------- |
| === JSON Object ===  || | === JSON Object ===  ||
| id          | Int     | | id          | Int     |