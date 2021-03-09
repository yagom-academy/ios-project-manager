# API Document

## GET

- Path: /todo

| Request Body         || | Response Body             ||
| ----------- | ------- |-| ------------| ------------ |
|             |         | | === JSON Object ===       ||
|             |         | | todoList    | Object Array |
|             |         | | === JSON Object ===       ||
|             |         | | id          | Int          |
|             |         | | title       | String       |
|             |         | | description | String?      |
|             |         | | deadline    | Date?        |
|             |         | | status      | Int          |
|             |         | | statusIndex | Int          |

## POST

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

## PATCH

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

## DELETE

- Path: /todo:id

| Request Body         || | Response Body        ||
| ----------- | ------- |-| ------------| ------- |
| === JSON Object ===  || | === JSON Object ===  ||
| id          | Int     | | id          | Int     |