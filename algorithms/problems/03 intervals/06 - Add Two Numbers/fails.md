# Задача

[2. Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

## Попытка 1
2024-01-09 00:46

```go
func addTwoNumbers(l1 *ListNode, l2 *ListNode) (res *ListNode) {
    dummyNode := ListNode{}
    current := &dummyNode

    overflow := 0
    for {
        current.Next = &ListNode{}
        current = current.Next

        current.Val = getVal(l1) + getVal(l2) + overflow
        overflow = current.Val / 10
        current.Val = current.Val % 10

        if overflow == 0 { // Тут ошибка
            break;
        }

        l1, l2 = getNext(l1), getNext(l2)
    }

    return dummyNode.Next
}

func getNext(item *ListNode) *ListNode {
    if item == nil {
        return nil
    }

    return item.Next
}

func getVal(item *ListNode) int {
    if item == nil {
        return 0
    }

    return item.Val
}
```

### Проблемы с алгоритмом
Не полное условие выхода из цикла - суммирование считается завершенным когда `overflow == 0 && l1 == nil && l2 == nil`.