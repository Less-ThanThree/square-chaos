# Игра «TapTap»

## 🧩 Жанр:

Жанр игры — **Puzzle**, **Matching**.
Игры подобного жанра: [Night Mode](https://noahuxui.itch.io/night-mode), [Simon Says](https://www.mathsisfun.com/games/simon-says.html), [Color Switch](https://apps.apple.com/us/app/color-switch/id1314725881)

## 📑 Beat-Chart и Система стадий

### Beat-Chart

![BeatChart.png](https://s2.loli.net/2023/10/16/djcV1EN28A5WexX.png)

**ССЫЛКА НА BEAT-CHART:**  **[→ ССЫЛКА ←](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=0)**

### <a id = "СистемаСтадий">  **Система стадий:** </a>

Система стадий организует игровой процесс в серию этапов, усиливающих сложность и динамику, а так же вбирая в себя все системы и механики игры. 

1. **Прогрессирующая сложность:** Каждая следующая стадия пропорционально увеличивает трудность пазлов.
2. **Новые механики и вызовы:** Вводятся специфические механики и задачи на каждой стадии, требуя от игрока принятия стратегических решений.
3. **Вознаграждения:** Переход на новые стадии увличивает вознаграждения от системы [подсчёта очков](#гПодсчётОчков).
4. **Динамическое изменение:** Механика выбора путей и механика "бафов" и "дебафов" динамически изменяется в зависимости от стадии и выборов игрока.

Основной акцент здесь — создание чёткой, пошаговой структуры, которая усиливает сложность и предоставляет постоянно изменяющиеся вызовы и стимулы *(в рамках баланса)* для игрока, поддерживая таким образом интерес и мотивацию к продолжению игры.

## 🕹️ Управление

![Управление.png](https://s2.loli.net/2023/10/22/14ct8YLTjqmOlbg.png)

### <a id = "гтапания">  **Тапания:** </a>

Система "Тапание" является основным средством взаимодействия игрока с игрой. Игрок использует тапы для взаимодействия с элементами на экране, создания комбинаций, прогресса и решения пазлов в игре.

1. **Основной Тап (Basic Tap)**
   - **Описание**: Простое касание элемента на экране.
   - **Цель**: Взаимодействие с элементами, активация.
   - **Отклик**: Визуальный (анимация элемента) и аудиальный (звуковой эффект при тапе).
2. **Множественный Тап (Multiple Tap)**
   - **Описание**: Касание элемента больше одного раза.
   - **Цель**: Активация специального эллемента, умение, бафа или дебафа.
   - **Отклик**: Уникальная визуальная и аудиальная обратная связь, отличающаяся от основного тапа.
3. **Удерживающий Тап (Hold Tap)**
   - **Описание**: Удержание элемента в течение определенного времени.
   - **Цель**: Возможно, активировать альтернативное действие.
   - **Отклик**: Визуальная индикация (например, элемент "заряжается" или меняет цвет) и аудиальная обратная связь.

## ⚙️ Системы и механики:

![СистемыиМеаники.png](https://s2.loli.net/2023/10/16/dkTz61JyXinM52p.png)

### <a id = "гСоответствие">  **Игра в "соответсвие":** </a>

Главная цель игрока – повторить паттерн, представленный на "целевом поле" путем активации аналогичных клеток в своей игровой зоне. Система автоматически генерирует эти паттерны, обеспечивая уникальные комбинации на каждом этапе. Вот как это работает:

1. Игроку предоставляется пустое Игровое поле и Целевое поле с определенным паттерном.
2. Игрок нажимая на пустые клетки на Игровом поле соотвествующие паттерну Целевого поля повторяет пазл Целевого поля. 
3. Если игрок успешно повторил паттерн то игрок получает награды и возвращается к 1 пункту.

<img src="https://s2.loli.net/2023/10/08/OP6FYCn75GfBl3i.jpg" alt="ЦелевоеИИгровоеПоле.jpg" style="zoom:150%;" />

#### <a id = "гМеханикаКлеток"> **Механика клеток:**</a> 

Клетки — это компоненты из которых состоит Целевое и Игровое поле и с которыми взаимодействует игрок. Однако если на Целевом поле игрок <u>НИКАК</u> не может взаимодействовать с клетками, то на Игровом поле у клеток есть три состояния.

<a id = "гБазовоеСостояниеКлеток">**Базовое состояние клеток:**</a> 

- **Невыбранное**: Стандартное состояние, не влияет на текущую игру.
- **Промежуточное**: На клетку наложен определенный эффект. *(Об этом подробнее в [Разновидности клеток](#гРазновидностиКлеток))*
- **Выбранное**: Клетка активирована игроком и участвует в формировании паттерна.

#### <a id = "гИгровоеПоле"> **Игровое поле:**</a> 

Игровое поле – пространство, состоящее из клеток, с которыми игрок может взаимодействовать, чтобы сформировать паттерн, соответствующий Целевому полю.

#### <a id = "гЦелевоеПоле">  **Целевое поле:**</a>

Целевое поле – представляет собой паттерн из клеток *(с которыми нельзя взаимодействовать)*, который игрок стремится воссоздать на Игровом поле.

**"Рандомизация" целевых полей:**

- **Генерация паттернов**: Паттерны формируются динамически, обеспечивая высокую степень вариативности и повторяемости игрового процесса.
- **Ограничения и настройки**: Важно сохранить возможность настроить параметры генерации, например, установив ограничение на максимальное количество элементов в паттерне. Это позволит контролировать уровень сложности и избегать создания чересчур сложных или простых комбинаций.
- **Интеграция с системой стадий**: Паттерны могут динамически адаптироваться в зависимости от прогресса игрока и текущей стадии в [системе стадий](#гСистемаСтадий), обеспечивая постепенное увеличение сложности и поддерживая интерес и мотивацию игрока на протяжении всей игры.

Рандомизация так же должна будет учитывать, в чуть-чуть более поздней стадии игры, существование второго "целевого поля". Под вторым целевым полем я подразумеваю следующее:

![Group 82.jpg](https://s2.loli.net/2023/10/08/siP4I2ekadfj3gV.jpg)

### <a id = "гтаймеры">  **Таймеры:** </a>

Таймеры, это основной сподвижник и нерв игрока. У игрока существуют два таймера:

1. **Таймер пазла** – Запускается с каждым новым пазлом, ограничивая время на его решение и добавляя бонусное, оставшееся после решения, время к **Общему таймеру**.
2. **Общий таймер** – Действует как резервное время, активируется при истечении **Таймера Пазла** и, при его полном исчерпании, игра завершается.

Таймеры действуют по следующей логике:

![TimerDiagrama.png](https://s2.loli.net/2023/10/08/kICxbvWfaEZQYBM.png)

### <a id = "гПодсчётОчков">  **Подсчёт очков:** </a> 

Элемент, стимулирующий конкуренцию и удержание игроков, метрика очков является центральным аспектом игрового процесса и распределяется следующим образом:

1. **Убавление очков:**
   - У игрока отнмиают **N** кол-во очков каждую секунду.
2. **Очки за пазлы:**
   - Решив пазл, игрок зарабатывает **N** очков, независимо от его сложности.
3. **Бонусы и Множители:**
   - **Скоростной множитель:** Быстрое решение пазлов увеличивает получаемые очки, мотивируя игроков действовать оперативно и увеличивая темп игры.
   - **Множитель серии:** Успешное решение последовательности пазлов активирует множитель, увеличивая награду за каждый новый успешно решенный пазл.
   - **Множитель Сложности Стадии:** Как пример, очки, полученные на более поздних и сложных стадиях игры, могут умножаться на больший коэффициент, отражая повышенную сложность.
4. **Достижения:**
   - Игроки награждаются дополнительными очками за достижение конкретных метрик, таких как общее количество очков или время, проведенное в рамках одной сессии без проигрыша.

### <a id = "гВыборПутей">  **Выбор путей:** </a>

При достижении определённой стадии игрок получает возможность "выбора путей". Это позволяет выбрать специфическое "целевое поле", принеся с собой определённый "баф" или "дебаф". Выбор определяется воссозданием паттерна соответствующего "целевого поля".

<img src="https://s2.loli.net/2023/10/08/xpXdhz7fn1b6HTi.jpg" alt="ВыборПутей.jpg" style="zoom100%;" />

В приведенном примере, на картинке выше, можно заметить, что есть несколько исходов:

1. Игрок выберет легкий путь *(Целевое поле #1)* и получит дебаф.
2. Игрок начав заполнять игровое поле с неправильной стороны *(т.е начиная слева сверху)* непреднамеренно выберет легкий путь *(Целевое поле #1)* и получит дебаф.
3. Игрок выберет сложный путь *(Целевое поле #2)* и получит баф.

#### <a id = "гМехБафыДебафы">Механика "бафов" и "дебафов": </a>

В контексте механики "выбора путей", бафы и дебафы служат инструментами для модификации игрового опыта и стратегического планирования. Каждый "путь" или "целевое поле", выбранное игроком, активирует определённые изменения в условиях игры:

![ВыборБафовИДебафов.jpg](https://s2.loli.net/2023/10/09/aGzVvgyUxwQ1B6N.jpg)

<u>Выбор</u> между бафами и дебафами становится ключевой стратегической точкой, поскольку игроки должны взвешивать короткосрочные выгоды против потенциальных долгосрочных выигрышей или потерь.

#### Логика работы "бафов" и "дебафов":

**Шанс выпадения Баффа и Дебаффа:**

- **Исходные вероятности**: На старте игры, вероятности выпадения **баффа** и **дебаффа** на Целевых полях #1 и #2 установлены как **50% / 50%**.
- **Динамическое изменение**: Игрок может влиять на эти вероятности в процессе игры, изменяя баланс в пользу баффов или дебаффов.

![ЛогикаБафовИДебафов.jpg](https://s2.loli.net/2023/10/14/Wi2QsY5gxo9rtcP.jpg)

**Присвоение Весов:**

- **Баффы/Дебаффы (B1, B2, ..., Bn)**: Различные эффекты в игре.
- **Веса (W1, W2, ..., Wn)**: Вес, присвоенный каждому баффу / дебаффу, определяющий его базовую вероятность выпадения.

$$
\text{Вероятность Баффа} = \left( \frac{\text{Вес Баффа}}{\text{Общий Вес Всех Баффов}} \right) \times 100\%
$$

**Пример:**

Представим, что у нас есть 3 баффа с весами 5, 3 и 2.

- **Шаг 1**: Сложим их веса: 5 + 3 + 2 = 10 *(Общий Вес)*.
- **Шаг 2**: Разделим вес каждого баффа на общий вес. Например, для баффа с весом 5: 5/10 = 0.5.
- **Шаг 3**: Переведем в проценты: 0.5 × 100% = 50%

![Screenshot_1.png](https://s2.loli.net/2023/10/15/1pmHKctBbPQNiv7.png)**🠔 Расчет Вероятностей с учетом Весов.**

#### Алгоритм Работы "Банка Вероятностей":

**Переменные:**

- **Баффы/Дебаффы (B1, B2, ..., Bn)**: Различные эффекты в игре.
- **Веса (W1, W2, ..., Wn)**: Вес, присвоенный каждому баффу / дебаффу, определяющий его базовую вероятность выпадения.
- **Множитель Уменьшения Веса (M1, M2, ..., Mn)**: Процент, который отнимается у веса баффа/дебаффа при его выпадении.
- **Счетчик (C1, C2, ..., Cn)**: Количество ходов, прошедших с момента последнего выпадения баффа/дебаффа.
- **Счетчик Максимума (max1, max2, ..., maxn)**: Максимальное количество ходов, после которого *W* возвращает *M*.

**Простая формула:**

1. **Выбор Баффа/Дебаффа**: Основывается на текущих вероятностях, рассчитанных на основе весов.
2. При Выпадении Баффа/Дебаффа **Bi:**
   - Уменьшите **Wi** на **Mi**.
   - Расспределить **Mi** между оставшимися **W** *(кроме **Wi**)*
   - Сбросьте **Ci** до 0.
3. Если **Bi** не выпал:
   - Увеличьте **Ci** на 1.
   - Если **Ci** равен **maxi**, вернуть потерянные **Mi** к **Wi** и сбросьте **Ci** до 0.

**Слонжая формула:**

![Screenshot_2.png](https://s2.loli.net/2023/10/15/D9ZxSqbpYW4MFaj.png) 

![Screenshot_3.png](https://s2.loli.net/2023/10/15/PYWhdVfswEHlM8D.png) 

### <a id = "гМеханикаОшибок">Механика "ошибок" :</a>

Механика ошибок является частью усложнения игры, на которую игрок может влиять включая ```(true)``` или выключая ```(false)``` её через выбор соответсвующего бафа или дебафа. *(Об это подробнее в [Бафы и Дебафы](#гМехБафыДебафы))*

**Типы клеток:** *(Это нужно для описания логики механики, а не для игрока, он их не видит)*

- **Зеленые клетки**: Соответствуют обоим целевым полям, позволяя игроку сохранить возможность выбора.
- **Красные клетки**: Не соответствуют ни одному целевому полю; активация аннулирует текущее Игровое поле.
- **Оранжевые клетки**: Соответствует только одному из целевых полей.

**Механика выбора паттерна с учетом механики "ошибок":**

1. **Начало**: Игрок имеет два Целевых поля с двумя паттернами и пусто Игровое поле.
2. **Выбор паттерна**: Нажатие на зеленую клетку сохраняет возможность выбора между двумя Целевыми полями.
3. **Фиксация выбора**: Нажатие на клетку, уникальную для одного из Целевых полей, фиксирует выбор паттерна.
4. **Аннулирование**: Выбор красной клетки аннулирует текущий паттерн, сбрасывая Игровое поле. Т.е все активированные *(выбранные)* клетки игрока становяться неактивированными *(невыбранными)*.

В примере ниже показана следующая логика: У игрока есть Целевое поле #1 и Целевое поле #2, эти поля затрагивают клетки 1, 2, 3, 4, 7, 8, 9. При нажитии игроком на оранжевую клетку 7, он выбирает решить пазл Целевого поля #2, соотвественно клетки 1, 2, 3 (и 5, 6) теперь будут считаться красными клетками. Если же игрок не нажмет на красные клетки и успешно решит пазл, то игрока наградят и он приступ к новому пазлу. 

![Group 28.jpg](https://s2.loli.net/2023/10/11/VEUkvucNW4qzXnb.jpg)

### <a id = "гРазновидностиКлеток">  **Разновидности клеток:** </a>

У клеток существует промежуточное состояние между "неактвированным" и "активированным". В этом промежуточном состоянии, могут быть задействованы разные разновидности клеток, которые могут усложнить или упростить жизнь игрока. Обязательным условием для появления разновидности клеток, это то что клетка должна учавствовать в формированнии одного из патернов Целевого поля (#1 или #2).

<img src="https://s2.loli.net/2023/10/15/EzN2LdUkTxIpYih.png" alt="Клеточки.png" style="zoom:50%;" />

#### Леденные клетки:

Требуют ["удерживающего тапа"](#гтапания) на протяжении заданного **N** времени для активации, после чего сразу учавствует в формировании паттерна. Если тап отпущен раньше, прогресс сбрасывается.

⚠️ **<u>Леденные</u> клетки в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) 🔎**

#### Защищенные клетки:

Имеет **N** кол-во **HP**, при каждом тапе на клетку она теряет **N** кол-во **HP**, когда **HP** становиться **0** то эффект сбрасывается с клетки и игрок может актвивировать клетку для успешного создания паттерна. 

⚠️ **<u>Защищенные</u> клетки в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) 🔎**

#### Золотые клетки:

Клетка, при единичном тапе на которую к счёту игрока начисляет дополнительно **N** кол-во **очков** **×** **множитель очков**, после чего клетка сразу становиться "активной" и учавствует в создании паттерна.

⚠️ **<u>Золотые</u> клетки в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) 🔎**

### <a id = "гРассширения">  **Рассширения и модификации:** </a>

Тут включено все потанциальные рассширения и модификации, которые могут быть использованы в будущем для других механик и разнообразия игрового процесса.

#### <a id = "гИзменениеРИП"> **1. Изменение размера игрового поля:** </a>

Возможность изменять размер игрового поля предоставляет дополнительные опции для настройки сложности и изменения динамики игры.

**Пример**: Меньшие поля (2x2) могут предложить более простые и быстрые раунды, в то время как большие поля (4х4) могут быть использованы для более поздних этапов игры.

⚠️ **О полях в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=970280567) 🔎**

![Group 18.jpg](https://s2.loli.net/2023/10/08/4fzwLxcgX5ptj12.jpg)

#### <a id = "гПоворот">  **2. Поворот игрового поля:** </a>

Начиная с определенной стадии включается эта функция, которая переворачивает Целевые и Игровые поле игрока, на **N°** градусов **N** кол-во раз в промежутке **N** времени.

**Пример**: Поворот может изменить динамику существующего паттерна, тем самым слегка обезкуражив и/или запутав игрока. Это может быть использовано как спонтанное событие и может быть интегрировано в уровни или стадии.

![Поворот.jpg](https://s2.loli.net/2023/10/08/GlDLr28IXTyBvV3.jpg)

### <a id = "гБафыДебафы">  **Бафы и Дебафы** </a>

#### Бафы:

🟩 [**Бафы**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=1646904177) – положительные модификаторы, которые предоставляют игроку преимущества, например, увеличение времени на раздумье, дополнительные очки или усилители, упрощающие прохождение следующих этапов.

⚠️ **О вероятности выпадения Бафов в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=1646904177) 🔎**

1. 🟩🔎 [**Плюс время:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=2133530348) Добавляет **N** единиц времени к общему таймеру.
2. 🟩🔎 [**Плюс очки:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=344400765) Прибавляет **N** очков к счету игрока.
3. 🟩🔎 [**Сужение поля:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=970280567) Изменяет размер игрового поля игрока на меньшее. *(Игровое поля игрока НЕ может быть меньше **2x2** и больше **4x4**)*
4. 🟩🔎 [**Отключение ошибок:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=850277510) Отключать функцию ["механика ошибок"](#гМеханикаОшибок).
5. 🟩🔎 [**Меньше клеток:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=2063073422) Уменьшает количество заполненных клеток на Целевом поле на **N**, но НЕ может быть меньше одного.
6. 🟩🔎 [**Меньше вероятность клеток с**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) **[название эффекта]:**
   - **Леденных клеток:** Вероятность выпадения клеток с этим эффектом на **N** меньше.
   - **Защищенных клеток:** Вероятность выпадения клеток с этим эффектом на **N** меньше.
7. **🟩🔎 [Больше вероятность клеток с](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) [название эффекта]:**
   - **Золотых клеток:** Вероятность выпадения клеток с этим эффектом на **N** больше.
8. 🟩🔎 [**Более контрастная политра:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=787576815) Увеличивает контрастность паттерна на Целевом поле.
9. 🟩🔎 [**Увеличить шанс выпадения бафа:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=651493572) Повышает вероятность получения бафа.
10. 🟩🔎 [**Временная защита:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=950255572) Позволяет игроку **N** раз избежать получения дебафа при выборе пути с дебафом.
11. 🟩🔎 [**Фризер:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=727189198) Убирает ограничение по времени, позволяя игроку решать пазлы в течение **N** времени без спешки.

#### Дебафы:

🟥 [**Дебафы**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=1570983238) – отрицательные модификаторы, создающие дополнительные препятствия или увеличивающие уровень сложности, такие как сокращение доступного времени, уменьшение набранных очков или усложнение следующих пазлов.

⚠️ **О вероятности выпадения Дебафов в Beat-Chart: [ССЫЛКА](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=1570983238) 🔎**

1. 🟥🔎 [**Минус время:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=2133530348) Снимает **N** единиц времени к общему таймеру.
2. 🟥🔎 [**Минус очки:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=344400765) Снимает **N** очков счёта игрока.
3. 🟥🔎 [**Рассширение поля:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=970280567) Изменяет размер Игрового поля игрока на большее. *(Игровое поля игрока НЕ может быть меньше **2x2** и больше **4x4**)*
4. 🟥🔎 [**Включение ошибок:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=850277510) Включает функцию ["механика ошибок"](#гМеханикаОшибок).
5. 🟥🔎 [**Больше клеток:**](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=2063073422) Увеличивает количество заполненных клеток на Целевом поле на **N**. НЕ может быть больше *(Размер поля игрока - 1 клетка)*.
6. 🟥🔎 **[Больше вероятность клеток с](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) [название эффекта]:**
   - **Леденных клеток:** Вероятность выпадения клеток с этим эффектом на **N** больше.
   - **Защищенных клеток:** Вероятность выпадения клеток с этим эффектом на **N** больше.
7. 🟥🔎 **[Меньше вероятность клеток с](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=987570823) [название эффекта]:**
   - **Золотых клеток:** Вероятность выпадения клеток с этим эффектом на **N** меньше.
8. 🟥🔎 **[Менее контрастная политра:](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=787576815)** Увеличивает контрастность паттерна на Целевом поле.
9. 🟥🔎 **[Увеличить шанс выпадения дебафа:](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=651493572)** Повышает вероятность получения дебафа. 
10. 🟥🔎 **[Медленное угасание:](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=401669571)** В течении **N** времени на Целвые поля применяется этот эффект. После появления пазла, пазл в течении **N** времени виден игроку, в течении **N** времени угасает, **N** времени не виден игроку и **N** времени снова возвращается и виден игроку. 
11. 🟥🔎 **[Туман/Шум:](https://docs.google.com/spreadsheets/d/1mJVV2EKqF-cOemycu8XRlATVJXQGLINtx3vg_SYk1q4/edit#gid=1773193787)** В течении **N** времени на Целвые поля применяется этот эффект. Создает абстрактные помехи и аномалии на экране, мешая игроку видеть паттерн целевых полей.

## 🖥️ Интерфейс:

![Интерфейс.png](https://s2.loli.net/2023/10/22/o51iG9FBWt2I4yZ.png)

![ИнтерфейсПрототип1.png](https://s2.loli.net/2023/10/08/J56cdOUv1GDIP2j.png)

## 🖼️ Дизайн:

![Дизайн.png](https://s2.loli.net/2023/10/22/bi3kPBfQFW457Vh.png)

Дизайн «TapTap» —

## 👁️ Визуальный-дизайн:

![ВизуальныйДизайн.png](https://s2.loli.net/2023/10/29/ev1rIuQSNkXa9fl.png)

### Общая атмосфера:

### Дизайн локаций:

## 🔊 Аудио-дизайн:

![АудиоДизайн.png](https://s2.loli.net/2023/10/29/TxCELUoAeh7jMkY.png)

### Аудио-концепция:

Наша цель — передать атмосферу мира "кодирования" и "програмированния", вдохновляясь фильмами и сериалами вроде "Матрица", "Mr.Robot", "Бегуий по лезвию" и элементами киберпанка. Мы стремимся соединить цифровое, механическое и аналоговое, смешивая ретро и современное, но не уходя в крайности. 

**Главное правило:**  Игра <u>обязана</u> создать ощущение <u>ритма</u> и <u>динамики</u>.

### 🎵 Музыкальная концепция:

Музыка в первую очередь должна играть роль метронома, который задает темп и настрой игры для игрока. При этом музыка, не должна перебивать звуковые эффекты, а лишь стать частью дополняющей их, а они частью дополняющие музыку.

#### **Музыкальное вдохновение**:

- [**Brakecore**](https://everynoise.com/engenremap-breakcore.html) — упор будем делать на жанр музыки [Brakecore](https://everynoise.com/engenremap-breakcore.html), немного из наиболее подходящих примеров:

  1. [Kaizo Slumber – Body Parts](https://youtu.be/lOJr4KquzgI?si=eM4uJuVK_hhaesXj); Загадочный ритм, амбиентное погружение. Подошло бы идеально для начальных стадий.

  2. [Sewerslvt – Cyberia lyr1](https://www.youtube.com/watch?v=HOAKXWTtIuE); Захватывающий ритм, эволюционирующая сложность. Подошло бы для начальных и средних стадий.

  3. [edge – Mikura](https://www.youtube.com/watch?v=NTX3LXIaBkI); Мгновенное погружение, насыщенная атмосфера, глитч-эффекты. Подошло бы для средних стадий.

  4. [Koonut – Kaliffee](https://www.youtube.com/watch?v=w8ezcgMoHhU&list=OLAK5uy_lwQOD1lr5lDVMG3CTuPDClU7jP1d4ZuDg&index=2); Не сильно подошло бы, но при этом здесь хорошая, уникальная и странная, атмосфера.

     Главное в нашем случае с [Brakecore](https://everynoise.com/engenremap-breakcore.html) — это ритмика. Она может быть как безумно быстрой благодаря драмкам и звуковым эффектам, так и медитативной с  расслабляющими повторяющимися паттернами, которые заметны, но не отвлекают.

- ***OST Inspirations*** — Берем наше игро-вдохновение от:

  1. [OST Watch Dogs;](https://youtu.be/ADoVBGkB_xU?si=lE70GQAv0G6uuyum) Атмосфера, ощущение, звуки, не во всех песнях есть то настроение и звучание, что нам нужно, но такие треки как: *Burning Desire*, *Eye for an Eye*, *Cyber Drive*, *Robot*, *The Motherload*, *Boys Noize - Overthrow*, прекрасно передают то, что нам нужно.

  2. [OST Ghostrunner](https://www.youtube.com/watch?v=DyYlQ9Li8Ss&list=PL8UbYpPIoqN1MPqIMmS0VAPY63ZAZdsOB&index=2); Константный ритм и напряжение, такие треки как: *Dharma*, *Capture*, *Sector*, *Celerity*, *Razor* и *Vendetta* передают атмосферу "цифрового будущего".  

  3. [OST Far Cry 3: Blood Dragon](https://www.youtube.com/watch?v=MEtdyn2QEzA&list=PLu6_FOgZp3ehDEMebGB4uDbN5yMYOthnP&index=2); треки с электронным преломлением ретро-стиля, передающие налет апокалиптического будущего и винтажного техно-попа, конкретные примеры треков: *Warzone*, *Dr Elizabeth Darling*, *Sloan*, *Sloan's Assault*, *Combat III* и *Rex's Escape*.

     Взаимствования <u>обязаны быть осторожными</u>, не переводя игрока в совершенно другой мир или временной период, а так же чтобы не отвлекать игрока от игрового процесса.

- **CodeWave** — Обзавем наш подход к созданию звуков и музыки игры "CodeWave", краеугольным камнем которого будет взаимоствование подхода к атмосфере и звуковым эффектам артист [Ryoji Ikeda](https://en.wikipedia.org/wiki/Ryoji_Ikeda), примеры:

  1. [Ryoji Ikeda – data.matrix](https://www.youtube.com/watch?v=_wJPXrO1cdg); Смешивание цифровых и аналоговых звуков создаёт ощущение работы программы.  

  2. [Ryoji Ikeda – supersymmetry](https://www.youtube.com/watch?v=f5jAARLCTbo); Комбинация цифровых, аналоговых звуков и звуков природы создаёт лёгкий эмбиант, сохраняя "программный" характер.

     Из чуть-чуть более приятных примеров выделю следующие композиторов и композиции:

  3. [Kyohei Shibuya – Particle and Rectangle](https://www.youtube.com/watch?v=NsVl-C9X_Ho); Лёгкий эмбиант с вкраплениями цифровых эффектов, которые гармонично вписываются в композицию.

  4. [Venetian Snares – Ion Divvy](https://www.youtube.com/watch?v=KB7WsnuwJ4A); Цифровые и аналоговые звуки плюс интересное пианино на фоне, образует неплохую композицию.

  5. [s.soo – Over the precipice](https://www.youtube.com/watch?v=i2UOdgdtfBA); Лёгкий амбиент, включающий в себя и аналоговые, и цифровые звуки.

  **"Цифровой мир"** — К всему вышеперечисленному можно также причислить и:

  1. [Databending](https://www.youtube.com/watch?v=XxeXm5GAUnc&list=PL7w4cOVVxL6HfT-FoqQ1ukW2G__l0fTr6); Подход преобразования любого типа файла за счёт использования его в непривычной среде, иногда создает интересные прициденты.
  2. [Algorave](https://youtu.be/7qfCeIgtllY?si=nFNIct0085VDdXbQ); Весь концерт по сути почти идеально передает каким должен быть какой-то промежуточный или почти конечный результат терков. 
  3. [Les framboisiers sous la neige – SuperCollider & p5.js](https://youtube.com/watch?v=6QXGw4NHXzE); Смешение реальных инструментов с цифровыми звуками.
  4. [20231022](https://www.youtube.com/watch?v=owWU4GKEL4o); Легкий, и крайне приятный цифровой эмбиант.

  **"Механический мир"** — "Цифровой мир" является производным всего происходящего в "механическом мире", что можно подчеркнуть через:
  
  1. [Floppy Music](https://www.youtube.com/watch?v=lx_vWkv50uk&list=RDQML8MxzPhnVwk&start_radio=1); Дополнительный слой погружения через музыку, ощущение не только условного "цифрового мира", но и звуков реального мира однако относящихся к все той же сфере.
  2. [Ambiant Nuture](https://www.youtube.com/watch?v=4FhsjQ2xess); Ещё один дополнительный слой связи "реального", "механического" и "цифрового", но с ним нужно быть поакуратнее, звуки дождя, природы и т.д, не должны выходить на первый план.
  
- **Результат?** — Последним, но не менее важным считаю создание одного общего видения для всего вышеперечисленного. На вопрос "как?" предстоит ответить тебе Анатолий. Добавление своих фишек и конкретного видения звучания будет целиком лежать на тебе и не будет мной лично оспариваться. В конце концов, ТЫ главный звукорежиссер и там где ты что-то не способен сделать так, как того хочу я или кто-то другой, делай так, как считаешь более интересным ты.

#### **Рекомендации к созданию:**

| Точно да!                                                    | Точно нет!                                                   |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| Взаимоствование подхода к атмосфере и звуковым эффектам артиста Ryoji Ikeda и др. | Слишком выразительные, насыщенные мелодии, которые отвлекут внимание от игрового процесса. |
| Смешивание цифровых и аналоговых звуков.                     | Монотонные, невыразительные звуки.                           |
| Лёгкий эмбиант с вкраплениями цифровых эффектов.             | Звуки, которые радикально не соответствуют "цифровому миру". |
| Смешение реальных инструментов с цифровыми звуками.          | Отсутствие гармонии между различными элементами звука.       |
| Использование Databending и т.п как инструменты создания уникального звука. | Превышение звуков природы над основными элементами трека.    |
| Интеграция звуков "механического мира", таких как Floppy Music. | Звуки, которые могут раздражать или вызвать дискомфорт у игрока. |
| Амбиент, сочетающий в себе элементы "реального", "механического" и "цифрового". | Слишком сложные и перегруженные композици.                   |

**Косательно жанров:**

| Точно да!                                                 | Точно нет!                                        |
| :-------------------------------------------------------- | :------------------------------------------------ |
| Экспериментальная электроника.                            | Слишком коммерческая и попсовая электроника.      |
| IDM (Intelligent Dance Music) — умный танцевальный музон. | Chiptune или 8-битная музыка.                     |
| Minimal techno с элементами экспериментала.               | Эпическая, оркестровая музыка.                    |
| Dark ambient — темный амбиент.                            | Светлые и радостные треки без "цифрового" налёта. |
| Glitch и microsound.                                      | Стандартный джаз или классика без инноваций.      |

### 🎚️Звуковые концепция:

Цель звукового дизайна в «TapTap» — создать атмосферу сосредоточенности и погружения для игрока, поддерживая при этом чувство ритма и ответа на каждое его действие.

**Главное правило №1:** Игра <u>обязана</u> создать ощущение <u>ритма</u> и давать <u>четкую обратную связь</u> на <u>каждое</u> действие игрока.

**Главные под-правила всех звуков №2:**

1. **"Играй комфортно"** → Все взаимодействия игрока с игрой должно сопровождаться "нейтрально-приятными" звуками.
2. **"Награди успех"** → "Правильные" действия (например, успешное решение головоломки или выбор бафа) должны подкрепляться "особо-приятными" звуками.
3. **"Избегай дискомфорта"** → "Ошибочные" действия должны выделяться "определённо-неприятными" звуками и нарушать ритм игры.

#### Звуковое вдохновение:

- **Audiosurf, Bear Saber и OSU** — Эти игры отличные примеры того, как можно гармонично сочетать музыкальное и звуковое сопровождение, создавая тем самым отзывчивую и вовлекающую атмосферу. Во многом их "Hit Sound"-ы можно взять как пример того, что будет происходить внутри самой игры и то как аудио должно реагировать на действия игрока.
  1. [Audiosurf](https://store.steampowered.com/app/12900/AudioSurf/) и [Audiosurf 2](https://store.steampowered.com/app/235800/Audiosurf_2/); В этих играх стоит обратить внимание на моменты, когда персонаж собирает "кубики" на трассе, и на моменты, когда одна из "шкал" заполняется полностью. [Ссылка на пример](https://www.youtube.com/watch?v=cQVS6lQbVuE) прислушавшись можно четко понять, что эти звуковые эллементы лишь приятно дополняют общую картину, не мешая наслаждаться музыкой.
  2. [Bear Saber](https://store.steampowered.com/app/620980/Beat_Saber/); В этой игре каждое успешное попадание по блоку сопровождается четким и удовлетворительным звуком, который подчеркивает ритм трека и создает дополнительное чувство удовлетворения от игрового процесса. Однако стоит отметить, что в нашей игре мы стремимся к более тонкому и вариативному звуковому сопровождению. В то время как в Beat Saber звуковые эффекты прямо и ясно отражают успешность действий игрока, в "TapTap" мы хотим добиться более разнообразной палитры звуковых откликов, которая бы отражала не только успешность, но и степень "правильности" каждого конкретного действия.
  3. [OSU](https://osu.ppy.sh/home); Хотя этот пример менее применим из-за более "прямого" подхода к звуковым эффектам, он тоже может служить источником вдохновения. В "TapTap" мы нацелены на создание единой стилистики в музыке, звуках и визуале, а потому универсальность нам не к лицу. [Ссылка на пример](https://youtu.be/_TtFYbs3AnE?si=lu8Dv8KzVQ7fRkB7), как можно заметить некоторые звуки звучат излишне вызывающе, что не сильно подходит нам. 
- **Что на счёт менюшки? **— Передвижение по менюшке должно быть исключительно приятным, каждое действие внутри меню игры должно сопровождаться звуком подстегивающим на то, что-б остаться в игре подольше. 
  - [Watch Dogs](https://youtu.be/q8_f8NnkEgE?si=XWsmsuAAcJhRw9Qj); Берем во внимание только 1-ую и 2-ую части игры. Звуковой дизайн меню имитирует интерфейс хакерской программы. Каждый звуковой сигнал при выборе опций или подтверждении действий подчёркнут простотой и функциональностью. Чёткость и краткость звуковых сигналов способствуют усилению ощущения взаимодействия с системой. В нешм случае в том числе применимо всё вышесказанное в [музыкальном разделе](#🎵 Музыкальная концепция). Ещё пару примеров: [Пример №1](https://www.youtube.com/watch?v=SoDM9wwYpFw), [Пример №2](https://www.youtube.com/watch?v=lEpwxHhUJMg).
  - [Cyberpunk 2077](https://youtu.be/hOx79grNWkc?si=XLevy5DPYdXrmAb4); Меню – это чистый стиль киберпанка. Звуки лаконичны и точны, дополняют дизайн, не отвлекают от сути. При этом стоит отметить определенную скудность в разнообразии звуков.
  - [Nintendo Super-Tonal sound-design](https://youtu.be/toEdi_wjTGM?si=vgTRpwckamU2l6sJ&t=133); В нашей игре, на подобие звукового дизайна игр Nintendo, хотелось бы добиться такого звукового оформления меню, где каждый звук будет нести в себе отдельную тональность, но вместе они создадут гармоничную и цельную мелодию. Это подход, который превращает каждое взаимодействие с меню из простой навигации в приятное музыкальное сопровождение. Такой звуковой подход улучшит общее восприятие игрока и увеличит время, которое он проводит в меню, делая каждый его шаг не просто выбором опций. Тем не менее с учетом всего вышесказанного, понимаю, что это может-быть сложно, потому в первую очередь прошу сосредоточиться на то, что написано выше.
- **Результат?** — Как и было сказано выше, создание одного общего видения для всего вышеперчисленного, но тут добавлю то, что звуковое сопровождение внутри менюшки, должно быть исключительно приятным и гармоничным.

#### **Рекомендации к созданию:**

| Точно да!                                                    | Точно нет!                                                   |
| ------------------------------------------------------------ | :----------------------------------------------------------- |
| Использование простых и функциональных звуковых сигналов, подчеркивающих взаимодействие с "системой". | Избыточно сложные и нагруженные звуковые эффекты, мешающие восприятию. |
| Звуковые сигналы, способствующие усилению ощущения взаимодействия и поддерживающие желание оставаться в игре. | Резкие или громкие звуки, отвлекающие и назойливые. Звуки, которые могут раздражать или вызывать дискомфорт у игрока. |
| Гармоничное сочетание звуков, создающих приятную мелодию в меню. | Звуки, которые радикально не сочетаются между собой и разрушают гармонию. |
| Тональность звуковых сигналов, напоминающая звуковое оформление игр Nintendo. | Монотонные и однообразные звуки, которые не добавляют интерактивности. |
| Звуковой дизайн, имитирующий хакерские программы (аля Watch Dogs 1-2). | Звуки, которые не гармонируют с "цифровым миром" и нарушают стилистическую целостность. |
| Сохранение чёткости и краткости звуков при выборе опций.     | Звуковые эффекты с излишней длительностью или сложностью, которые замедляют восприятие интерфейса и мешают игровому процессу. |





