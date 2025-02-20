-- V1: Initial schema

INSERT INTO user_details (id, phone, address, description) VALUES (4, '+380 75 677 78 19', 'парк Заводська 3-тя, буд. 65 кв. 008, Харків, 21470', 'Чотири команда дорогий шкіра зима банда труп. Відділ написати заспокоїтися тривога. Монета наступати прихований даль новий.');
INSERT INTO user_details (id, phone, address, description) VALUES (5, '+380 75 677 78 19', 'парк Заводська 3-тя, буд. 65 кв. 008, Харків, 21470', 'Чотири команда дорогий шкіра зима банда труп. Відділ написати заспокоїтися тривога. Монета наступати прихований даль новий.');

SELECT setval('user_details_id_seq', COALESCE((SELECT MAX(id) FROM user_details), 1) + 1, false);

INSERT INTO users (id, login, first_name, last_name, role, user_details_id, created_ts, updated_ts) VALUES (4, 'alpha', 'Альфа', 'Охримович', 'SOLDIER', 4, '2025-02-05 00:32:40', '2025-02-16 17:21:22');
INSERT INTO users (id, login, first_name, last_name, role, user_details_id, created_ts, updated_ts) VALUES (5, 'delta', 'Дельта', 'Охримович', 'SOLDIER', 5, '2025-02-05 00:32:40', '2025-02-16 17:21:22');

SELECT setval('users_id_seq', COALESCE((SELECT MAX(id) FROM users), 1) + 1, false);

INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (6, 4, 'Їжа боєць низький тисяча прірва лівий.', 'Блін суглоб упустити відзначити зате будівництво мить. Образа тривога танцювати житель недолік червонй. Актриса перебивати порада блін зрідка. Адвокат залучати актриса звільнення гіркий. Каюта похорон потрясти перетнути.', 'OPEN', '2025-01-02 08:16:08', '2025-01-21 06:27:02');
INSERT INTO request (id, user_id, summary, description, status, created_ts, updated_ts) VALUES (7, 5, 'Спасти несподівано тисяча порада спалити.', 'Шкільний фахівець промовчати олівець мимо настати другий. Диявол збудження спалити функція актриса. Вчора знімати труп космос чітко деякий.', 'OPEN', '2025-01-23 20:56:29', '2025-01-27 10:55:01');

SELECT setval('request_id_seq', COALESCE((SELECT MAX(id) FROM request), 1) + 1, false);

INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (20, 6, 1, 'Порада червʼяк уникати мимо.', 'Банк кпсс монета. Адже заява вибирати очко. Блискучий нині шолом виражений сміливий. Трубка перед плід вказаний летіти взагалі близько. Черговий так голубчик коричневий вивести робочий.', 'OPEN', NULL, '2025-01-12 22:22:01', '2025-02-06 23:28:54');
INSERT INTO item (id, request_id, category_id, summary, description, status, closed_by_user_id, created_ts, updated_ts) VALUES (21, 7, 1, 'Хата ґудзик помовчати порода протягувати трясти.', 'Спасти доба міркування супроводжуватися. Аналіз увійти загроза купа-невеличка в''язниця знаходити. Виднітися голубчик командування що військовий пробувати здалеку. Більше кут командування багряний. Вказаний самостійно хліб задерти.', 'IN_PROGRESS', NULL, '2025-01-27 16:58:23', '2025-02-08 07:17:11');

SELECT setval('item_id_seq', COALESCE((SELECT MAX(id) FROM item), 1) + 1, false);
