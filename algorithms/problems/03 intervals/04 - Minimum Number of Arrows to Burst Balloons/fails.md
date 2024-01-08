# Задача

[452. Minimum Number of Arrows to Burst Balloons](https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/)

## Попытка 1
2024-01-08 20:35

```go
import "sort"

type ByLeftPointAsc [][]int

func (arr ByLeftPointAsc) Len() int {
    return len(arr)
}

func (arr ByLeftPointAsc) Less(i, j int) bool {
    return a[i] < a[j] // Тут ошибка
}

func (arr ByLeftPointAsc) Swap(i, j int) {
    a[i], a[j] = a[j], a[i]
}

func findMinArrowShots(points [][]int) int {
    sort.Sort(ByLeftPointAsc(points))

    i := 0
    for j := i + 1; j < len(points); j++ {
        left, right := intersection(p1, p2)
        if left <= right {
            points[i][0], points[i][1] = left, right
        } else {
            i++
            points[i] = points[j]
        }
    }

    return i + 1
}

func intersection(p1, p2 []int) (int, int) {
    return max(p1[0], p2[0]), min(p1[1], p2[2])
}

func min(a,b int) int {
    if a < b {
        return a
    }

    return b
}

func max(a,b int) int {
    if a > b {
        return a
    }

    return b
}
```

### Проблемы с алгоритмом
В методе `Less(...)` забыл, что элемент массива - отрезок с двумя координатами: начала и конца. Сравнение должно происходить по начальному значению.

## Попытка 2
2024-01-08 20:37

```go
import "sort"

type ByLeftPointAsc [][]int

func (arr ByLeftPointAsc) Len() int {
    return len(arr)
}

func (arr ByLeftPointAsc) Less(i, j int) bool {
    return a[i] < a[j] // Тут ошибка
}

func (arr ByLeftPointAsc) Swap(i, j int) {
    a[i], a[j] = a[j], a[i] // Тут ошибка
}

func findMinArrowShots(points [][]int) int {
    sort.Sort(ByLeftPointAsc(points))

    i := 0
    for j := i + 1; j < len(points); j++ {
        left, right := intersection(p1, p2)
        if left <= right {
            points[i][0], points[i][1] = left, right
        } else {
            i++
            points[i] = points[j]
        }
    }

    return i + 1
}

func intersection(p1, p2 []int) (int, int) {
    return max(p1[0], p2[0]), min(p1[1], p2[2])
}

func min(a,b int) int {
    if a < b {
        return a
    }

    return b
}

func max(a,b int) int {
    if a > b {
        return a
    }

    return b
}
```


### Проблемы со спецификой языка
Название переменной должно быть `arr`.

## Попытка 3
2024-01-08 20:40

```go
import "sort"

type ByLeftPointAsc [][]int

func (arr ByLeftPointAsc) Len() int {
    return len(arr)
}

func (arr ByLeftPointAsc) Less(i, j int) bool {
    return arr[i][0] < arr[j][0]
}

func (arr ByLeftPointAsc) Swap(i, j int) {
    arr[i], arr[j] = arr[j], arr[i]
}

func findMinArrowShots(points [][]int) int {
    sort.Sort(ByLeftPointAsc(points))

    i := 0
    for j := i + 1; j < len(points); j++ {
        left, right := intersection(p1, p2) // Тут проблема
        if left <= right {
            points[i][0], points[i][1] = left, right
        } else {
            i++
            points[i] = points[j]
        }
    }

    return i + 1
}

func intersection(p1, p2 []int) (int, int) {
    return max(p1[0], p2[0]), min(p1[1], p2[2])
}

func min(a,b int) int {
    if a < b {
        return a
    }

    return b
}

func max(a,b int) int {
    if a > b {
        return a
    }

    return b
}
```

### Проблемы с алгоритмом
Из-за рефакторинга, забыл поменять аргументы в функции, должно быть `intersection(points[i], points[j])`.

## Попытка 4
2024-01-08 20:42

```go
import "sort"

type ByLeftPointAsc [][]int

func (arr ByLeftPointAsc) Len() int {
    return len(arr)
}

func (arr ByLeftPointAsc) Less(i, j int) bool {
    return arr[i][0] < arr[j][0]
}

func (arr ByLeftPointAsc) Swap(i, j int) {
    arr[i], arr[j] = arr[j], arr[i]
}

func findMinArrowShots(points [][]int) int {
    sort.Sort(ByLeftPointAsc(points))

    i := 0
    for j := i + 1; j < len(points); j++ {
        left, right := intersection(points[i], points[j])
        if left <= right {
            points[i][0], points[i][1] = left, right
        } else {
            i++
            points[i] = points[j]
        }
    }

    return i + 1
}

func intersection(p1, p2 []int) (int, int) {
    return max(p1[0], p2[0]), min(p1[1], p2[2]) // Тут ошибка
}

func min(a,b int) int {
    if a < b {
        return a
    }

    return b
}

func max(a,b int) int {
    if a > b {
        return a
    }

    return b
}
```

### Проблемы с алгоритмом
Вместо `p2[2]` должно быть `p2[1]`.