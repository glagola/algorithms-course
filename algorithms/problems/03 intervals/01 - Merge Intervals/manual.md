# Задача

[56. Merge Intervals](https://leetcode.com/problems/merge-intervals/)

## Решение 1 - Time: $O(n*log(n))$, Memory: $O(1)$

```go
type ByFirstPoint [][]int

func (intr ByFirstPoint) Len() int {
    return len(intr)
}

func (intr ByFirstPoint) Less(i, j int) bool {
    return intr[i][0] < intr[j][0]
}

func (intr ByFirstPoint) Swap(i, j int) {
   intr[i], intr[j] = intr[j], intr[i]
}


func merge(intervals [][]int) (res [][]int) {
    sort.Sort(ByFirstPoint(intervals))

    w := 0
    for i := w + 1; i < len(intervals); i++ {
        if intersects(intervals[w], intervals[i]) {
            union(intervals[w], intervals[i])
        } else {
            w++
            intervals[w] = intervals[i]
        }
    }
    
    return intervals[:w + 1]
}

func intersects(a, b []int) bool {
    return max(a[0], b[0]) <= min(a[1], b[1])
} 

func union(a, b []int) {
    a[0], a[1] = min(a[0], b[0]), max(a[1], b[1])
}

func min(a, b int) int {
    if a > b {
        return b
    }
    
    return a
}

func max(a, b int) int {
    if a < b {
        return b
    }
    
    return a
}
```

### Оценка 

#### По времени: $O(n * log(n))$
Где:
* `n` - кол-во интервалов

Предположим, что сортировка интервалов по первой координате происходит за - $O(n * log(n))$. Для объединения интервалов нужно пройти по всем интервалам еще раз - $O(n)$. Таким образом сложность всего алгоритма - $O(n * log(n))$

#### По памяти: $O(1)$
Дополнительной памяти не потребовалось. Затраты по памяти не зависят от входных данных. 

### Описание решения

1. Сортируем интервалы по первой координате
1. Выбираем первый интервал в качестве результата (текущего)
1. Проходим по массиву и расширяем результат, если он пересекается с текущим. Если не пересекается, то добавляем текущий в качестве результата - дальнейшее сравнение на пересечение будет идти уже с ним.