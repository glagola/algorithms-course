# Задача

[1024. Video Stitching](https://leetcode.com/problems/video-stitching/)


## Решение 1 - Time: $O(n*log(n))$, Memory: $O(n)$

```go
import (
    "sort"
)

func videoStitching(clips [][]int, time int) (res int) {
    sort.Slice(clips, func(i, j int) bool {
        if clips[i][0] != clips[j][0] {
            return clips[i][0] < clips[j][0]
        }

        return clips[i][1] > clips[j][1]
    })

    current, maxNext := 0, 0
    processed := -1

    for {
        for i := processed + 1; i < len(clips) && clips[i][0] <= current; i++ {
            if maxNext < clips[i][1] {
                maxNext = clips[i][1]
                processed = i
            }
        }
        res++

        if current == maxNext {
            return -1
        }

        if time <= maxNext {
            return
        }

        current = maxNext
    }
}
```

### Оценка 

#### По времени: $O(n*log(n))$
Где:
* `n` - кол-во клипов

По этапам:
* Встроенная сортировка, предположительно - $O(n*log(n))$
* Поиск самого длинного списка из текущей точки, в худшем случае заставит пройтись по всем клипам - $O(n)$

#### По памяти: $O(n)$
Где:
* `n` - кол-во клипов

По этапам:
* Встроенная сортировка, предположительно - $O(n)$



### Описание решения

1. Сортируем отрезки по левой координате
	* если левые равны - вперед ставим самый длинный отрезок
1. Начинаем с точки 0
	1. Пытаемся переместить точку в конец самого длинного отрезка, который включает текущую точку
		1. попутно запоминаем index самого длинного отрезка, в следующей итерации начинать поиск будем с него
	1. Если переместить не вышло - не было кандидатов, достичь `time` невозможно
	1. Если достигли `time`, то возвращаем кол-во пройденных отрезков

## Решение 2 - Time: $O(n^2)$, Memory: $O(n)$

```go

import (
	"sort"
)

type Point struct {
	x      int
	spanId int
}

type ByOrder []Point

func (a ByOrder) Len() int {
	return len(a)
}

func (a ByOrder) Swap(i, j int) {
	a[i], a[j] = a[j], a[i]
}

func (a ByOrder) Less(i, j int) bool {
	if a[i].x != a[j].x {
		return a[i].x < a[j].x
	}

	return a[i].spanId > 0 
}

func videoStitching(clips [][]int, time int) (res int) {
	points := make([]Point, 2*len(clips))
	var exitClips []int

	i := 0
	for _, span := range clips {
		
		if time < span[0] || span[0] == span[1] {
			continue
		}
		index := i + 1

		points[i].x = span[0]
		points[i].spanId = index

		points[i+1].x = span[1]
		points[i+1].spanId = -index

		i += 2

		if span[0] <= time && time <= span[1] {
			exitClips = append(exitClips, index)
		}
	}
	points = points[:i]

	if len(exitClips) == 0 {
		return -1
	}

	sort.Sort(ByOrder(points))

	var currentPoints []int
	minPaths := make(map[int]int)

	for _, point := range points {
		if point.x == 0 {
			minPaths[point.spanId] = 1
			currentPoints = append(currentPoints, point.spanId)
			continue
		}

		if point.spanId < 0 {
			for i := 0; i < len(currentPoints); i++ {
				if currentPoints[i] == -point.spanId {
					currentPoints[i] = currentPoints[len(currentPoints)-1]
					currentPoints = currentPoints[:len(currentPoints)-1]
				}
			}
			continue
		}

		if len(currentPoints) == 0 {
			return -1
		}

		minPathToCurrent := len(clips)
		for _, spanId := range currentPoints {
			if mp, ok := minPaths[spanId]; ok && mp < minPathToCurrent {
				minPathToCurrent = mp
			}
		}

		minPaths[point.spanId] = minPathToCurrent + 1
		currentPoints = append(currentPoints, point.spanId)
	}

	res = len(clips)
	for _, spanId := range exitClips {
		if mPath, ok := minPaths[spanId]; ok && mPath < res {
			res = mPath
		}
	}

	return
}

```

### Оценка 

#### По времени: $O(n^2)$
Где:
* `n` - кол-во клипов

По этапам:
* Преобразование отрезков в точки - $O(n)$
* Встроенная сортировка, предположительно - $O(n*log(n))$
* Проход по массиву точек и поиск кратчайшего пути - $O(2*n*(n-1))$
	* Пример худшего случая
		* первый отрезок - `[0, 1]`
		* остальные `n-1` отрезков - `[1, time]`

Итого верхняя оценка - $O(n^2)$

#### По памяти: $O(n)$
Где:
* `n` - кол-во клипов

По этапам
* Преобразование отрезков/клипов в точки - $O(n)$
* Сортировка точек встроенным методом, предположительно - $O(n)$
* Подсчет минимальных путей - $O(2*n)$
* Хранение закрывающих клипов - $O(n)$

Итого верхняя оценка - $O(n)$

### Описание решения

Если кратко, то каждый отрезок/ролик можно представить вершиной графа, а факт наложения по времени одного ролика на другой - ребром (вес ребра равен `1`). 

Длина кратчайшего маршрута в графе от одной из начальных вершин/отрезков/клипов (клипы, которые стартуют в `0`) и до **конечных** (клипы которые заканчиваются в требуемое переменной `time` время) - будет минимальным кол-вом клипов, которое нужно для того чтобы сверстать видео.

Поиск кратчайшего пути (поиск в ширину) в данном случае состоит из следующих шагов:
1. Преобразования отрезков в точки, с признаком `id` (порядковый номер отрезка), где знак этого `id` говорит о том начинается (+) или заканчивается (-) отрезок.
	* попутно отфильтровываем клипы:
		* клипы `0` длины
		* клипы, которые не попадают в требуемый `time` хронометраж
	* попутно собираем вершины/отрезки/ролики, которые будут конечными (имеют видеоряд для периода времени `time`)
1. Сортировка точек по:
	1. координате
	1. если координаты двух отрезков равны, то закрывающая точка должна быть после открывающей
1. Проходя по отсортированному массиву
	1. поддерживаем актуальный список отрезков, которые пересекаются на данный момент в словаре
		1. стартовые вершины/отрезки/клипы, которые начинаются в `0`- заносятся в `minPath` со значением кратчайшего пути равным `1`.
		1. Если отрезок/клип закончился - удаляем его из словаря с текущими пересекающимися отрезками/клипами.
	1. также поддерживаем минимальное расстояние от стартовых вершин до всех пройденных вершин в словаре `minPath`
	1. если текущая точка начинает новый отрезок/клип:
		1. берем минимальное значение из `minPath` для всех пересекающихся отрезков на данный момент
		1. и для начинающегося отрезка/клипа в `minPath` записываем минимальное значение увеличенное на `1`. Таким образом минимальный путь от стартовых вершин/отрезков/клипов до текущей вершины/отрезка/клипа найден.
1. На текущий момент у нас есть минимальные расстояния от начальных вершин/отрезков/клипов до всех остальных - осталось пройтись по конечным отрезкам/клипам и выбрать минимальное значение. Это минимальное значение пути и будет минимальным кол-вом клипов, которые нужны чтобы смонтировать весь ролик. 