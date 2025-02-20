-- V1: Initial schema

CREATE TABLE user_details
(
    id          SERIAL PRIMARY KEY,
    phone       VARCHAR(20),
    address     TEXT,
    description TEXT
);

INSERT INTO user_details (id, phone, address, description) VALUES (1, '+380 09 029-63-28', 'вулиця Пересипська 2-га, буд. 980, Дубно, 19832', 'Вечір плід написати. Який польовий порада ковзати знімати. Вказаний спасти дрібниця спорт порт господь даль кордон. Район ковзати кільце адвокат інтернет відділ міф.');
INSERT INTO user_details (id, phone, address, description) VALUES (2, '+380 58 221 95 06', 'шосе Андрія Сови, буд. 196, Слов''янськ, 87722', 'Блін бак збудження. Болісно настати ідея житель заспокоїтися підземний розкішний.');
INSERT INTO user_details (id, phone, address, description) VALUES (3, '+380 75 677 78 19', 'парк Заводська 3-тя, буд. 65 кв. 008, Харків, 21470', 'Чотири команда дорогий шкіра зима банда труп. Відділ написати заспокоїтися тривога. Монета наступати прихований даль новий.');

SELECT setval('user_details_id_seq', COALESCE((SELECT MAX(id) FROM user_details), 1) + 1, false);

CREATE TABLE users
(
    id              SERIAL PRIMARY KEY,
    login           VARCHAR(100) UNIQUE NOT NULL,
    first_name      VARCHAR(100)        NOT NULL,
    last_name       VARCHAR(100)        NOT NULL,
    role            VARCHAR(20)  NOT NULL CHECK (role IN ('ADMIN', 'VOLUNTEER', 'SOLDIER')),
    user_details_id INT UNIQUE          REFERENCES user_details (id) ON DELETE SET NULL,
    created_ts      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_ts      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (id, login, first_name, last_name, role, user_details_id, created_ts, updated_ts) VALUES (1, 'admin', 'Панас', 'Юрченко', 'ADMIN', 1, '2025-01-08 00:50:30', '2025-01-30 11:31:39');
INSERT INTO users (id, login, first_name, last_name, role, user_details_id, created_ts, updated_ts) VALUES (2, 'volunteer', 'Богодар', 'Цибуленко', 'VOLUNTEER', 2, '2025-02-03 09:06:17', '2025-02-06 20:59:14');
INSERT INTO users (id, login, first_name, last_name, role, user_details_id, created_ts, updated_ts) VALUES (3, 'soldier', 'Софія', 'Охримович', 'SOLDIER', 3, '2025-02-05 00:32:40', '2025-02-16 17:21:22');

SELECT setval('users_id_seq', COALESCE((SELECT MAX(id) FROM users), 1) + 1, false);

CREATE TABLE category
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

INSERT INTO category (id, name, description) VALUES (1, 'Одяг', 'О́дяг, оде́жа — сукупність рукотворних предметів та виробів, якими покривають тіло. Найчастіше одяг буває тканинний, синтетичний та вовняний.');
INSERT INTO category (id, name, description) VALUES (2, 'Взуття', 'Взуття́ — виріб, створений для захисту ніг. Застосовується насамперед для теплового і механічного захисту ніг.');
INSERT INTO category (id, name, description) VALUES (3, 'Електроніка', 'Електро́ніка (від грец. Ηλεκτρόνιο — електрон) — наука про взаємодію електронів з електромагнітними полями і про методи створення електронних приладів.');

SELECT setval('category_id_seq', COALESCE((SELECT MAX(id) FROM category), 1) + 1, false);

CREATE TABLE user_to_category
(
    user_id     INT REFERENCES users (id) ON DELETE CASCADE,
    category_id INT REFERENCES category (id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, category_id)
);

INSERT INTO user_to_category (user_id, category_id) VALUES (2, 1);
INSERT INTO user_to_category (user_id, category_id) VALUES (2, 2);

CREATE TABLE request
(
    id          SERIAL PRIMARY KEY,
    user_id     INT          NOT NULL REFERENCES users (id) ON DELETE SET NULL,
    summary     VARCHAR(255) NOT NULL,
    description TEXT,
    status      VARCHAR(20)  NOT NULL CHECK (status IN ('DRAFT', 'OPEN', 'CLOSED', 'CANCELLED')),
    created_ts  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_ts  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (1, 3, 'Валюта сходити п''ятеро райком.', 'Правління плід господь затягнутися дихання. Розводити художній кора кут блін. Промовчати а терапія летіти. Співати чітко багряний мільярд викинути порода. Сміття важкий кпсс ковзати мить черевик мимо. Поставити правління заспівати почуття польовий.', 'DRAFT', '2025-01-12 06:58:09', '2025-02-02 23:09:37');
INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (2, 3, 'Триста о зате процес квапливий правління князь бігати.', 'Приходити здригатися провінція гіркий. Роса вітати господиня різноманітний звільнення ягода. Монета інфекція ніч жити супроводжуватися болісно. Свіжий пірʼя дальній насолода основа. Правління інтернет призначити інший вперед.', 'OPEN', '2025-01-17 04:55:26', '2025-01-24 14:49:59');
INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (3, 3, 'Диявол склянка основа передо.', 'Податковий щастя палиця новий похмуро вчений. Незвичний прірва сміливий м''який вивчити пристрасть ставити. Приходити порада залучати важкий провінція. Розлад виникнення витримати важливий робочий слати банк. Виникнення бочок ідея господь.', 'CANCELLED', '2025-02-03 15:31:56', '2025-02-11 21:57:24');
INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (4, 3, 'Податковий написати ніч прощення міра.', 'Низький простір ідея квапливий більше бажання. Грати багаття дрімати так валюта точно. Передо білизна дрібниця перед вечір камінчик.', 'OPEN', '2025-02-03 19:46:17', '2025-02-17 10:44:23');
INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (5, 3, 'Вітрина головка відзначити салон актриса слати.', 'Тисяча господь рот встати щастя пані. Лапа мотоцикл при дошлий тютюн мати тисяча. Податковий редактор господь дрімати чотири гроші кишеня.Несподіваний о плід самостійно спасти витягувати протягувати. Простір розкішний занадто що пропадати блискучий.', 'DRAFT', '2025-01-12 12:20:59', '2025-01-29 14:27:44');

SELECT setval('request_id_seq', COALESCE((SELECT MAX(id) FROM request), 1) + 1, false);

CREATE TABLE item
(
    id                SERIAL PRIMARY KEY,
    request_id        INT          NOT NULL REFERENCES request (id) ON DELETE CASCADE,
    category_id       INT          NOT NULL REFERENCES category (id) ON DELETE SET NULL,
    summary           VARCHAR(255) NOT NULL,
    description       TEXT,
    status            VARCHAR(20)  NOT NULL CHECK (status IN ('OPEN', 'IN_PROGRESS', 'CLOSED', 'CANCELLED')),
    closed_by_user_id INT          REFERENCES users (id) ON DELETE SET NULL,
    created_ts        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_ts        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (1, 1, 3, 'Ґудзик палиця товар.', 'Постійний колектив точно полюбити щастя прихований перетнути мʼята. Похмуро постійний шолом аж поставити. Похорон можливо вивести бригада викинути зміна потягнутися.', 'IN_PROGRESS', NULL, '2025-01-28 04:00:54', '2025-02-06 04:12:40');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (2, 2, 1, 'Черговий підкинути провал зелений вечір танцювати.', 'Палець слати синок. Склянка хлопець прохід підлога доба. Поріг покидати єврейський пастух болісно космос аж. Радість легко здригнутися ефект. Розуміти забирати колектив район тютюн сміятися процес. Летіти чотири гіркий що знищення упор решітка важливий. Хлопець радити провал провал реклама аналіз.', 'CLOSED', 2, '2025-02-07 00:19:10', '2025-02-15 21:56:45');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (3, 3, 1, 'Провал здригатися виблискувати синок промовчати.', 'Зупинити блискучий палиця легко інший більше перед палата. Досліджено олівець епоха природа художній простір інвалід сміття. Світило пристрасть в''язниця ліловий зате присісти поріг.', 'OPEN', NULL, '2025-02-15 10:10:38', '2025-02-15 12:15:52');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (4, 4, 2, 'Серйозний несподівано вивести адже.', 'Князь виблискувати чітко. Крутий надати відділ вмирати похорон. При сходити картинка плавно. Встати терапія демократія заробити чотири. Армійський вираз адже передо насолода приятель розстебнути.', 'IN_PROGRESS', NULL, '2025-02-10 09:31:09', '2025-02-11 12:28:53');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (5, 4, 3, 'Так зображати холодно аналіз район намір звільнити.', 'Неправда поставити вчений фахівець спорт новий художній. Інструкція несподіваний покидати диявол темніти ковзати інструкція. Вовк червень зарплата рішення. Тривога ніж конференція правління. Зелений гараж розгубитися вітрина поріг основа. Супроводжуватися розвинений ефект інший сонце зміна.', 'IN_PROGRESS', NULL, '2025-02-14 23:56:47', '2025-02-16 04:17:34');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (6, 5, 2, 'Степ викинути колектив їжа кордон.', 'Присісти казна-хто черевик купа-невеличка міра. Свіжий вказаний міф квапливий. Червонй грати кидати мільярд самостійно співрозмовник. Розуміти прохід тютюн підкинути художній боєць збудження знаходити.', 'IN_PROGRESS', NULL, '2025-01-10 09:07:31', '2025-01-31 08:38:29');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (7, 4, 3, 'Кордон зміна інвалід.', 'Почуття демократія витримати прошепотіти. М''Який вітрина дорогий щастя білизна знищення розлад. Ліхтарик плід болісно засунути. Свіжий яблуко основа вітрина.', 'CLOSED', 2, '2025-01-15 13:46:51', '2025-02-03 03:18:40');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (8, 3, 3, 'Перетнути простір заборонити.', 'Вітати вчора видимо покидати податковий фахівець. Правління розкішний перед штаб рідкий білизна чітко. Єврейський природа танцювати виражений оборот реклама навряд головний. Нестерпний вираз редактор постійний нога пастух медицина. Співати господь повністю адже кордон художній хлопчисько.', 'CLOSED', 2, '2025-01-02 20:43:08', '2025-02-15 22:47:31');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (9, 2, 2, 'Багаття радити єдиний звільнення заява.', 'Точно витримати поїзд болото перебивати вечір. Порода насолода прихований інший щось деякий передо. Розкішний незвичайний мить квапливий вітрина.', 'CLOSED', 2, '2025-02-10 05:34:59', '2025-02-12 07:27:55');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (10, 1, 1, 'Порада червʼяк уникати мимо.', 'Банк кпсс монета. Адже заява вибирати очко. Блискучий нині шолом виражений сміливий. Трубка перед плід вказаний летіти взагалі близько. Черговий так голубчик коричневий вивести робочий.', 'OPEN', NULL, '2025-01-12 22:22:01', '2025-02-06 23:28:54');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (11, 2, 1, 'Хата ґудзик помовчати порода протягувати трясти.', 'Спасти доба міркування супроводжуватися. Аналіз увійти загроза купа-невеличка в''язниця знаходити. Виднітися голубчик командування що військовий пробувати здалеку. Більше кут командування багряний. Вказаний самостійно хліб задерти.', 'IN_PROGRESS', NULL, '2025-01-27 16:58:23', '2025-02-08 07:17:11');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (12, 3, 3, 'Залучати мить покоління військовий програміст гіркий.', 'Гіркий поставити прелесть монета підземний. Відзначити зарплата направо. Нарада приходити виднітися дрімати що ягода. Прелесть правильний актриса метал від''їзд. Кидати поставити простір викинути так секунда обуритися.', 'CLOSED', 2, '2025-01-23 19:26:18', '2025-02-01 23:41:39');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (13, 4, 3, 'Намір ремінь степ колектив коричневий хліб здригатися.', 'Тута зловити кут помовчати дружно заплакати. П''Ятеро домогтися палець вчений. Несподіваний задерти простір олівець вмирати результат. Розкішний серйозний повністю домогтися прихований доба низький. Вовк зрозумілий знищення гіркий кпсс сміття.', 'OPEN', NULL, '2025-02-04 20:48:49', '2025-02-11 04:06:08');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (14, 5, 3, 'Шкільний суглоб білизна палець.', 'Хід коричневий гуляти близько байдужий купа-невеличка багряний. Олівець обуритися вибирати місце знищення різноманітний. Раніше багаття рота вчора упор. Монета суглоб радість слати струмок.', 'CANCELLED', NULL, '2025-02-15 22:37:07', '2025-02-16 18:47:47');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (15, 4, 2, 'Вітрина навіщо розгубитися мʼята падати мільярд розкішний.', 'Рот крутий залучати чоловічок лягати єврейський незвичайний. Витягувати степ чоловічок казна-хто. Вскакивать підлога приятель пристрасть даль основа відповісти. Паща полум''я порівняння польовий слати.', 'OPEN', NULL, '2025-01-21 00:58:51', '2025-02-08 05:21:53');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (16, 3, 2, 'Мимо блискучий пісня купа-невеличка прелесть.', 'ЧервʼЯк гіркий колектив наштовхнутися прірва податковий медицина. Вперед постійний можливо деякий безпорадний. Склянка супроводжуватися метелик. Виникнення космос дрібниця червʼяк кут благати.', 'IN_PROGRESS', NULL, '2025-01-09 20:34:37', '2025-02-14 05:56:42');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (17, 2, 3, 'Незвичайний тисяча тута приходити близько.', 'Синок райком нога плід. Прохід самостійно видимо розлад друкувати валюта. Раніше гіркий князь рідкий командир. Ефект блін білизна склянка інструкція. Домогтися соціалістичний призначити мить. Паща приятель хлопець приходити. Тута команда уточнити червень груди нестерпний.', 'OPEN', NULL, '2025-01-27 18:23:51', '2025-01-31 08:41:10');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (18, 1, 3, 'Ефект лягати болісно.', 'Хотіти купа багаття. Покинути місце червʼяк безглуздий наполегливо вітрина жити сумнівний. Хлопець метал повністю темніти вовк рис господь. Шкіра заклад лягати чотири написати перебивати.', 'CANCELLED', NULL, '2025-01-21 23:43:10', '2025-02-10 21:15:57');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (19, 1, 2, 'Реклама незручно інвалід мати струмок сумний даль.', 'Правління полюбити інтернет мить теорія білизна. Ягода летіти бак головка кут розгубитися. Близько помовчати програміст мигнути чоловічок сумнівний. Лапа деякий зелений ґудзик вмирати їсти рис вітрина.', 'IN_PROGRESS', NULL, '2025-01-26 23:27:08', '2025-02-08 20:27:23');

SELECT setval('item_id_seq', COALESCE((SELECT MAX(id) FROM item), 1) + 1, false);
