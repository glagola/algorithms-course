# Задача

[452. Minimum Number of Arrows to Burst Balloons](https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/)

## Решение 1 - Time: $O(n*log(n))$, Memory: $O(1)$

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
        start, finish := intersection(points[i], points[j])
        if start <= finish {
            points[i][0], points[i][1] = start, finish
        } else {
            i++
            points[i] = points[j]
        }
    }

    return i + 1
}

func intersection(p1, p2 []int) (int, int) {
    return max(p1[0], p2[0]), min(p1[1], p2[1])
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

### Оценка 

#### По времени: $O(n*log(n))$
Где:
* `n` - кол-во шаров

Шаги:
* Сортировка, предположительно - $O(n*log(n))$
* Проход по оставшимся отрезкам-пересечениям - $O(k)$, где `k` - кол-во оставшихся пересечений $k <= n$

Таким образом верхняя оценка - $O(n*log(n))$

#### По памяти: $O(1)$
Где:
* `n` - кол-во шаров

Шаги:
* Встроенная сортировка, предположительно - $O(n)$

Но если оценивать алгоритм, то дополнительная память не зависит от входных данных, поэтому верхняя оценка - $O(1)$

### Описание решения

1. Сортируем шары/интервалы/отрезки по начальной точке
2. Идем с начала отсортированного массива и находим пересечение отрезков:
	1. если текущее пересечение пересекается со следующим отрезком - заменяем текущее пересечение на результат их пересечения
	2. если текущее пересечение не пересекает следующий отрезок - делаем следующий отрезок текущим пересечением
3. После такого прохода будет найдено `k` пересечений. Соответственно выпустив стрелы в этих `k` отрезках и получится поразить все шары, а кол-во выпущенных стрел будет минимальным. Таким образом ответом будет `k`.