# Задача

[1094. Car Pooling](https://leetcode.com/problems/car-pooling/)

## Решение 1 - Time: $O(n * log(n))$, Memory: $O(n)$

```go
import "sort"

type BusStop struct {
    stopId int
    capacityDelta int
}

type ByIdAscCapDesc []BusStop

func (arr ByIdAscCapDesc) Len() int {
    return len(arr)
}

func (arr ByIdAscCapDesc) Less(i, j int) bool {
    if (arr[i].stopId == arr[j].stopId) {
        return arr[i].capacityDelta > arr[j].capacityDelta
    }

    return arr[i].stopId < arr[j].stopId
}

func (arr ByIdAscCapDesc) Swap(i, j int) {
    arr[i], arr[j] = arr[j], arr[i]
}

func carPooling(trips [][]int, capacity int) bool {
    stops := make([]BusStop, 2 * len(trips))

    i := 0
    for _, trip := range trips {
        stops[i].stopId = trip[1]
        stops[i].capacityDelta = -1*trip[0]

        stops[i+1].stopId = trip[2]
        stops[i+1].capacityDelta = trip[0]

        i += 2
    }

    sort.Sort(ByIdAscCapDesc(stops))

    for _, stop := range stops {
        capacity += stop.capacityDelta
        if capacity < 0 {
            return false
        }
    }

    return true
}
```

### Оценка 

#### По времени: $O(n * log(n))$
Где:
* `n` - кол-во поездок

Этапы:
* Подготовка массива остановок - $O(n)$
* Сортировка, предположим - $O(n * log(n))$
* Получение ответа - $O(2 * n)$
Таким образом верхняя оценка - $O(n * log(n))$.

#### По памяти: $O(n)$
Где:
* `n` - кол-во поездок

Этапы:
* Массив остановок - $O(2 * n)$
* Сортировка, предположительно - $O(n)$

Таким образом верхняя оценка - $O(n)$

### Описание решения
1. Разбиваем отрезки, в течении которых пассажиры находятся в авто, на 2 координаты:
	* ID станции посадки, также рядом кладем сколько мест займут пассажиры после посадки (положительное значение)
	* ID станции высадки, также рядом кладем сколько мест высвободят пассажиры при высадке (отрицательное значение)
1. Сортируем массив с координатами по возрастанию
1. Проходимся по массиву и по мере следования маршрута считаем кол-во свободных мест
	* если оно стало отрицательным - маршрут нельзя пройти