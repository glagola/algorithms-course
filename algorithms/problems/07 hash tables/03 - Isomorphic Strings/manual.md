# Задача

[205. Isomorphic Strings](https://leetcode.com/problems/isomorphic-strings/)


## Решение 1 - Time: $O(n)$, Memory: $O(n)$

```go
func solution(s string, t string) bool {
    m := make(map[byte]byte)

    for i := 0; i < len(s); i++ {
        sCh := s[i]
        tCh := t[i]

        if _tCh, ok := m[sCh]; !ok {
            m[sCh] = tCh
        } else {
            if _tCh != tCh {
                return false
            }
        }
    }

    return true
}

func isIsomorphic(s string, t string) bool {
    return solution(s, t) && solution(t, s)
}
```

### Оценка 
Где:
* `n` - длина строки `s` или `t` (по условию, они имеют одинаковую длину)

#### По времени: $O(n)$

Так как придется сначала проверить изоморфность `s` по отношению к `t`, а потом наоборот - $O(2*n)$

#### По памяти: $O(n)$
В худшем случае обе строки будут состоять из не повторяющихся символов и тогда затраты по памяти составят $O(n)$.


### Описание решения

Для каждого уникального символа `s` ставим в соответствие символ из строки `t`, если случается так что два символа указывают на один и тот же символ - строки не изоморфны. Сначала определяем изоморфность `s` по отношению к `t`, а потом наоборот.

## Решение 2 - Time: $O(n)$,  Memory: $O(n)$

```go
func isIsomorphic(s string, t string) bool {
    sM := make(map[byte]byte)
    tM := make(map[byte]byte)

    for i := 0; i < len(s); i++ {
        sCh := s[i]
        tCh := t[i]

        _tCh, sExists := sM[sCh]
        _sCh, tExists := tM[tCh]

        if sExists != tExists || sExists && tExists && (_sCh != sCh || _tCh != tCh) {
            return false
        }

        sM[sCh] = tCh
        tM[tCh] = sCh
    }

    return true
}
```

### Оценка 
Где:
* `n` - длина строки `s` или `t` (по условию, они имеют одинаковую длину)

#### По времени: $O(n)$

Если строки изоморфны - придется пройти всю строку.

#### По памяти: $O(n)$
В худшем случае обе строки будут состоять из не повторяющихся символов и тогда затраты по памяти составят $O(2*n)$.


### Описание решения

Для каждого уникального символа `s` ставим в соответствие символ из строки `t`, если случается так что два символа указывают на один и тотже символ - строки не изоморфны. 

