//
//  main.cpp
//  Algorithm
//
//  Created by 郑尧元 on 2018/5/6.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}


// day 1
// 面试题3（一）：找出数组中重复的数字
// 题目：在一个长度为n的数组里的所有数字都在0到n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，
// 也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数组{2, 3, 1, 0, 2, 5, 3}，
// 那么对应的输出是重复的数字2或者3。
bool duplicate(int numbers[], int length, int* duplication) {
    if (numbers == nullptr || length <= 0) {
        return false;
    }

    for (int i = 0; i < length; ++i) {
        if (numbers[i] < 0 || numbers[i] > length - 1) {
            return false;
        }
    }

    for (int i = 0; i < length; ++i) {
        while (numbers[i] != i) {
            if (numbers[numbers[i]] == numbers[i]) {
                *duplication = numbers[i];
                return true;
            }

            int tmp = numbers[i];
            numbers[i] = numbers[tmp];
            numbers[tmp] = tmp;
        }
    }

    return false;
}

// day2
// 不准修改数组，从长度为 n+1 的数组， 都在 1~n 的范围内，如何查找其中任何一个重复数字
/*
思路：1~8，以中间数 4 为界限，分别统计 1~4 和 5~8 的个数，哪一边的个数超过了 原本应该有的个数时，就说明里面有重复
 */
int countRange(const int* numbers, int length, int start, int end) {
    if (numbers == nullptr || length <= 0) {
        return 0;
    }

    int count = 0;
    for (int i = 0; i < length; i++) {
        if (numbers[i] >= start && numbers[i] <= end) {
            count++;
        }
    }

    return count;
}

int getDuplication(const int* numbers, int length) {

    // 最直观的方法，先按一个例子来做一遍！
    // 时间复杂度 O(nlogn)次
    // 安全性检查
    if (numbers == nullptr || length <= 0) {
        return -1;
    }
    // 设置开头和结尾
    int start = 1;
    int end = length - 1;

    // loop
    while (end >= start) {
        // 取中位数
        int middle = ((end - start) >> 1) + start;

        // 获取前半段的 个数
        int count = countRange(numbers, length, start, middle);

        // 如果 end start 已经相等了，说明已经到了找出重复数字结果的时候！！
        if (end == start) {
            if (count > 1) {
                return start;
            } else {
                break;
            }
        }

        // 缩小范围的过程
        if (count > (middle - start + 1)) {
            end = middle;
        } else {
            start = middle + 1;
        }
    }

    return -1;
}

// day 3
// 从二维数组中，查找某个数，从上到下，从左到右，递增，全部是整数
bool Find(int* matrix, int rows, int columns, int number) {
    bool find = false;

    // 从右上角 或者左下角 开始查找 是正确的做法！
    if (matrix != nullptr && rows > 0 && columns > 0) {
        int row = 0;
        int column = columns - 1;
        while (row <= rows - 1 && columns >= 0) {
            int inNumber = matrix[row * columns + column];
            if (inNumber == number) {
                find = true;
                break;
            } else if (inNumber > number) {
                --column;
            } else {
                ++row;
            }
        }
    }

    return find;
}

// day 4
// 实现在 字符串中，将空格替换为 “%20”！
// 思路：从后往前添加 时间复杂度 O(n)

// length 指数组的总容量
/*
 整体思路：
 1、安全性检查
 2、遍历一遍数组，查找空格的个数。
 3、检查新数组长度是否会超出限制。
 4、设置两个下标，一个在老长度上的末尾，一个在新长度的末尾。
 5、向前遍历，如果是空格，则替换 字符
 6、何时继续 当下标 >= 0  老长度下标小于 新长度时。
 */
void replaceBlank(char string[], int length) {
    // 安全性检查
    if (string == nullptr || length <= 0) {
        return;
    }

    // 遍历 获取空格个数
    int originalLength = 0;
    int numberOfBlank = 0;
    int i = 0;
    // 字符串的终止符
    while (string[i] != '\0') {
        // 统计字符串 原长度
        ++originalLength;
        if (string[i] == ' ') {
            ++numberOfBlank;
        }

        ++i;
    }

    int newLength = originalLength + 2 * numberOfBlank;

    // 如果新数组长度超过限制，就不处理了
    if (newLength > length) {
        return;
    }

    // 因为字符串多了额外的终止符，所以下标位置就不用减一啦
    int indexOfOriginal = originalLength;
    int indexOfNew = newLength;
    while (indexOfOriginal >= 0 && indexOfNew > indexOfOriginal) {
        // 先移动后面的指针 indexOfNew
        if (string[indexOfOriginal] == ' ') {
            string[indexOfNew--] = '0';
            string[indexOfNew--] = '2';
            string[indexOfNew--] = '%';
        } else {
            string[indexOfNew--] = string[indexOfOriginal];
        }
        // 后移动 indexOfOriginal
        -- indexOfOriginal;
    }
}

// day 5 链表问题

// 往链表的末尾添加节点
struct ListNode {
    int m_nValue;
    ListNode* m_pNext;
};

// 因为需要修改指针，所以必须传入指针的指针才有效果。
void AddToTail(ListNode** pHead, int value) {
    // 创建新 node
    ListNode* pNew = new ListNode();
    pNew->m_nValue = value;
    pNew->m_pNext = nullptr;

    // 如果头指针是空指针，就把新节点作为头，否则找到 m_pNext 为 nullptr 时，再插入
    if (*pHead == nullptr) {
        *pHead = pNew;
    } else {
        ListNode* node = *pHead;
        while (node->m_pNext != nullptr) {
            node = node->m_pNext;
        }

        node->m_pNext = pNew;
    }
}

void RemoveNode(ListNode** pHead, int value) {
    // 安全性检查
    if (pHead == nullptr || *pHead == nullptr) {
        return;
    }

    ListNode* pToBeDeleted = nullptr;
    // 头指针判断
    if ((*pHead)->m_nValue) {
        pToBeDeleted = *pHead;
        *pHead = (*pHead)->m_pNext;
    } else {
        // 其它情况 遍历查找
        ListNode* node = *pHead;
        while (node->m_pNext != nullptr && node->m_pNext->m_nValue != value) {
            node = node->m_pNext;
        }

        if (node->m_pNext != nullptr && node->m_pNext->m_nValue == value) {
            pToBeDeleted = node->m_pNext;
            node->m_pNext = node->m_pNext->m_pNext;
        }
    }



    // 删除、将指针置空
    if (pToBeDeleted != nullptr) {
        delete pToBeDeleted;
        pToBeDeleted = nullptr;
    }
}

// 从尾到头，打印节点

// 思考过程：一般人会认为是否可以反转链表，然后遍历打印。我们需要向面试官确认条件，是否允许。另外一个办法是
/*
 1. 用栈结构，先进后出 需要额外占用内存

首先遍历链表(note 遍历时候，必须新声明一个指针进行移动，不能改变之前的了)，将所有节点存储进栈 push
开始遍历栈，将节点打印，然后 pop

 2. 递归方式 需要注意防止栈溢出

 */
void PrintListReversingly_Recursively(ListNode* pHead) {
    if (pHead != nullptr) {
        if (pHead->m_pNext != nullptr) {
            PrintListReversingly_Recursively(pHead->m_pNext);
        }

        printf("%d\t", pHead->m_nValue);
    }
}

// 树
/*
前序、中序、后序遍历
 */

// 输入前序和中序 重建二叉树
struct BinaryTreeNode {
    int m_nValue;
    BinaryTreeNode* m_pLeft;
    BinaryTreeNode* m_pRight;
    BinaryTreeNode* m_pParent;
};

BinaryTreeNode* Construct(int* preorder, int* inorder, int length) {
    if (preorder == nullptr || inorder == nullptr || length <= 0) {
        return nullptr;
    }

    return nullptr;
}

BinaryTreeNode* ConstructCore
(
 int* startPreorder, int* endPreorder,
 int* startInorder, int* endInorder
 )
{
    // 前序遍历 第一个是根节点的值
    int rootValue = startPreorder[0];
    // 构建二叉树
    BinaryTreeNode* root = new BinaryTreeNode();
    root->m_nValue = rootValue;
    root->m_pLeft = root->m_pRight = nullptr;

    if (startPreorder == endPreorder) {
        if (startInorder == endInorder && *startPreorder == *startInorder) {
            return root;
        } else {
//            throw std::exception("Invalid input");
        }
    }

    // 在中序遍历序列中找到根节点的值
    int* rootInorder = startInorder;
    while (rootInorder <= endInorder && *rootInorder != rootValue) {
        ++rootInorder;
    }

    if (rootInorder == endInorder && *rootInorder != rootValue) {
        // 抛异常
    }

    // 有写错吗？
    int leftLength = rootInorder - startInorder;
    int* leftPreorderEnd = startPreorder + leftLength;
    if (leftLength > 0) {
        // 构建左子树
        root->m_pLeft = ConstructCore(startPreorder + 1, leftPreorderEnd, startInorder, rootInorder - 1);
    }
    if (leftLength < endPreorder - startPreorder) {
        // 构建右子树
        root->m_pRight = ConstructCore(leftPreorderEnd + 1, endPreorder, rootInorder + 1, endInorder);
    }


    return root;
}

//day 8
/*
二叉树的下一个节点
 给定一棵二叉树和其中一个节点，如何找出中序遍历序列的下一个节点？
 每个节点

 思路：
 1、如果该节点下有右子树，则下个节点是右子树的最左节点
 2、如果没有右子树，并且它是父节点的左子节点，那么下一个节点是父节点
 3、如果没有右子树，并且是父节点的右子节点时，那么就要沿着它的父节点，往上遍历查找到一个节点（这个节点必须是它父节点的左子节点的才行），那么这个父节点就是符合条件的

 换一种遍历方式，头脑风暴一下吧。
 */
BinaryTreeNode* GetNext(BinaryTreeNode* pNode) {
    if (pNode == nullptr) {
        return nullptr;
    }

    BinaryTreeNode *pNext = nullptr;
    // 如果该节点下有右子树
    if (pNode->m_pRight != nullptr) {
        BinaryTreeNode* pRight = pNode->m_pRight;
        while (pRight->m_pLeft != nullptr) {
            pRight = pRight->m_pLeft;
        }
        pNext = pRight;
    } else if (pNode->m_pParent != nullptr) {
        // 父节点，是父节点的左子树，直接返回父节点。是父节点的右子树，则往上遍历，并且是左子节点的情况，OK
        BinaryTreeNode* pCurrent = pNode;
        BinaryTreeNode* pParent = pNode->m_pParent;
        while (pParent != nullptr && pParent->m_pRight == pCurrent) {
            pCurrent = pParent;
            pParent = pParent->m_pParent;
        }

        pNext = pParent;
    }

    return pNext;
}









