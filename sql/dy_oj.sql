-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dy_oj
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `post`
--


create database if not exists dy_oj;

-- 切换库
use dy_oj;


DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `tags` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签列表（json 数组）',
  `thumbNum` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `favourNum` int NOT NULL DEFAULT '0' COMMENT '收藏数',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帖子';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_favour`
--

DROP TABLE IF EXISTS `post_favour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_favour` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `postId` bigint NOT NULL COMMENT '帖子 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_postId` (`postId`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='帖子收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_favour`
--

LOCK TABLES `post_favour` WRITE;
/*!40000 ALTER TABLE `post_favour` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_favour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_thumb`
--

DROP TABLE IF EXISTS `post_thumb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_thumb` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `postId` bigint NOT NULL COMMENT '帖子 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_postId` (`postId`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='帖子点赞';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_thumb`
--

LOCK TABLES `post_thumb` WRITE;
/*!40000 ALTER TABLE `post_thumb` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_thumb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `tags` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签列表（json 数组）',
  `answer` text COLLATE utf8mb4_unicode_ci COMMENT '题目参考代码',
  `submitNum` int NOT NULL DEFAULT '0' COMMENT '用户提交数',
  `acceptedNum` int NOT NULL DEFAULT '0' COMMENT '题目通过数',
  `judgeCase` text COLLATE utf8mb4_unicode_ci COMMENT '判题用例(json 数组)',
  `judgeConfig` text COLLATE utf8mb4_unicode_ci COMMENT '判题配置(json 对象)',
  `thumbNum` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `favourNum` int NOT NULL DEFAULT '0' COMMENT '收藏数',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=1812343707871932418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帖子';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`id`, `title`, `content`, `tags`, `answer`, `submitNum`, `acceptedNum`, `judgeCase`, `judgeConfig`, `thumbNum`, `favourNum`, `userId`, `createTime`, `updateTime`, `isDelete`) VALUES (1,'A + B','## 题目描述\r\n输入两个整数，求这两个整数的和是多少。\r\n\r\n## 输入格式\r\n输入两个整数A, B空格隔开\r\n\r\n## 输出格式\r\n输出一个整数，表示这两个数的\r\n\r\n## 数据范围\r\n0≤A,B≤108','[\"简单\"]','```java\r\nimport java.util.Scanner;\r\npublic class Main{\r\n\r\n    public static void main(String[] args) {\r\n        Scanner scanner = new Scanner(System.in);\r\n        int a = scanner.nextInt();\r\n        int b = scanner.nextInt();\r\n\r\n        System.out.println(a + b);\r\n\r\n    }\r\n}\r\n```',0,0,'[{\"input\":\"1 2\",\"output\":\"3\"}, {\"input\":\"10 5\",\"output\":\"15\"}]','{\"timeLimit\":\"1000\",\"memoryLimit\":\"25600000\",\"stackLimit\":\"00\"}',0,0,1812110668646477826,'2023-07-14 12:29:46','2024-08-21 17:11:46',0),(2,'两数之和','给定一个整数数组 `nums` 和一个整数目标值 `target`，请你在该数组中找出 **和为目标值** *`target`* 的那 **两个** 整数，并返回它们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。\n\n你可以按任意顺序返回答案。\n\n \n\n**示例 1：**\n\n```\n输入：\n2,7,11,15\n9\n输出：\n0,1\n解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。\n```\n\n**示例 2：**\n\n```\n输入：\n3,2,4\n6\n输出：\n1,2\n```\n\n**示例 3：**\n\n```\n输入：\n3,3\n6\n输出：\n0,1\n```\n\n \n\n**提示：**\n\n- `2 <= nums.length <= 104`\n- `-109 <= nums[i] <= 109`\n- `-109 <= target <= 109`\n- **只会存在一个有效答案**\n\n \n\n**进阶：**你可以想出一个时间复杂度小于 `O(n2)` 的算法吗？','[\"数组\",\"哈希表\"]','#### 方法一：暴力枚举\n\n##### 思路及算法\n\n最容易想到的方法是枚举数组中的每一个数 `x`，寻找数组中是否存在 `target - x`。\n\n当我们使用遍历整个数组的方式寻找 `target - x` 时，需要注意到每一个位于 `x` 之前的元素都已经和 `x` 匹配过，因此不需要再进行匹配。而每一个元素不能被使用两次，所以我们只需要在 `x` 后面的元素中寻找 `target - x`。\n\n##### 代码\n\n```Java\nimport java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        String str = scanner.nextLine();\n        int target = scanner.nextInt();\n\n        String[] split = str.split(\",\");\n        int len = split.length;\n        int[] nums = new int[len];\n\n        for (int i = 0; i < len; i++) {\n            nums[i] = Integer.parseInt(split[i]);\n        }\n\n        for (int i = 0; i < len; ++i) {\n            for (int j = i + 1; j < len; ++j) {\n                if (nums[i] + nums[j] == target) {\n                    System.out.println(i + \",\" + j);\n                    System.exit(0);\n                }\n            }\n        }\n\n        System.exit(0);\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O(N^2)$，其中 NNN 是数组中的元素数量。最坏情况下数组中任意两个数都要被匹配一次。\n- 空间复杂度：$O(1)$。\n\n#### 方法二：哈希表\n\n##### 思路及算法\n\n注意到方法一的时间复杂度较高的原因是寻找 `target - x` 的时间复杂度过高。因此，我们需要一种更优秀的方法，能够快速寻找数组中是否存在目标元素。如果存在，我们需要找出它的索引。\n\n使用哈希表，可以将寻找 `target - x` 的时间复杂度降低到从 $O(N)$ 降低到 $O(1)$。\n\n这样我们创建一个哈希表，对于每一个 `x`，我们首先查询哈希表中是否存在 `target - x`，然后将 `x` 插入到哈希表中，即可保证不会让 `x` 和自己匹配。\n\n##### 代码\n\n```Java\nclass Solution {\n    public int[] twoSum(int[] nums, int target) {\n        Map<Integer, Integer> hashtable = new HashMap<Integer, Integer>();\n        for (int i = 0; i < nums.length; ++i) {\n            if (hashtable.containsKey(target - nums[i])) {\n                return new int[]{hashtable.get(target - nums[i]), i};\n            }\n            hashtable.put(nums[i], i);\n        }\n        return new int[0];\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O(N)$，其中 $N$ 是数组中的元素数量。对于每一个元素 `x`，我们可以 $O(1)$ 地寻找 `target - x`。\n- 空间复杂度：$O(N)$，其中 $N$ 是数组中的元素数量。主要为哈希表的开销。',9,2,'[{\"input\":\"2,7,11,15\\n9\",\"output\":\"0,1\"},{\"input\":\"3,2,4\\n6\",\"output\":\"1,2\"},{\"input\":\"3,3\\n6\",\"output\":\"0,1\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-01 21:38:35','2024-08-21 17:10:58',0),(3,'无重复字符的最长子串','给定一个字符串 `s` ，请你找出其中不含有重复字符的 **最长子串** 的长度。\n\n**示例 1:**\n\n```\n输入: \nabcabcbb\n输出: \n3\n解释: 因为无重复字符的最长子串是 \"abc\"，所以其长度为 3。\n```\n\n**示例 2:**\n\n```\n输入: \nbbbbb\n输出: \n1\n解释: 因为无重复字符的最长子串是 \"b\"，所以其长度为 1。\n```\n\n**示例 3:**\n\n```\n输入: \npwwkew\n输出: \n3\n解释: 因为无重复字符的最长子串是 \"wke\"，所以其长度为 3。\n     请注意，你的答案必须是 子串 的长度，\"pwke\" 是一个子序列，不是子串。\n```\n\n**提示：**\n\n- `0 <= s.length <= 5 * 104`\n- `s` 由英文字母、数字、符号和空格组成\n','[\"哈希表\",\"字符串\",\"滑动窗口\"]','#### 思路：\n\n这道题主要用到思路是：滑动窗口\n\n什么是滑动窗口？\n\n其实就是一个队列,比如例题中的 `abcabcbb`，进入这个队列（窗口）为 `abc` 满足题目要求，当再进入 `a`，队列变成了 `abca`，这时候不满足要求。所以，我们要移动这个队列！\n\n如何移动？\n\n我们只要把队列的左边的元素移出就行了，直到满足题目要求！\n\n一直维持这样的队列，找出队列出现最长的长度时候，求出解！\n\n时间复杂度：$O(n)$\n\n#### 代码：\n\n```Java\nimport java.util.HashMap;\nimport java.util.Scanner;\n\nclass Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.nextLine();\n        System.out.println(lengthOfLongestSubstring(s));\n        System.exit(0);\n    }\n\n    public static int lengthOfLongestSubstring(String s) {\n        if (s.isEmpty()) return 0;\n        HashMap<Character, Integer> map = new HashMap<Character, Integer>();\n        int max = 0;\n        int left = 0;\n        for(int i = 0; i < s.length(); i ++){\n            if(map.containsKey(s.charAt(i))){\n                left = Math.max(left,map.get(s.charAt(i)) + 1);\n            }\n            map.put(s.charAt(i),i);\n            max = Math.max(max,i-left+1);\n        }\n        return max;\n        \n    }\n}\n```',7,2,'[{\"input\":\"abcabcbb\",\"output\":\"3\"},{\"input\":\"bbbbb\",\"output\":\"1\"},{\"input\":\"pwwkew\",\"output\":\"3\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-01 21:41:56','2024-08-21 17:10:49',0),(4,'整数反转','给你一个 32 位的有符号整数 `x` ，返回将 `x` 中的数字部分反转后的结果。\n\n如果反转后整数超过 32 位的有符号整数的范围 `[−231, 231 − 1]` ，就返回 0。\n\n**假设环境不允许存储 64 位整数（有符号或无符号）。**\n\n \n\n**示例 1：**\n\n```\n输入：x = 123\n输出：321\n```\n\n**示例 2：**\n\n```\n输入：x = -123\n输出：-321\n```\n\n**示例 3：**\n\n```\n输入：x = 120\n输出：21\n```\n\n**示例 4：**\n\n```\n输入：x = 0\n输出：0\n```\n\n \n\n**提示：**\n\n- `-231 <= x <= 231 - 1`','[\"数学\"]','\n\n#### 代码\n\n```Java\nimport java.util.Scanner;\n\nclass Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        int num = scanner.nextInt();\n        System.out.println(reverse(num));\n        System.exit(0);\n    }\n    \n    public static int reverse(int x) {\n        int rev = 0;\n        while (x != 0) {\n            if (rev < Integer.MIN_VALUE / 10 || rev > Integer.MAX_VALUE / 10) {\n                return 0;\n            }\n            int digit = x % 10;\n            x /= 10;\n            rev = rev * 10 + digit;\n        }\n        return rev;\n    }\n}\n```\n\n',3,1,'[{\"input\":\"0\",\"output\":\"0\"},{\"input\":\"123\",\"output\":\"321\"},{\"input\":\"-123\",\"output\":\"-321\"},{\"input\":\"120\",\"output\":\"21\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-01 21:44:19','2024-08-21 17:10:42',0),(5,'有效的括号','给定一个只包括 `\'(\'`，`\')\'`，`\'{\'`，`\'}\'`，`\'[\'`，`\']\'` 的字符串 `s` ，判断字符串是否有效。\n\n有效字符串需满足：\n\n1. 左括号必须用相同类型的右括号闭合。\n2. 左括号必须以正确的顺序闭合。\n3. 每个右括号都有一个对应的相同类型的左括号。\n\n \n\n**示例 1：**\n\n```\n输入：\n()\n输出：\ntrue\n```\n\n**示例 2：**\n\n```\n输入：\n()[]{}\n输出：\ntrue\n```\n\n**示例 3：**\n\n```\n输入：\n(]\n输出：\nfalse\n```','[\"栈\",\"字符串\"]','#### 解题思路：\n\n- **算法原理**\n  - 栈先入后出特点恰好与本题括号排序特点一致，即若遇到左括号入栈，遇到右括号时将对应栈顶左括号出栈，则遍历完所有括号后 `stack` 仍然为空；\n  - 建立哈希表 `dic` 构建左右括号对应关系：$key$ 左括号，$value$ 右括号；这样查询 $2$ 个括号是否对应只需 $O(1)$ 时间复杂度；建立栈 `stack`，遍历字符串 `s` 并按照算法流程一一判断。\n- **算法流程**\n  1. 如果 `c` 是左括号，则入栈 $push$；\n  2. 否则通过哈希表判断括号对应关系，若 `stack` 栈顶出栈括号 `stack.pop()` 与当前遍历括号 `c` 不对应，则提前返回 $false$。\n- **提前返回** $false$\n  - **提前返回优点：** 在迭代过程中，提前发现不符合的括号并且返回，提升算法效率。\n  - **解决边界问题：**\n    - **栈 `stack` 为空：** 此时 `stack.pop()` 操作会报错；因此，我们采用一个取巧方法，给 `stack` 赋初值 `?` ，并在哈希表 `dic` 中建立 `key:′?′，value:′?′`的对应关系予以配合。此时当 `stack` 为空且 `c` 为右括号时，可以正常提前返回 $false$；\n    - **字符串 `s` 以左括号结尾：** 此情况下可以正常遍历完整个 `s`，但 `stack` 中遗留未出栈的左括号；因此，最后需返回 `len(stack) == 1`，以判断是否是有效的括号组合。\n\n- **复杂度分析**\n  - 时间复杂度 $O(N)$：正确的括号组合需要遍历 $1$ 遍 `s`；\n  - 空间复杂度 $O(N)$：哈希表和栈使用线性的空间大小。\n\n```Java\nimport java.util.HashMap;\nimport java.util.LinkedList;\nimport java.util.Map;\nimport java.util.Scanner;\n\npublic class Main{\n    private static final Map<Character,Character> map = new HashMap<Character,Character>(){{\n        put(\'{\',\'}\'); put(\'[\',\']\'); put(\'(\',\')\'); put(\'?\',\'?\');\n    }};\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.nextLine();\n\n        if(!s.isEmpty() && !map.containsKey(s.charAt(0))) {\n            System.out.println(false);\n            System.exit(0);\n        }\n        LinkedList<Character> stack = new LinkedList<Character>() {{ add(\'?\'); }};\n        for(Character c : s.toCharArray()){\n            if(map.containsKey(c)) stack.addLast(c);\n            else if(map.get(stack.removeLast()) != c){\n                System.out.println(false);\n                System.exit(0);\n            }\n        }\n\n        System.out.println(stack.size() == 1);\n        System.exit(0);\n    }\n}\n```',3,2,'[{\"input\":\"()\",\"output\":\"true\"},{\"input\":\"()[]{}\",\"output\":\"true\"},{\"input\":\"(]\",\"output\":\"false\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-01 21:45:57','2024-08-21 17:10:33',0),(6,'合并两个有序数组','给你两个按 **非递减顺序** 排列的整数数组 `nums1` 和 `nums2`，另有两个整数 `m` 和 `n` ，分别表示 `nums1` 和 `nums2` 中的元素数目。\n\n请你 **合并** `nums2` 到 `nums1` 中，使合并后的数组同样按 **非递减顺序** 排列。\n\n**注意：**最终，合并后数组不应由函数返回，而是存储在数组 `nums1` 中。为了应对这种情况，`nums1` 的初始长度为 `m + n`，其中前 `m` 个元素表示应合并的元素，后 `n` 个元素为 `0` ，应忽略。`nums2` 的长度为 `n` 。\n\n \n\n**示例 1：**\n\n```\n输入：\n1,2,3,0,0,0\n3\n2,5,6\n3\n输出：\n1 2 2 3 5 6\n解释：需要合并 [1,2,3] 和 [2,5,6] 。\n合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。\n```\n\n**示例 2：**\n\n```\n输入：\n1\n1\n\n0\n输出：\n1\n解释：需要合并 [1] 和 [] 。\n合并结果是 [1] 。\n```\n\n**示例 3：**\n\n```\n输入：\n0\n0\n1\n1\n输出：\n1\n解释：需要合并的数组是 [] 和 [1] 。\n合并结果是 [1] 。\n注意，因为 m = 0 ，所以 nums1 中没有元素。nums1 中仅存的 0 仅仅是为了确保合并结果可以顺利存放到 nums1 中。\n```\n\n \n\n**提示：**\n\n- `nums1.length == m + n`\n- `nums2.length == n`\n- `0 <= m, n <= 200`\n- `1 <= m + n <= 200`\n- `-109 <= nums1[i], nums2[j] <= 109`\n\n \n\n**进阶：**你可以设计实现一个时间复杂度为 `O(m + n)` 的算法解决此问题吗？','[\"数组\",\"双指针\",\"排序\"]','#### 方法一：直接合并后排序\n\n##### 算法\n\n最直观的方法是先将数组 $nums_2$ 放进数组 $nums_1$ 的尾部，然后直接对整个数组进行排序。\n\n```Java\nclass Solution {\n    public void merge(int[] nums1, int m, int[] nums2, int n) {\n        for (int i = 0; i != n; ++i) {\n            nums1[m + i] = nums2[i];\n        }\n        Arrays.sort(nums1);\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O((m+n)log⁡(m+n))$。 排序序列长度为 $m+n$，套用快速排序的时间复杂度即可，平均情况为 $O((m+n)log⁡(m+n))$。\n\n- 空间复杂度：$O(log⁡(m+n))$。 排序序列长度为 $m+n$，套用快速排序的空间复杂度即可，平均情况为 $O(log⁡(m+n))$。\n\n#### 方法二：双指针\n\n##### 算法\n\n方法一没有利用数组 $nums_1$ 与 $nums_2$ 已经被排序的性质。为了利用这一性质，我们可以使用双指针方法。这一方法将两个数组看作队列，每次从两个数组头部取出比较小的数字放到结果中。\n\n我们为两个数组分别设置一个指针 $p_1$ 与 $p_2$ 来作为队列的头部指针。代码实现如下：\n\n```Java\nclass Solution {\n    public void merge(int[] nums1, int m, int[] nums2, int n) {\n        int p1 = 0, p2 = 0;\n        int[] sorted = new int[m + n];\n        int cur;\n        while (p1 < m || p2 < n) {\n            if (p1 == m) {\n                cur = nums2[p2++];\n            } else if (p2 == n) {\n                cur = nums1[p1++];\n            } else if (nums1[p1] < nums2[p2]) {\n                cur = nums1[p1++];\n            } else {\n                cur = nums2[p2++];\n            }\n            sorted[p1 + p2 - 1] = cur;\n        }\n        for (int i = 0; i != m + n; ++i) {\n            nums1[i] = sorted[i];\n        }\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O(m+n)$。 指针移动单调递增，最多移动 $m+n$ 次，因此时间复杂度为 $O(m+n)$。\n- 空间复杂度：$O(m+n)$。 需要建立长度为 $m+n$ 的中间数组 $sorted$。',2,0,'[{\"input\":\"1,2,3,0,0,0\\n3\\n2,5,6\\n3\",\"output\":\"1 2 2 3 5 6\"},{\"input\":\"1\\n1\\n\\n0\",\"output\":\"1\"},{\"input\":\"0\\n0\\n1\\n1\",\"output\":\"1\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-01 21:49:39','2024-08-21 17:10:11',0),(7,'移除元素','给你一个数组 `nums` 和一个值 `val`，你需要 **[原地](https://baike.baidu.com/item/原地算法)** 移除所有数值等于 `val` 的元素，并返回移除后数组的新长度。\n\n不要使用额外的数组空间，你必须仅使用 `O(1)` 额外空间并 **[原地 ](https://baike.baidu.com/item/原地算法)修改输入数组**。\n\n元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。\n\n \n\n**说明:**\n\n为什么返回数值是整数，但输出的答案是数组呢?\n\n请注意，输入数组是以**「引用」**方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。\n\n你可以想象内部操作如下:\n\n```\n// nums 是以“引用”方式传递的。也就是说，不对实参作任何拷贝\nint len = removeElement(nums, val);\n\n// 在函数里修改输入数组对于调用者是可见的。\n// 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。\nfor (int i = 0; i < len; i++) {\n    print(nums[i]);\n}\n```\n\n \n\n**示例 1：**\n\n```\n输入：\n3,2,2,3\n3\n输出：\n2\n2,2\n解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而 nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。\n```\n\n**示例 2：**\n\n```\n输入：\n0,1,2,2,3,0,4,2\n2\n输出：\n5\n0,1,4,0,3\n解释：函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。注意这五个元素可为任意顺序。你不需要考虑数组中超出新长度后面的元素。\n```\n\n \n\n**提示：**\n\n- `0 <= nums.length <= 100`\n- `0 <= nums[i] <= 50`\n- `0 <= val <= 100`','[\"数组\",\"双指针\"]','#### 方法一：双指针\n\n##### 思路及算法\n\n由于题目要求删除数组中等于 $val$ 的元素，因此输出数组的长度一定小于等于输入数组的长度，我们可以把输出的数组直接写在输入数组上。可以使用双指针：右指针 $right$ 指向当前将要处理的元素，左指针 $left$ 指向下一个将要赋值的位置。\n\n如果右指针指向的元素不等于 $val$，它一定是输出数组的一个元素，我们就将右指针指向的元素复制到左指针位置，然后将左右指针同时右移；\n\n如果右指针指向的元素等于 $val$，它不能在输出数组里，此时左指针不动，右指针右移一位。\n\n整个过程保持不变的性质是：区间 $[0,left)$ 中的元素都不等于 $val$。当左右指针遍历完输入数组以后，$left$ 的值就是输出数组的长度。\n\n这样的算法在最坏情况下（输入数组中没有元素等于 $val$ ），左右指针各遍历了数组一次。\n\n##### 代码\n\n```Java\nclass Solution {\n    public int removeElement(int[] nums, int val) {\n        int n = nums.length;\n        int left = 0;\n        for (int right = 0; right < n; right++) {\n            if (nums[right] != val) {\n                nums[left] = nums[right];\n                left++;\n            }\n        }\n        return left;\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O(n)$，其中 $n$ 为序列的长度。我们只需要遍历该序列至多两次。\n- 空间复杂度：$O(1)$ 。我们只需要常数的空间保存若干变量。\n\n#### 方法二：双指针优化\n\n##### 思路\n\n如果要移除的元素恰好在数组的开头，例如序列 $[1,2,3,4,5]$ ，当 $val$ 为 $1$ 时，我们需要把每一个元素都左移一位。注意到题目中说：「元素的顺序可以改变」。实际上我们可以直接将最后一个元素 $5$ 移动到序列开头，取代元素 $1$，得到序列 $[5,2,3,4]$，同样满足题目要求。这个优化在序列中 $val$ 元素的数量较少时非常有效。\n\n实现方面，我们依然使用双指针，两个指针初始时分别位于数组的首尾，向中间移动遍历该序列。\n\n##### 算法\n\n如果左指针 $left$ 指向的元素等于 $val$，此时将右指针 $right$ 指向的元素复制到左指针 $left$ 的位置，然后右指针 $right$ 左移一位。如果赋值过来的元素恰好也等于 $val$，可以继续把右指针 $right$ 指向的元素的值赋值过来（左指针 $left$ 指向的等于 $val$ 的元素的位置继续被覆盖），直到左指针指向的元素的值不等于 $val$ 为止。\n\n当左指针 $left$ 和右指针 $right$ 重合的时候，左右指针遍历完数组中所有的元素。\n\n这样的方法两个指针在最坏的情况下合起来只遍历了数组一次。与方法一不同的是，方法二避免了需要保留的元素的重复赋值操作。\n\n##### 代码\n\n```Java\nclass Solution {\n    public int removeElement(int[] nums, int val) {\n        int left = 0;\n        int right = nums.length;\n        while (left < right) {\n            if (nums[left] == val) {\n                nums[left] = nums[right - 1];\n                right--;\n            } else {\n                left++;\n            }\n        }\n        return left;\n    }\n}\n```\n\n##### 复杂度分析\n\n- 时间复杂度：$O(n)$，其中 $n$ 为序列的长度。我们只需要遍历该序列至多一次。\n- 空间复杂度：$O(1)$。我们只需要常数的空间保存若干变量。',0,0,'[{\"input\":\"3,2,2,3\\n3\",\"output\":\"2\\n2,2\"},{\"input\":\"0,1,2,2,3,0,4,2\\n2\",\"output\":\"5\\n0,1,4,0,3\"}]','{\"memoryLimit\":128,\"stackLimit\":128,\"timeLimit\":1000}',0,0,2,'2023-09-02 14:32:14','2024-08-21 17:10:07',0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_submit`
--

DROP TABLE IF EXISTS `question_submit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_submit` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `submitLanguage` varchar(128) NOT NULL COMMENT '编程语言',
  `submitCode` text NOT NULL COMMENT '用户代码',
  `judgeInfo` text COMMENT '判题信息（json 对象）',
  `submitState` int NOT NULL DEFAULT '0' COMMENT '判题状态（0 - 待判题、1 - 判题中、2 - 成功、3 - 失败）',
  `questionId` bigint NOT NULL COMMENT '题目 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_questionId` (`questionId`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='题目提交';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_submit`
--

LOCK TABLES `question_submit` WRITE;
/*!40000 ALTER TABLE `question_submit` DISABLE KEYS */;
INSERT INTO `question_submit` (`id`, `submitLanguage`, `submitCode`, `judgeInfo`, `submitState`, `questionId`, `userId`, `createTime`, `updateTime`, `isDelete`) VALUES (1,'java','222','{}',0,1812342258664402945,1812110668646477826,'2024-07-14 14:54:08','2024-07-14 14:54:08',0),(2,'java','111111','{}',0,1812342258664402945,1812110668646477826,'2024-07-15 19:42:58','2024-07-15 19:42:58',0),(3,'java','111111','{\"message\":\"Accepted\",\"time\":100,\"memory\":100}',2,1812342258664402945,1812110668646477826,'2024-07-15 19:43:15','2024-07-17 22:50:17',0),(4,'java','3333','{}',0,1812342258664402945,1812110668646477826,'2024-07-15 19:43:20','2024-07-15 19:43:20',0),(5,'java','55555','{}',0,1812342258664402945,1812110668646477826,'2024-07-15 19:43:29','2024-07-15 19:43:29',0),(6,'java','666666','{\"message\":\"Accepted\",\"time\":100,\"memory\":100}',1,1812342258664402945,1812815459580280833,'2024-07-15 19:45:53','2024-07-17 22:43:19',0),(7,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',1,1812342258664402945,1812815459580280833,'2024-08-01 10:10:33','2024-08-01 10:10:43',0),(8,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',1,1812342258664402945,1812815459580280833,'2024-08-01 10:16:42','2024-08-01 10:18:38',0),(9,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',1,1812342258664402945,1812815459580280833,'2024-08-01 10:22:46','2024-08-01 10:22:46',0),(10,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',1,1812342258664402945,1812815459580280833,'2024-08-01 10:23:08','2024-08-01 10:23:08',0),(11,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":89,\"memory\":0}',2,1812342258664402945,1812815459580280833,'2024-08-01 10:28:11','2024-08-01 10:29:40',0),(12,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":75,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:31:56','2024-08-01 10:31:59',0),(13,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":114,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:36:03','2024-08-01 10:36:15',0),(14,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":139,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:36:46','2024-08-01 10:36:48',0),(15,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":123,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:36:54','2024-08-01 10:36:55',0),(16,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Wrong Answer\",\"time\":495,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:40:53','2024-08-01 10:40:58',0),(17,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":292,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 10:50:34','2024-08-01 10:50:41',0),(18,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',1,1812343707871932417,1812815459580280833,'2024-08-01 11:28:16','2024-08-01 11:28:16',0),(19,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":315,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 11:32:47','2024-08-01 11:33:01',0),(20,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":208,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 11:56:55','2024-08-01 11:57:09',0),(21,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{\"message\":\"Accepted\",\"time\":230,\"memory\":0}',2,1812343707871932417,1812815459580280833,'2024-08-01 12:00:57','2024-08-01 12:01:15',0),(22,'c++','ff','{}',0,1812342258664402945,1812110668646477826,'2024-08-05 21:03:17','2024-08-05 21:03:17',0),(23,'java','111','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:15:19','2024-08-07 11:15:19',0),(24,'java','111','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:17:55','2024-08-07 11:17:55',0),(25,'java','111','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:20:39','2024-08-07 11:20:39',0),(26,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:30:03','2024-08-07 11:30:03',0),(27,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:33:26','2024-08-07 11:33:26',0),(28,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:39:53','2024-08-07 11:39:53',0),(29,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:43:25','2024-08-07 11:43:25',0),(30,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:49:36','2024-08-07 11:49:36',0),(31,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:51:59','2024-08-07 11:51:59',0),(32,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 11:52:36','2024-08-07 11:52:36',0),(33,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',0,1812342258664402945,1812815459580280833,'2024-08-07 12:05:17','2024-08-07 12:05:17',0),(34,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{}',1,1812342258664402945,1812815459580280833,'2024-08-07 12:08:02','2024-08-07 12:08:03',0),(35,'java','public class Main {\n    public static void main(String[] args) {\n        Integer a = Integer.parseInt(args[0]);\n        Integer b = Integer.parseInt(args[1]);\n        System.out.println((a + b));\n    }\n}\n','{\"message\":\"Accepted\",\"time\":85,\"memory\":0}',2,1812342258664402945,1812815459580280833,'2024-08-07 12:11:06','2024-08-07 12:11:08',0),(36,'java','public class Main {\n    public static void main(String[] args) {\n        int a = Integer.parseInt(args[0]);\n        int b = Integer.parseInt(args[1]);\n        System.out.println(a + b);\n    }\n}\n','{\"message\":\"Accepted\",\"time\":83,\"memory\":0}',2,1812343707871932417,1821084806038003714,'2024-08-12 10:26:04','2024-08-12 10:26:06',0),(37,'java','public class Main {\n    public static void main(String[] args) {\n        int a = Integer.parseInt(args[0]);\n        int b = Integer.parseInt(args[1]);\n        System.out.println(a + b);\n    }\n}\n','{\"message\":\"Accepted\",\"time\":74,\"memory\":0}',2,1812343707871932417,1821084806038003714,'2024-08-12 18:07:30','2024-08-12 18:07:31',0),(38,'java','public class Main {\n    public static void main(String[] args) {\n        int a = Integer.parseInt(args[0]);\n        int b = Integer.parseInt(args[1]);\n        System.out.println(a + b);\n    }\n}\n','{\"message\":\"Accepted\",\"time\":82,\"memory\":0}',2,1812343707871932417,1812110668646477826,'2024-08-21 11:48:04','2024-08-21 11:55:35',0),(39,'java','public class Main {\n    public static void main(String[] args) {\n        int a = Integer.parseInt(args[0]);\n        int b = Integer.parseInt(args[1]);\n        System.out.println(a + b);\n    }\n}\n','{\"message\":\"Accepted\",\"time\":85,\"memory\":0}',2,1812343707871932417,1812110668646477826,'2024-08-21 11:56:12','2024-08-21 11:56:24',0);
/*!40000 ALTER TABLE `question_submit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userAccount` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `userPassword` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `unionId` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信开放平台id',
  `mpOpenId` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号openId',
  `userName` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `userAvatar` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户简介',
  `userRole` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_unionId` (`unionId`)
) ENGINE=InnoDB AUTO_INCREMENT=1821084806038003715 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `userAccount`, `userPassword`, `unionId`, `mpOpenId`, `userName`, `userAvatar`, `userProfile`, `userRole`, `createTime`, `updateTime`, `isDelete`) VALUES (1812110668646477826,'admin','d96e22dec970439509107904988f0ed9',NULL,NULL,NULL,'https://dy-oj.oss-cn-beijing.aliyuncs.com/2024-08-12/06.png',NULL,'admin','2024-07-13 21:03:45','2024-08-12 12:55:39',0),(1812815459580280833,'dycoding','d96e22dec970439509107904988f0ed9',NULL,NULL,NULL,'https://dy-oj.oss-cn-beijing.aliyuncs.com/2024-08-12/08.jpg',NULL,'user','2024-07-15 19:44:20','2024-08-12 12:56:25',0),(1821084806038003714,'dycoding111','d96e22dec970439509107904988f0ed9',NULL,NULL,'123','https://dy-oj.oss-cn-beijing.aliyuncs.com/2024-08-12/11.jpg',NULL,'admin','2024-08-07 15:23:46','2024-08-12 12:55:05',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-22  8:27:31
