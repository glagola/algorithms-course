# Задача

[23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)

## Решение 1 - Time: $O(m * log(n))$, Memory: $O(1)$

```go
func mergeKLists(lists []*ListNode) *ListNode {
    if len(lists) == 0 {
        return nil
    }
    
    for len(lists) > 1 {
        w := 0
        for i := 0; i < len(lists); i += 2 {
            var anotherList *ListNode
            
            if i + 1 < len(lists) {
                anotherList = lists[i+1]
            }
            
            lists[w] = merge(lists[i], anotherList)
            w++
        }
        
        lists := lists[:w]
    }
    
    return lists[0]
}

func merge(l1, l2 *ListNode) *ListNode {
    dummyNode := ListNode
    head := &dummyNode
    
    for l1 != nil && l2 != nil {
        if l1.Val < l2.Val {
            head.Next = l1
            l1 = l1.Next
        } else {
            head.Next = l2
            l2 = l2.Next
        }
        
        head = head.Next
    }
    
    if l1 != nil {
        head.Next = l1
    } else {
        head.Next = l2
    }
    
    return dummyNode.Next
}
```

### Оценка 

#### По времени: $O(m * log(n))$
Где:
* `n` - кол-во одно-связных списков
* `m` - длинна списка

`merge(l1, l2)` - объединение двух списков в худшем случае $O(m)$, где `m` - длина списка.

На каждом шаге мы уменьшаем кол-во списков в 2 раза, пока не останется 1 список. Таких шагов будет - $log(n)$.

Таким образом получается оценка $O(m * log(n))$

#### По памяти: $O(1)$

Дополнительной памяти не потребовалось. Затраты по памяти не зависят от входных данных. 

### Описание решения

На каждом шаге объединяем соседние списки, например 1 и 2, 3 и 4, 5 и 6, ... Ссылку на объединенный список записываем в тот же массив в начало. Объединив все пары на текущем шаге - уменьшаем slice и повторяем еще раз и так до тех пор пока не останется один список, он и будет результатом. 

## Решение 2 - Time: $O(n * m)$, Memory: $O(1)$

```go
func mergeKLists(lists []*ListNode) *ListNode {
	i := 0
	for j := len(lists); i < j; {
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
		for i := 0; i < length; i++ {
			if lists[i].Val < lists[k].Val {
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

### Оценка 

#### По времени: $O(n*m)$
Где:
* `n` - кол-во непустых списков в `lists`
* `m` - кол-во элементов в самом большом одно-связном списке

#### По памяти: $O(1)$
Дополнительной памяти не потребовалось. Затраты по памяти не зависят от входных данных. 

### Описание решения

1. Удаляем все пустые списки из входного массива указателей
2. Пока кандидатов (одно-связных списков) больше одного
	1. В среди одно-связных списков ищем с наименьшим элементом
	2. Помещаем этот элемент в результирующий список
	3. Сдвигаем указатель к следующему элементу списка
	4. Если достигли конца связного списка - удаляем его из списка кандидатов (обменивая с последних элементом)
3. Когда останется один связный список - просто добавляем его к концу результирующего списка