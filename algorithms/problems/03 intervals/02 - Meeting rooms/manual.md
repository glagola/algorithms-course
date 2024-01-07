# Задача

[Meeting rooms](https://www.interviewbit.com/problems/meeting-rooms/)

## Решение 1 - Time: $O(n*log(n))$, Memory: $O(n)$

```go

import "sort"
 
type ByAbsValue []int

func (a ByAbsValue) Len() int {
    return len(a)
}

func (a ByAbsValue) Less(i, j int) bool {
    _i := abs(a[i])
    _j := abs(a[j])
    if _i == _j {
        return sign(a[i]) < sign(a[j])
    }
    
    return _i < _j
}

func (a ByAbsValue) Swap(i, j int) {
    a[i], a[j] = a[j], a[i]
}


func abs(a int) int {
    if a < 0 {
        return -1*a
    }
    return a
}

func sign(a int) int {
    if a < 0 {
        return -1
    }
    
    return 1
}
 
 
func solve(A [][]int)  (res int) {
    points := make([]int, 0, len(A)*2)
    
    for _, span := range A {
        points = append(points, span[0], -1 * span[1])
    }
    
    sort.Sort(ByAbsValue(points))
    
    roomsTaken := 0
    for _, v := range points {
        if v < 0 {
            roomsTaken--
        } else {
            roomsTaken++
        }
        
        if res < roomsTaken {
            res = roomsTaken
        }
    }
    
    return
}

```

### Оценка 

#### По времени: $O(n*log(n))$
Где:
* `n` - кол-во совещаний

За $O(n)$ преобразовываем расписания в массив временных меток. И за $O(n*log(n))$ сортируем их. Таким образом затраты по времени $O(n + n*log(n))$ = $O(n*log(n))$

#### По памяти: $O(n)$
Где:
* `n` - кол-во совещаний

Для того чтобы отсортировать временные метки нужно их поместить в массив, на что потребуется $O(2*n)$, так как у расписания две составляющие: начало и конец. Таким дополнительные затраты по памяти составят $O(n)$

### Описание решения

1. Преобразовываем расписание каждого совещания в два независимых числа:
	1. начало совещания - используется как есть
	1. конец совещания - берется его значение и умножается на -1
1. Сортируем все числа по модулю чисел, если два числа по модулю равны - впереди должно идти отрицательное число. Так как сначала завершается предыдущее совещание, а потом начинается новое.
1. Проходимся по отсортированному массиву
	1. каждый раз когда встречаем положительно число - увеличиваем счетчик комнат, а когда отрицательное - уменьшаем
	1. ищем максимальное значение счетчика комнат, в процессе обхода списка временных меток
1. Максимальное значение счетчика комнат и есть искомое значение 