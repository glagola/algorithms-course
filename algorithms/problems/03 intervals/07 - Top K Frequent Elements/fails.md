# Задача

[347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)

## Попытка 1
2024-01-09 19:21

```go
func topKFrequent(nums []int, k int) (res []int) {
    m := make(map[byte]byte)
    res = make([]int, k)

    maxFreq := 0 // Тут ошибка
    for _, v := range nums {
        m[v]++ // Тут ошибка

        if maxFreq < m[v] {
            maxFreq = m[v]
        }
    }

    freq := make([][]byte, maxFreq+1)

    for v, vFreq := range m {
        freq[vFreq] = append(freq[vFreq], v)
    }

    k--
    for i := len(freq)-1; i >= 0 && k >= 0; i-- {
        if len(freq[i]) == 0 {
            continue
        }

        for _, v := range freq[i] {
            res[k] = int(v)
            k--
        }
    }

    return
}
```

### Проблемы с Алгоритмом

Compile Error
>```
>Line 7: Char 11: cannot use v (variable of type int) as byte value in map index (solution.go)
>Line 9: Char 22: invalid operation: maxFreq < m[v] (mismatched types int and byte) (solution.go)
>Line 9: Char 24: cannot use v (variable of type int) as byte value in map index (solution.go)
>Line 10: Char 23: cannot use m[v] (map index expression of type byte) as int value in assignment (solution.go)
>Line 10: Char 25: cannot use v (variable of type int) as byte value in map index (solution.go)
>```

Попытка преждевременной оптимизации по памяти сыграла злую шутку - много ошибок на несовместимость типов `int` и `byte`.