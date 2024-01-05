# Задача

[160. Intersection of Two Linked Lists](https://leetcode.com/problems/intersection-of-two-linked-lists/)

## Решение 1 - Time: $O(m + n)$, Memory: $O(1)$

```go
func getIntersectionNode(headA, headB *ListNode) *ListNode {
    listALen := length(headA)
    listBLen := length(headB)
    
    if listALen > listBLen {
        headA = skip(headA, listALen - listBLen)
    } else {
        headB = skip(headB, listBLen - listALen)
    }
    
    for headA != headB && headA != nil {
        headA, headB = headA.Next, headB.Next
    }
    
    return headA
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

### Оценка 

#### По времени: $O(m + n)$
Где:
* `n` - длина списка `headA`
* `m` - длина списка `headB`

Худший случай - когда списки изначально не пересекаются, но имеют одинаковую длину. Тогда мы пройдем по каждому для измерения длины, потом пропустим 0 элементов и после этого пройдем два списка за раз. Таким образом худший случай - $O(n + n + n)$ или $O(n)$.

#### По памяти: $O(1)$
Дополнительной памяти не потребовалось. Затраты по памяти не зависят от входных данных. 

### Описание решения

1. Определяем длину двух списков
1. В самом длинном списке пропускаем `k` элементов с начала, так чтобы списки сравнялись по длине
1. Идем одновременно по двум спискам, пока:
	* либо найдем указатель на совпадающий элемент
	* либо оба списка закончатся (так как пропустив `k` шагов - мы уравняли их длину)