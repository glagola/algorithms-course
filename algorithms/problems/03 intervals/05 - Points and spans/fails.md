# Задача

[Задача №112542. Точки и отрезки](./task.md)

## Попытка 1
2024-01-08 22:00

```go
package main

import "sort"

type CommonPoint struct {
    x       int
    pointId int
}

type ByXAscSpanOpenFirst []CommonPoint

func (a ByXAscSpanOpenFirst) Len() int {
    return len(a)
}

func (a ByXAscSpanOpenFirst) Less(i, j int) bool {
    if a[i].x == a[j].x {
        return a[i].pointId == -1 || a[i].pointId >= 0 && (a[j].pointId == -2 || a[i].pointId <= a[j].pointId)
    }

    return a[i].x < a[j].x
}

func (a ByXAscSpanOpenFirst) Swap(i, j int) {
    a[i], a[j] = a[j], a[i]
}

func solution(spans [][]int, points []int) (res []int) {
    allPoints := make([]CommonPoint, 2*len(spans)+len(points))
    res := make([]int, len(points)) // Тут проблема

    i := 0
    for _, span := range spans {
        allPoints[i].x = min(span[0], span[1])
        allPoints[i].pointId = -1

        allPoints[i+1].x = max(span[0], span[1])
        allPoints[i+1].pointId = -2
        i += 2
    }

    for pointId, x := range points {
        allPoints[i].x = x
        allPoints[i].pointId = pointId
        i++
    }

    sort.Sort(ByXAscSpanOpenFirst(allPoints))

    inclusions := 0
    for _, p := range allPoints {
        switch {
        case p.pointId == -1:
            inclusions++
        case p.pointId == -2:
            inclusions--
        default:
            res[p.pointId]++
        }
    }

    return
}

func max(a, b int) int {
    if a > b {
        return a
    }

    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }

    return b
}

```

### Проблемы со спецификой языка
Опечатался вместо `=` написал `:=`, хотя `res` это именная выходная переменная.

## Попытка 2
2024-01-08 22:13

```go
package main

import "sort"

type CommonPoint struct {
    x       int
    pointId int
}

type ByXAscSpanOpenFirst []CommonPoint

func (a ByXAscSpanOpenFirst) Len() int {
    return len(a)
}

func (a ByXAscSpanOpenFirst) Less(i, j int) bool {
    if a[i].x == a[j].x {
        return a[i].pointId == -1 || a[i].pointId >= 0 && (a[j].pointId == -2 || a[i].pointId <= a[j].pointId)
    }

    return a[i].x < a[j].x
}

func (a ByXAscSpanOpenFirst) Swap(i, j int) {
    a[i], a[j] = a[j], a[i]
}

func solution(spans [][]int, points []int) (res []int) {
    allPoints := make([]CommonPoint, 2*len(spans)+len(points))
    res = make([]int, len(points))

    i := 0
    for _, span := range spans {
        allPoints[i].x = min(span[0], span[1])
        allPoints[i].pointId = -1

        allPoints[i+1].x = max(span[0], span[1])
        allPoints[i+1].pointId = -2
        i += 2
    }

    for pointId, x := range points {
        allPoints[i].x = x
        allPoints[i].pointId = pointId
        i++
    }

    sort.Sort(ByXAscSpanOpenFirst(allPoints))

    inclusions := 0
    for _, p := range allPoints {
        switch {
        case p.pointId == -1:
            inclusions++
        case p.pointId == -2:
            inclusions--
        default:
            res[p.pointId]++ // Тут проблема
        }
    }

    return
}

func max(a, b int) int {
    if a > b {
        return a
    }

    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }

    return b
}
```

### Проблемы с алгоритмом
В результат должно фиксироваться текущее значение переменной `inclusions`, которая ведет подсчет текущего кол-ва отрезков.