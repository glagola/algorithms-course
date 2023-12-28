# Задача

[234. Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list/)

## Попытка 1
2023-12-29 00:35

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

func preMiddle(head *ListNode) *ListNode {
    fast := head
    prev := nil
    
    for fast != nil && fast.Next != nil {
        prev, head = head, head.Next
        fast = fast.Next.Next
    }
    
    return prev
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

### Проблемы со спецификой языка
>`Line 21: Char 13: use of untyped nil in assignment (solution.go)`

Нельзя присваивать нетипизированный `nil`. 