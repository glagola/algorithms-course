# Задача

[160. Intersection of Two Linked Lists](https://leetcode.com/problems/intersection-of-two-linked-lists/)

## Попытка 1
2024-01-04 19:44

```go
func getIntersectionNode(headA, headB *ListNode) *ListNode {
    listALen = length(headA) // Тут проблема
    listBLen = length(headB)
    
    if listALen > listBLen {
        headA = skip(headA, listALen - listBLen)
    } else {
        headB = skip(headB, listBLen - listALen)
    }
    
    for headA != headB && headA != nil && headB != nil {
        headA, headB = headA.Next, headB.Next
    }
    
    if headA != nil && headB != nil {
        return headA
    }
    
    return nil
}

func skip(head *ListNode, k int) *ListNode {
    for ; head != nil && k > 0; k-- {
        head = head.Next
    }
    
    return head
}

func length(head *ListNode) (res int) {
    for ; head != nil; head = head.Next {
        res++
    }
    
    return
}
```

### Проблемы со спецификой языка
>```
> Compile Error
>Line 9: Char 5: undefined: listALen (solution.go) 
>Line 10: Char 5: undefined: listBLen (solution.go)
>```

Забыл объявить переменную через `:=`.