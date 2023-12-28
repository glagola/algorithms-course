# Задача

[234. Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list/)

## Код

```go
func isPalindrome(head *ListNode) bool {
    preMid := preMiddle(head)
    
    if preMid == nil {
        return true
    }
    
    mid := preMid.Next
    
    otherPart := reverse(mid)
    
    res := compare(head, otherPart)
    
    reverse(otherPart)
    
    return res 
}

func preMiddle(head *ListNode) (prev *ListNode) {
    fast := head
    
    for fast != nil && fast.Next != nil {
        prev, head = head, head.Next
        fast = fast.Next.Next
    }
    
    return
}

func reverse(head *ListNode) (prev *ListNode) {
    for head != nil {
        head.Next, head, prev = prev, head.Next, head
    }
    
    return 
}

func compare(l1, l2 *ListNode) bool {
    for l1 != nil && l2 != nil {
        if l1.Val != l2.Val {
            return false
        }
        
        l1, l2 = l1.Next, l2.Next
    }
    
    return true
}
```

### Оценка 

#### По времени: `O(n)`
Где:
* `n` - длинна списка `head`

Сложность каждого из использованных алгоритмов:
* `preMiddle(...)` - `O(n)`
* `compare(...)` - `O(n)`, но так как подаем туда половинки то `O(n/2)`
* `reverse(...)` - `O(n)`

Таким образом худшая оценка -  `O(n)`.

#### По памяти: `O(1)`
Затраты по памяти не зависят от входных данных. 

### Описание решения

1. Находим середину списка
	* А точнее предыдущий элемент списка
1. Разворачиваем вторую половину списка
1. Сравниваем левую половину и реверсированную правую часть
1. Если требуется - восстанавливаем целостность оригинального списка
	* Повлияет на производительность