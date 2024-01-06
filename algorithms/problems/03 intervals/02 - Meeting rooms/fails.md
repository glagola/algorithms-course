# Задача

[Meeting rooms](https://www.interviewbit.com/problems/meeting-rooms/)

## Попытка 1
2024-01-06 22:16

```go

type ByAbsValue []int

func (a ByAbsValue) Len() int {
    return len(a)
}

func (a ByAbsValue) Less(i, j int) bool {
    _i := abs(a[i])
    _j := abs(a[j])
    if _i == _j {
        return sign(a[i]) > sign(a[j])
    }
    
    return _i < _j
}

func (a ByAbsValue) Swap(i, j int) {
    a[i], a[j] = a[j], a[i]
}


func abs(a int) { // Тут проблема
    if a < 0 {
        return -1*a
    }
    return a
}

func sign(a int) { // Тут проблема
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
    
    max := 0
    for _, v := range points {
        if v < 0 {
            res--
        } else {
            res++
        }
        
        if max < res {
            max = res
        }
    }
    
    return
}

```

### Проблемы с синтаксисом
Забыл указать тип возвращаемого значения для функций:
* `abs` 
* `sign`

## Попытка 2
2024-01-06 22:18

```go
 
type ByAbsValue []int

func (a ByAbsValue) Len() int {
    return len(a)
}

func (a ByAbsValue) Less(i, j int) bool {
    _i := abs(a[i])
    _j := abs(a[j])
    if _i == _j {
        return sign(a[i]) > sign(a[j])
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
    
    sort.Sort(ByAbsValue(points)) // Тут проблема
    
    max := 0
    for _, v := range points {
        if v < 0 {
            res--
        } else {
            res++
        }
        
        if max < res {
            max = res
        }
    }
    
    return
}

```

### Проблемы с синтаксисом
Забыл импортировать пакет `sort`.

## Попытка 3
2024-01-06 22:21

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
        return sign(a[i]) > sign(a[j])
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
 
 
func solve(A [][]int) (res int) {
    points := make([]int, 0, len(A)*2)
    
    for _, span := range A {
        points = append(points, span[0], -1 * span[1])
    }
    
    sort.Sort(ByAbsValue(points))
    
    max := 0
    for _, v := range points {
        if v < 0 {
            res--
        } else {
            res++
        }
        
        if max < res {
            max = res // тут проблема
        }
    }
    
    return
}

```

### Проблемы с алгоритмом
Перепутал счетчик используемых в данный момент комнат (`res`) и максимальные показатели этого счетчика (`max`).  Результат получается лежит в `max`, а должен быть в `res`.

## Попытка 4
2024-01-06 22:35

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
        return sign(a[i]) > sign(a[j]) // Тут проблема
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
    
    curr := 0
    for _, v := range points {
        if v < 0 {
            curr--
        } else {
            curr++
        }
        
        if res < curr {
            res = curr
        }
    }
    
    return
}

```

### Проблемы с алгоритмом
В отсортированном массиве, если два числа равны по модулю, то сначала должно идти отрицательное число, потом положительное. То есть мы сначала заканчиваем предыдущую встречу, а потом начинаем новую.