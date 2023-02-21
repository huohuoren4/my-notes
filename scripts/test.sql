SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `test`
--

-- --------------------------------------------------------

--
-- 表的结构 `blog_group`
--

CREATE TABLE `blog_group` (
`id` int(11) NOT NULL,
`group_name` varchar(20) NOT NULL DEFAULT '小学组'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组';

--
-- 转存表中的数据 `blog_group`
--

INSERT INTO `blog_group` (`id`, `group_name`) VALUES
(2, '中学组'),
(3, '大学组'),
(1, '小学组');

-- --------------------------------------------------------

--
-- 表的结构 `blog_user`
--

CREATE TABLE `blog_user` (
`id` int(11) NOT NULL,
`username` varchar(50) NOT NULL,
`age` tinyint(3) NOT NULL DEFAULT '20',
`price` decimal(5,2) NOT NULL,
`description` varchar(255) NOT NULL,
`group_id` varchar(20) NOT NULL COMMENT '组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 转存表中的数据 `blog_user`
--

INSERT INTO `blog_user` (`id`, `username`, `age`, `price`, `description`, `group_id`) VALUES
(1, '小唐', 0, '12.30', '广东省深圳市松白路', '1'),
(8, '小明', 13, '30.00', '美国洛杉矶', '1'),
(9, '小章', 70, '89.00', '英国伦敦', '3'),
(10, '王小名', 40, '45.00', '法国巴黎', '2'),
(11, '艾伦', 1, '14.00', '古巴比伦', '2'),
(12, '李冰', 36, '45.63', '中国上海', '1');

--
-- 转储表的索引
--

--
-- 表的索引 `blog_group`
--
ALTER TABLE `blog_group`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `group_name` (`group_name`);

--
-- 表的索引 `blog_user`
--
ALTER TABLE `blog_user`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `username` (`username`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `blog_group`
--
ALTER TABLE `blog_group`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `blog_user`
--
ALTER TABLE `blog_user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;