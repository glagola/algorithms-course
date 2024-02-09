# Задача

[36. Valid Sudoku](https://leetcode.com/problems/valid-sudoku/)

## Решение 1 - Time: $O(n^2)$, Memory: $O(n)$

```go
const (
    n = 9
    subn = n / 3
    emptyCell = '.'
)

func isValidSudoku(board [][]byte) bool {
    set := make([]byte, n)
    
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == emptyCell {
                continue
            }
            digit := board[i][j] - '1'

            set[digit]++

            if set[digit] > 1 {
                return false
            }
        }
        fillZero(set)
    }

    for j := 0; j < n; j++ {
        for i := 0; i < n; i++ {
            if board[i][j] == emptyCell {
                continue
            }
            digit := board[i][j] - '1'

            set[digit]++

            if set[digit] > 1 {
                return false
            }
        }
        fillZero(set)
    }

    for i := 0; i < n / subn; i++ {
        for j := 0; j < n / subn; j++ {

            for _i := 0; _i < subn; _i++ {
                for _j := 0; _j < subn; _j++ {
                    k := i * subn + _i
                    l := j * subn + _j
                    
                    if board[k][l] == emptyCell {
                        continue
                    }

                    digit := board[k][l] - '1'

                    set[digit]++

                    if set[digit] > 1 {
                        return false
                    }
                }
            }

            fillZero(set)
        }
    }

    return true
}

func fillZero(arr []byte) {
    for i := 0; i < n; i++ {
        arr[i] = 0
    }
}
```

### Оценка 

Для формализации оценки предположим, что `n = 9`

#### По времени: $O(n^2)$
Где:
* `n` - размер списка `nums`

Оценка сложности суб-алгоритмов:
1. поиск дубликатов в строках - $O(n^2)$
1. поиск дубликатов в столбцах - $O(n^2)$
1. поиск дубликатов в суб-квадаратах - $O(n^2)$

#### По памяти: $O(n)$
Где:
* `n` - размер списка `nums`

Так как в ячейках числа должны быть от 1 до 9, для подсчета их кол-ва достаточно линейного массива длины `n`

### Описание решения

Общий подход - посчитать сколько цифр использовалось в том или ином участке судоку. Если попались дубликаты - сразу возвращаем `false`. Далее сначала проходим все строки, потом столбцы, потом суб-квадраты. Если нигде нет дубликатов - текущее состояние судоку корректно.