# Задача

[2. Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

## Решение 1 - Time: $O(n)$, Memory: $O(1)$

```go
func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
    dummyNode := ListNode{}
    current := &dummyNode

    overflow := 0
    for overflow != 0 || l1 != nil || l2 != nil  {
        current.Next = &ListNode{}
        current = current.Next

        current.Val = getVal(l1) + getVal(l2) + overflow
        overflow = current.Val / 10
        current.Val = current.Val % 10

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

### Оценка 

#### По времени: $O(n)$
Где:
* `n` - кол-во разрядов в самом большом из двух чисел `l1`, `l2`

Пройтись по всем разрядам числа - $O(n)$

#### По памяти: $O(1)$
Где:
* `n` - кол-во разрядов в самом большом из двух чисел `l1`, `l2`

Если в оценку включается память отведенная под результат - $O(n)$, если нет - $O(1)$.

### Описание решения
Просто операция суммирования из длинной арифметика на списках.