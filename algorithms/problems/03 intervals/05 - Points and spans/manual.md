# Задача

[Задача №112542. Точки и отрезки](./task)

## Решение 1 - Time: $O((m+n)*log(m+n))$, Memory: $O(m+n)$

```go
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
            res[p.pointId] = inclusions
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

### Оценка 

#### По времени: $O((m+n)*log(m+n))$
Где:
* `n` - кол-во отрезков
* `m` - кол-во точек

По этапам:
* объединенный массив точек - $O(n + m)$
* встроенная сортировка, предположительно - $O((m+2*n)*log(m+2*n))$
* проход для формирования результата - $O(m+2*n)$

Таким образом верхняя оценка - $O((m+2*n)*log(m+2*n))$ или $O((m+n)*log(m+n))$

#### По памяти: $O(m+n)$
Где:
* `n` - кол-во отрезков
* `m` - кол-во точек

Таким образом на каждом этапе:
* объединенный массив точек (x координата и признак(начало/конец отрезка/индекс в массиве точек)) - $O(2*(m + 2*n))$
* встроенная сортировка, предположительно - $O(m + 2*n)$ 

Таким образом верхняя оценка по памяти -  $O(2*(m + 2*n) + (m + 2*n))$ или $O(m + n)$

### Описание решения
1. Помещаем все в один массив: начальную и конечную точку отрезка, координаты точек. Каждый элемент в этом массиве будет обладать признаком:
	* если это начало отрезка, то значение признака - `-1`
	* если это конец отрезка, то значение признака - `-2`
	* если это точка - индекс этой точки во входном массиве `points`
1. Сортируем массив точек по координате. 
	* Если координата совпадает, то стремимся расположить элемент с признаком точки между началом и концом отрезка.
1.  Идем по массиву и считаем в каком кол-ве отрезков находимся. Если встречаем точку - запоминаем для нее текущее значение счетчика кол-ва текущих отрезков.
	* Таким образом формируем ответ на задачу.