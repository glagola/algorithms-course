# Задача

[56. Merge Intervals](https://leetcode.com/problems/merge-intervals/)

## Попытка 1
2024-01-06 17:42

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
    
    for _, intr := range intervals {
        if len(res) == 0 || !intersects(res[len(res) - 1], intr) {
            res = append(res, []int{intr[0], intr[1]})
            continue
        }
        
        union(res[len(res) - 1], intr)
    }
    
    return
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

func intersects(a, b []int) bool {
    return max(a[0], b[0]) =< min(a[1], b[1]) // Тут проблема
} 

func union(a, b []int) {
    a[0], a[1] = min(a[0], b[0]), max(a[1], b[1]])
}
```

### Проблемы с синтаксисом
Перепутал `=<` и `<=`

## Попытка 2
2024-01-06 17:43

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
    
    for _, intr := range intervals {
        if len(res) == 0 || !intersects(res[len(res) - 1], intr) {
            res = append(res, []int{intr[0], intr[1]})
            continue
        }
        
        union(res[len(res) - 1], intr)
    }
    
    return
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

func intersects(a, b []int) bool {
    return max(a[0], b[0]) <= min(a[1], b[1])
} 

func union(a, b []int) {
    a[0], a[1] = min(a[0], b[0]), max(a[1], b[1]]) // Тут проблема
}
```

### Проблемы с синтаксисом
Лишняя квадратная скобка в выражении `max(a[1], b[1]])`
