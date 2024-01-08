# Задача

[206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)

## Решение 1 - Time: $O(n)$, Memory: $O(1)$

```go
func reverseList(head *ListNode) (prev *ListNode) {
    for head != nil {
        head.Next, prev, head = prev, head, head.Next
    }
    return
}
```

### Оценка 

#### По времени: $O(n)$
Где:
* `n` - длина списка `head`

Для разворота списка нужно пройти по всем элементам списка.

#### По памяти: $O(1)$
Затраты по памяти не зависят от входных данных. 

### Описание решения

Простая перенастройка указателей. Удалось сэкономить на временных переменных благодаря особенностям языка - множественному присваиванию.