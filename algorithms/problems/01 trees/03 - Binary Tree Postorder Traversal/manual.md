# Задача

[145. Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/)

## Решение 1 - Time: $O(n)$, Memory: $O(n)$

```go
func inorderTraversal(root *TreeNode) (res []int) {
    var f func (*TreeNode)

    f = func (node *TreeNode) {
        if node != nil {
            f(node.Left)
            f(node.Right)
            res = append(res, node.Val)
        }
    }

    f(root)

    return
}
```

### Оценка 

#### По времени: $O(n)$
Где:
* `n` - кол-во узлов в дереве

#### По памяти: $O(n)$
Где:
* `n` - кол-во узлов в дереве

В общем случае $O(h)$, где `h` - высота дерева, но так как в худшем случае это будет вытянутая в струну структура - $O(n)$

### Описание решения

Порядок обработки для `post-order`:
1. левое поддерево
1. правое поддерево
1. **ТЕКУЩИЙ корень**
