# Задача

[1. Two Sum](https://leetcode.com/problems/two-sum/)

## Попытка 1
2024-02-09 21:52

```go
func twoSum(nums []int, target int) []int {
    m := make(map[int]int, len(nums))

    for i, v := range nums {
        if anotherId, exists := m[target - v]; exists {
            return []int{anotherId, i}
        }

        m[v] = i
    }

    // тут проблема
}
```

### Проблемы со спецификой языка
Даже если по условию задачи всегда существует решение - язык требует наличия обязательного `return`.