# Задача

[23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)

## Попытка 1
2023-12-30 20:48

```go
func mergeKLists(lists []*ListNode) *ListNode {
    for i, j := 0, len(lists); i < j; {
        if len(lists[i]) == 0 { // Тут проблема
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    lists = lists[: i+1]
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    for len(lists) > 1 {
        k := 0
        for i, v := range lists {
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            lists[k] = lists[len(lists) - 1]
            lists = lists[:len(lists) - 1]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с синтаксисом
>`Line 3: Char 16: invalid argument: lists[i] (variable of type *precompiled.ListNode) for len (solution.go) Line 11: Char 21: undefined: i (solution.go)`

Почему-то отнесся к `*ListNode` как к `slice`'у, решил проверить на пустоту через `len(lists[i]) == 0`

## Попытка 2
2023-12-30 20:50

```go
func mergeKLists(lists []*ListNode) *ListNode {
    for i, j := 0, len(lists); i < j; {
        if lists[i] == nil {
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    lists = lists[: i+1] // Тут проблема
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    for len(lists) > 1 {
        k := 0
        for i, v := range lists {
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            lists[k] = lists[len(lists) - 1]
            lists = lists[:len(lists) - 1]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с синтаксисом
>`Line 11: Char 21: undefined: i (solution.go)`

`i` недоступна снаружи цикла

## Попытка 3
2023-12-30 20:53

```go
func mergeKLists(lists []*ListNode) *ListNode {
    i := 0
    for i, j := 0, len(lists); i < j; {
        if lists[i] == nil {
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    lists = lists[: i+1] // Тут проблема
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    length := len(lists)
    
    for length > 1 {
        k := 0
        for i, v := range lists {
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            length--
            lists[k] = lists[length]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с алгоритмом
```
panic: runtime error: slice bounds out of range [:1] with capacity 0 main.mergeKLists({0x5a9e60?, 0xc000092008?, 0x2?}) solution.go, line 12 main.__helper__(...) solution.go, line 49 main.main() solution.go, line 77
```
При изначальной очистке `lists` от пустых списков - неправильно посчитал кол-во не пустых.

## Попытка 4
2023-12-30 21:43

```go
func mergeKLists(lists []*ListNode) *ListNode {
    i := 0
    for i, j := 0, len(lists); i < j; { // Тут проблема
        if lists[i] == nil {
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    if cap(lists) > i {
        lists = lists[: i+1]
    }
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    length := len(lists)
    
    for length > 1 {
        k := 0
        for i, v := range lists {
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            length--
            lists[k] = lists[length]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с алгоритмом
Дал неправильный ответ для `lists = [[1,4,5],[1,3,4],[2,6]]`

Output
> `[1,4,5]`

Expected
> `[1,1,2,3,4,4,5,6]`

### Проблемы со спецификой языка
`Shadowing` переменной `i` в первом цикле сыграл злую шутку

## Попытка 5
2023-12-30 21:47

```go
func mergeKLists(lists []*ListNode) *ListNode {
    i := 0
    for j := 0, len(lists); i < j; {
        if lists[i] == nil {
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    if cap(lists) > i {
        lists = lists[:i+1] // Тут проблема
    }
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    length := len(lists)
    
    for length > 1 {
        k := 0
        for i, v := range lists {
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            length--
            lists[k] = lists[length]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с алгоритмом

Неправильно обрезал входящий `lists`, вместо `lists = lists[:i+1]` должно быть `lists = lists[:i]`

## Попытка 6
2023-12-30 21:49

```go
func mergeKLists(lists []*ListNode) *ListNode {
    i := 0
    for j := 0, len(lists); i < j; {
        if lists[i] == nil {
            j--
            lists[i] = lists[j]
        } else {
            i++
        }
    }
    
    if cap(lists) > i {
        lists = lists[:i]
    }
    
    if len(lists) == 0 {
        return nil
    }
    
    dummyNode := ListNode{}
    head := &dummyNode
    
    length := len(lists)
    
    for length > 1 {
        k := 0
        for i, v := range lists { // Тут проблема
            if v.Val < lists[k].Val {
                k = i
            }
        }
        
        head.Next = lists[k]
        lists[k] = lists[k].Next
        head = head.Next
        
        if lists[k] == nil {
            length--
            lists[k] = lists[length]
        }
    }
    
    head.Next = lists[0]
    
    return dummyNode.Next
}
```

### Проблемы с алгоритмом

Пал жертвой преждевременного рефакторинга, решил НЕ пересоздавать `lists` после исключения из него опустевшего списка, а просто уменьшать длинну в переменной `length`. Но попрежнему использовал оператор `range` для обхода списка `lists`...