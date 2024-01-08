# Задача

[1094. Car Pooling](https://leetcode.com/problems/car-pooling/)

## Попытка 1
2024-01-08 16:44

```go
import "sort"

type ByASCCoord [][]int

func (arr ByASCCoord) Len() int {
    return len(arr)
}

func (arr ByASCCoord) Less(i, j int) bool {
    return arr[i][0] < arr[j][0] // Тут проблема
}

func (arr ByASCCoord) Swap(i, j int) {
    arr[i], arr[j] = arr[j], arr[i]
}

func carPooling(trips [][]int, capacity int) bool {
    points := make([][]int, 2*len(trips))

    i := 0
    for _, trip := range trips {
        points[i] = []int{trip[1], -1*trip[0]}
        points[i+1] = []int{trip[2], 1*trip[0]}
        i += 2
    }

    sort.Sort(ByASCCoord(points))

    for _, point := range points {
        capacity += point[1]
        if capacity < 0 {
            return false
        }
    }

    return true
}
```

### Проблемы с алгоритмом
Забыл про порядок на стыках интервалов - что происходит сначала: люди заходят или выходят.