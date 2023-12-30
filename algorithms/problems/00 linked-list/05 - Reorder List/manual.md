# Задача

[143. Reorder List](https://leetcode.com/problems/reorder-list/)

## Решение 1 - Time: O(n), Memory: O(1)

```go
func reorderList(head *ListNode) {
    preMid := preMiddle(head)
    
    if preMid == nil {
        return
    }
    
    headOfReversed := reverse(preMid.Next)
    preMid.Next = nil
    
    merge(head, headOfReversed)
}

func reverse(head *ListNode) (prev *ListNode) {
    for head != nil {
        head, head.Next, prev = head.Next, prev, head
    }
    
    return
}

func preMiddle(head *ListNode) (prev *ListNode) {
    fast := head
    
    for fast != nil && fast.Next != nil {
        prev, head, fast = head, head.Next, fast.Next.Next
    }
    
    return
}

func merge(l1, l2 *ListNode) *ListNode {
    dummy := ListNode{}
    curr := &dummy
    
    for l1 != nil || l2 != nil {
        if l1 != nil {
            curr.Next = l1
            l1 = l1.Next
            curr = curr.Next
        }
        
        if l2 != nil {
            curr.Next = l2
            l2 = l2.Next
            curr = curr.Next
        }
    }
    
    return dummy.Next
}
```

### Оценка 

#### По времени: `O(n)`
Где:
* `n` - длина списка `head`

Сложность каждого из использованных алгоритмов:
* `preMiddle(...)` - `O(n)`
* `reverse(...)` - `O(n)`
* `merge(...)` - `O(n)`

#### По памяти: `O(1)`
Затраты по памяти не зависят от входных данных. 

### Описание решения

1. Разделяем список на 2 половины
2. Переворачиваем правую половину
3. Объединяем два списка, беря элементы, то из одного, то из другого 