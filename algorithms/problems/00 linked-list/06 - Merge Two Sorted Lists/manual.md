# Задача

[21. Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)

## Решение 1 - Time: $O(n + m)$, Memory: $O(1)$

```go
func mergeTwoLists(list1 *ListNode, list2 *ListNode) *ListNode {
    dummyNode := ListNode{}
    head := &dummyNode
    
    for list1 != nil && list2 != nil {
        if list1.Val < list2.Val {
            head.Next = list1
            list1 = list1.Next
        } else {
            head.Next = list2
            list2 = list2.Next
        }
        
        head = head.Next
    }
    
    if list1 != nil {
        head.Next = list1
    } else {
        head.Next = list2
    }
    
    return dummyNode.Next
}
```

### Оценка 

#### По времени: $O(n + m)$
Где:
* `n` - размер списка `list1`
* `m` - размер списка `list2`

В худшем случае, если списки состоят из уникальных возрастающих цифр - придется пройтись по элементам двух списков, поэтому - $O(n + m)$


#### По памяти: $O(1)$
Затраты по памяти не зависят от входных данных. 

### Описание решения

На каждом шаге выбираем список с наименьшим текущим элементом, затем добавляем его к результирующему списку. Если один из списков закончился, то к результату присоединяем все что осталось от другого списка.