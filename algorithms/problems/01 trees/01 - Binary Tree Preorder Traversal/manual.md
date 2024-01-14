# Задача

[144. Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal/)

## Решение 1 - Time: $O(n)$, Memory: $O(n)$

```go
func preorderTraversal(root *TreeNode) (res []int) {
    var f func (*TreeNode)

    f = func (node *TreeNode) {
        if node != nil {
            res = append(res, node.Val)
            f(node.Left)
            f(node.Right)
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

Порядок обработки вершин для preOrder:
1. текущая вершина
1. левое поддерево
1. правое поддерево
