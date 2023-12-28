# Задача

[19. Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

## Попытка
2023-12-28 22:56

```go
func removeNthFromEnd(head *ListNode, n int) *ListNode {
	fast := head
	for ; n > 0; n-- {
		fast = fast.Next
	}
	
	dummyNode := ListNode{Next: head}
	prev := &prev
	
	for fast != nil {
		prev, head, fast = head, head.Next, fast.Next
	}
	
	prev.Next = head.Next
	
	return dummyNode.Next
}
```

### Проблемы с синтаксисом
>`Line 8: Char 14: undefined: prev (solution.go)`

В результате рефакторинга забыл поправить ссылку на DummyNode.