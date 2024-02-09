# Задача

[205. Isomorphic Strings](https://leetcode.com/problems/isomorphic-strings/)

## Попытка 1
2024-02-10 00:10

```go
func isIsomorphic(s string, t string) bool {
    sM := make(map[byte]byte, len(s))
    tM := make(map[byte]byte, len(t))

    for i := 0; i < len(s); i++ {
        sCh := s[i]
        tCh := t[i]

        _tCh, sExists := sM[sCh]
        _sCh, tExists := tM[tCh]

        if sExists != tExists || _sCh != sCh || _tCh != tCh { // тут ошибка
            return false
        }

        sM[sCh] = tCh
        tM[tCh] = sCh
    }
}

```

### Проблемы с алгоритмом
Переусложнил - попытался сразу проверить изоморфность `s` по отношению к `t` и наоборот. В результате запутался в условии, когда нарушается изоморфность.