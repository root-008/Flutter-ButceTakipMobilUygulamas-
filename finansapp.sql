-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 04 Haz 2023, 22:07:00
-- Sunucu sürümü: 10.4.28-MariaDB
-- PHP Sürümü: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `finansapp`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `bankTransactionHistory` (IN `user_id` INT)   BEGIN
    SELECT users.username, butce_planlama_categories.Category_name, butce_planlama_subcategories.subcategory_name, butce_planlama_dates.creation_time, butce_planlama_tutar.amount 
    FROM butce_planlama_tutar
    JOIN users ON users.user_id = butce_planlama_tutar.user_id
    JOIN butce_planlama_subcategories ON butce_planlama_subcategories.id = butce_planlama_tutar.subcategory_id
    JOIN butce_planlama_categories ON butce_planlama_categories.id = butce_planlama_subcategories.category_id
    JOIN butce_planlama_dates ON butce_planlama_dates.id = butce_planlama_tutar.time_id
    WHERE butce_planlama_tutar.user_id = user_id
    ORDER BY butce_planlama_dates.creation_time DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAmount` (IN `categoryId` INT, IN `user_id` INT, IN `startDate` DATE, IN `endDate` DATE)   BEGIN
    SELECT t.id, s.subcategory_name, t.amount, d.creation_time, d.update_time
    FROM butce_planlama_tutar AS t
    INNER JOIN butce_planlama_subcategories AS s ON t.subcategory_id = s.id
    INNER JOIN butce_planlama_categories AS c ON s.category_id = c.id
    INNER JOIN butce_planlama_dates AS d ON t.time_id = d.id
    WHERE c.id = categoryId 
    AND t.user_id = user_id 
    AND d.creation_time >= startDate 
    AND d.creation_time <= endDate;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getExpenseQuery` (IN `user_id` INT)   BEGIN
    SELECT
        COALESCE(SUM(t.amount), 0) AS this_month_expenses,
        COALESCE((SELECT SUM(t2.amount)
                FROM butce_planlama_tutar AS t2
                INNER JOIN butce_planlama_dates AS d2 ON t2.time_id = d2.id
                WHERE t2.user_id = user_id
                    AND MONTH(d2.creation_time) = MONTH(CURRENT_DATE) - 1
                    AND YEAR(d2.creation_time) = YEAR(CURRENT_DATE)), 0) AS previous_month_expenses
    FROM butce_planlama_tutar AS t
    INNER JOIN butce_planlama_dates AS d ON t.time_id = d.id
    WHERE MONTH(d.creation_time) = MONTH(CURRENT_DATE)
        AND YEAR(d.creation_time) = YEAR(CURRENT_DATE)
        AND t.user_id = user_id
        AND t.subcategory_id NOT IN (SELECT id FROM butce_planlama_subcategories WHERE category_id = 1) 
    GROUP BY t.user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastUpdatedData` (IN `user_id` INT)   BEGIN
    SELECT c.Category_name, sc.subcategory_name, t.amount
    FROM butce_planlama_tutar AS t
    JOIN butce_planlama_subcategories AS sc ON t.subcategory_id = sc.id
    JOIN butce_planlama_categories AS c ON sc.category_id = c.id
    JOIN butce_planlama_dates AS d ON t.time_id = d.id
    WHERE t.user_id = user_id
    ORDER BY d.update_time DESC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMaxExpense` (IN `user_id` INT)   BEGIN
    SELECT bpc.Category_name, bps.subcategory_name, bpt.amount
    FROM butce_planlama_tutar AS bpt
    JOIN butce_planlama_subcategories AS bps ON bpt.subcategory_id = bps.id
    JOIN butce_planlama_categories AS bpc ON bps.category_id = bpc.id
    JOIN butce_planlama_dates AS bpd ON bpt.time_id = bpd.id
    WHERE MONTH(bpd.creation_time) = MONTH(CURRENT_DATE) - 1
        AND bpc.Category_name != 'Gelir'
        AND bpt.user_id = user_id
    ORDER BY bpt.amount DESC
    LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMinAmountForCategory` (IN `user_id` INT)   BEGIN
    SELECT bc.Category_name, bsc.subcategory_name, MIN(bt.amount) AS min_amount
    FROM butce_planlama_tutar AS bt
    JOIN butce_planlama_subcategories AS bsc ON bt.subcategory_id = bsc.id
    JOIN butce_planlama_categories AS bc ON bsc.category_id = bc.id
    JOIN butce_planlama_dates AS bd ON bt.time_id = bd.id
    WHERE bt.user_id = user_id
        AND bc.Category_name != 'Gelir'
        AND MONTH(bd.creation_time) = MONTH(CURDATE())
        AND YEAR(bd.creation_time) = YEAR(CURDATE())
    GROUP BY bc.Category_name, bsc.subcategory_name
    ORDER BY min_amount ASC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMostRepeatedCategory` (IN `user_id` INT)   BEGIN
    SELECT bpc.Category_name, COUNT(*) AS repetition_count
    FROM butce_planlama_tutar bpt
    JOIN butce_planlama_subcategories bps ON bpt.subcategory_id = bps.id
    JOIN butce_planlama_categories bpc ON bps.category_id = bpc.id
    JOIN butce_planlama_dates bpd ON bpt.time_id = bpd.id
    WHERE bpt.user_id = user_id
        AND bpc.Category_name != 'Gelir'
        AND MONTH(bpd.creation_time) = MONTH(CURDATE())
        AND YEAR(bpd.creation_time) = YEAR(CURDATE())
    GROUP BY bpc.Category_name
    ORDER BY repetition_count DESC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTotalAmount` (IN `user_id` INT)   BEGIN
    SELECT 
        (SELECT SUM(amount) 
            FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON 
                t.subcategory_id = s.id WHERE s.category_id = 1 AND t.user_id = user_id) AS gelirler,
        (SELECT SUM(amount) 
            FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON 
                t.subcategory_id = s.id JOIN butce_planlama_categories c ON s.category_id = c.id WHERE c.id != 1 AND t.user_id = user_id) AS giderler,
        ((SELECT SUM(amount) FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON
             t.subcategory_id = s.id WHERE s.category_id = 1 AND t.user_id = user_id) - (SELECT SUM(amount) FROM butce_planlama_tutar t 
                JOIN butce_planlama_subcategories s ON t.subcategory_id = s.id JOIN butce_planlama_categories c ON 
                    s.category_id = c.id WHERE c.id != 1 AND t.user_id = user_id)) AS net_gelir
    FROM dual;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalExpenses` (IN `user_id` INT)   BEGIN
    SELECT c.Category_name, SUM(t.amount) AS total_expense
    FROM users u
    JOIN butce_planlama_subcategories sc ON u.user_id = sc.user_id
    JOIN butce_planlama_tutar t ON sc.id = t.subcategory_id
    JOIN butce_planlama_categories c ON sc.category_id = c.id
    WHERE u.user_id = user_id AND c.Category_name != 'Gelir'
    GROUP BY c.id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `butce_planlama_categories`
--

CREATE TABLE `butce_planlama_categories` (
  `id` int(11) NOT NULL,
  `Category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `butce_planlama_categories`
--

INSERT INTO `butce_planlama_categories` (`id`, `Category_name`) VALUES
(1, 'Gelir'),
(2, 'Gıda'),
(3, 'Konut'),
(4, 'Ulaşım'),
(5, 'Sağlık'),
(6, 'Eğitim'),
(7, 'Eğlence'),
(8, 'Diğer');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `butce_planlama_dates`
--

CREATE TABLE `butce_planlama_dates` (
  `id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `update_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `butce_planlama_dates`
--

INSERT INTO `butce_planlama_dates` (`id`, `creation_time`, `update_time`) VALUES
(1, '2023-05-11 01:24:06', '2023-05-15 20:50:18'),
(2, '2023-05-11 01:24:06', '2023-05-11 01:24:06'),
(46, '2023-05-15 21:34:46', '2023-05-29 17:58:54'),
(48, '2023-05-15 21:35:57', '2023-05-15 21:35:57'),
(49, '2023-05-15 21:49:42', '2023-05-15 21:49:42'),
(50, '2023-05-15 21:50:00', '2023-05-15 21:50:16'),
(51, '2023-05-15 21:55:13', '2023-05-15 21:55:13'),
(54, '2023-05-15 21:59:52', '2023-05-15 21:59:52'),
(56, '2023-05-15 22:03:48', '2023-05-15 22:03:53'),
(57, '2023-05-15 22:07:23', '2023-05-15 22:07:33'),
(58, '2023-05-15 22:10:54', '2023-05-15 22:10:54'),
(59, '2023-05-15 22:12:35', '2023-05-28 16:12:18'),
(60, '2023-05-18 03:06:45', '2023-06-04 01:24:19'),
(63, '2023-05-28 16:05:04', '2023-05-28 16:05:04'),
(64, '2023-05-28 16:21:58', '2023-06-04 01:21:05'),
(65, '2023-05-28 16:27:22', '2023-06-04 01:21:24'),
(66, '2023-06-02 23:21:14', '2023-06-03 22:48:11'),
(67, '2023-06-02 23:24:58', '2023-06-04 15:47:46'),
(68, '2023-06-02 23:36:28', '2023-06-02 23:36:28'),
(69, '2023-06-04 01:43:15', '2023-06-04 01:43:15'),
(83, '2023-06-04 18:13:48', '2023-06-04 18:13:48'),
(84, '2023-06-04 18:13:50', '2023-06-04 18:13:50'),
(85, '2023-06-04 18:13:58', '2023-06-04 18:13:58'),
(86, '2023-06-04 18:14:14', '2023-06-04 18:14:14'),
(87, '2023-06-04 18:15:35', '2023-06-04 18:15:35'),
(92, '2023-06-04 18:45:16', '2023-06-04 22:46:36'),
(93, '2023-06-04 21:41:34', '2023-06-04 21:41:34'),
(94, '2023-06-04 22:19:22', '2023-06-04 22:19:22'),
(95, '2023-06-04 22:47:43', '2023-06-04 22:47:43');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `butce_planlama_subcategories`
--

CREATE TABLE `butce_planlama_subcategories` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `butce_planlama_subcategories`
--

INSERT INTO `butce_planlama_subcategories` (`id`, `user_id`, `category_id`, `subcategory_name`) VALUES
(4, 2, 1, 'Maaş'),
(6, 2, 1, 'Kira'),
(10, 3, 1, 'Maas'),
(14, 1, 1, 'Faiz'),
(36, 1, 2, 'Kasap'),
(41, 1, 1, 'Maas'),
(51, 3, 1, 'dfsd'),
(52, 3, 2, 'Market'),
(53, 3, 3, 'Toki'),
(54, 3, 3, 'Ankara'),
(55, 3, 4, 'ulasim1'),
(58, 3, 5, 'saglik1'),
(59, 3, 6, 'egitim1'),
(60, 3, 7, 'eglence1'),
(61, 3, 8, 'diger'),
(62, 1, 8, 'can_diger'),
(63, 1, 4, 'Dolmus'),
(64, 1, 1, 'yeni'),
(66, 1, 8, 'yu'),
(67, 1, 6, 'kitap '),
(68, 1, 5, 'ilaç '),
(69, 1, 3, 'kira'),
(70, 3, 2, 'Pazar'),
(72, 1, 2, 'gida1'),
(73, 1, 2, 'gida2'),
(74, 1, 2, 'gida3'),
(75, 1, 7, 'Kumar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `butce_planlama_tutar`
--

CREATE TABLE `butce_planlama_tutar` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `time_id` int(11) DEFAULT NULL,
  `amount` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `butce_planlama_tutar`
--

INSERT INTO `butce_planlama_tutar` (`id`, `user_id`, `subcategory_id`, `time_id`, `amount`) VALUES
(5, 2, 4, 1, 767),
(7, 2, 6, 2, 585),
(76, 3, 10, 46, 6012),
(78, 3, 52, 48, 23),
(79, 3, 53, 49, 5000),
(80, 3, 54, 50, 225),
(81, 3, 55, 51, 1),
(84, 3, 58, 54, 1),
(86, 3, 59, 56, 11),
(87, 3, 60, 57, 5),
(88, 3, 61, 58, 12),
(89, 1, 62, 59, 10000),
(90, 1, 63, 60, 500),
(93, 1, 66, 63, 25),
(94, 1, 67, 64, 1001),
(95, 1, 68, 65, 2083),
(96, 1, 41, 66, 5000),
(97, 1, 36, 67, 5950),
(98, 1, 69, 68, 5024),
(99, 3, 70, 69, 521),
(122, 1, 14, 92, 22500),
(123, 1, 64, 93, 5),
(124, 1, 72, 94, 5),
(125, 1, 75, 95, 5000);

--
-- Tetikleyiciler `butce_planlama_tutar`
--
DELIMITER $$
CREATE TRIGGER `delete_date_after_delete_tutar` AFTER DELETE ON `butce_planlama_tutar` FOR EACH ROW BEGIN
        DELETE FROM butce_planlama_dates WHERE id = OLD.time_id;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`) VALUES
(1, 'can', '$2y$10$Uz0IDrGoWf3pKA0ORd91e.H6DBH/4HYxEyvUWtbu0kL.3bYEa9U7y'),
(2, 'ahmet', '$2y$10$Uz0IDrGoWf3pKA0ORd91e.H6DBH/4HYxEyvUWtbu0kL.3bYEa9U7y'),
(3, 'deneme', '$2y$10$Uz0IDrGoWf3pKA0ORd91e.H6DBH/4HYxEyvUWtbu0kL.3bYEa9U7y'),
(4, 'Ahmet45', '$2y$10$Uz0IDrGoWf3pKA0ORd91e.H6DBH/4HYxEyvUWtbu0kL.3bYEa9U7y');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `butce_planlama_categories`
--
ALTER TABLE `butce_planlama_categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `butce_planlama_dates`
--
ALTER TABLE `butce_planlama_dates`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `butce_planlama_subcategories`
--
ALTER TABLE `butce_planlama_subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_categories` (`category_id`),
  ADD KEY `fk_usres` (`user_id`);

--
-- Tablo için indeksler `butce_planlama_tutar`
--
ALTER TABLE `butce_planlama_tutar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_amount` (`subcategory_id`),
  ADD KEY `fk_users` (`user_id`),
  ADD KEY `fk_times` (`time_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `butce_planlama_categories`
--
ALTER TABLE `butce_planlama_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `butce_planlama_dates`
--
ALTER TABLE `butce_planlama_dates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- Tablo için AUTO_INCREMENT değeri `butce_planlama_subcategories`
--
ALTER TABLE `butce_planlama_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- Tablo için AUTO_INCREMENT değeri `butce_planlama_tutar`
--
ALTER TABLE `butce_planlama_tutar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `butce_planlama_subcategories`
--
ALTER TABLE `butce_planlama_subcategories`
  ADD CONSTRAINT `fk_categories` FOREIGN KEY (`category_id`) REFERENCES `butce_planlama_categories` (`id`),
  ADD CONSTRAINT `fk_usres` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Tablo kısıtlamaları `butce_planlama_tutar`
--
ALTER TABLE `butce_planlama_tutar`
  ADD CONSTRAINT `fk_amount` FOREIGN KEY (`subcategory_id`) REFERENCES `butce_planlama_subcategories` (`id`),
  ADD CONSTRAINT `fk_times` FOREIGN KEY (`time_id`) REFERENCES `butce_planlama_dates` (`id`),
  ADD CONSTRAINT `fk_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
