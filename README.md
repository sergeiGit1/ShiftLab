Тут представлены требования к тестовому заданию

Тестовое задание. iOS
Описание задачи
Для успешного участия в проектах лаборатории, требуется подтвердить минимальные знания и навыки в выбранной вами области. Для этого просим выполнить тестовое задание.
Постановка
Необходимо реализовать приложение с 2-мя экранами. Верстка экранов на ваше усмотрение.
Требования
1. Требуемый стек: Swift, UIKit.
2. Исходный код выполненного задания должен быть размещен в git репозитории
3. Проект должен собираться и запускаться.
4. Будет большим плюсом если вы будете следовать принципам SOLID, Clean Architecture и
придерживаться архитектурного паттерна MVP/MVVM/VIPER.
5. Минимальная версия iOS: 13.0
Экран 1. Регистрация
1. На экране находится 6 элементов:
  1. Поля для ввода имени и фамилии.
  2. Поле для ввода даты рождения.
  3. Поля для ввода пароля и его подтверждения.
  4. Кнопка «Регистрация».
2. «Регистрация» не может быть завершена, пока все данные не будут валидны. Правила для корректных данных придумайте сами. Например, фамилия не может содержать менее двух символов, пароль должен содержать цифры и буквы верхнего регистра, и т.д.
3. Если данные валидны, то переходим на «Главный экран» приложения.
4. Имя пользователя необходимо кэшировать в локальное хранилище (UserDefaults, CoreData и т.п.)
Экран 2. Главный экран
1. На экране 2 элемента:
  1. Динамическая таблица со списком элементов
  2. Кнопка «Приветствие»
2. По нажатию на кнопку появляется модальное окно, в котором находится приветствие пользователя с указанием имени, которое было введено на экране регистрации.
3. При заходе на экран отправляется запрос на сервер для получения элементов таблицы.
4. Список API на выбор (можете выбрать любую):
  1. Спецификация API: https://fakestoreapi.com. Эндпоинт: https://fakestoreapi.com/products. Необходимо отобразить название (title) и цену (price). Остальные     поля можете отображать по желанию.
  2. Спецификация API: https://fakerapi.it/en. Эндпоинт: https://fakerapi.it/api/v1/books. Необходимо отобразить название (title) и автора (author). Остальные поля можете отображать по желанию.
  3. Спецификация API: https://kontests.net/api (могут быть проблемы с доступом). Эндпоинт: https://kontests.net/api/v1/all. Необходимо отобразить название конкурса (name) и временные границы проведения (start_time, end_time). Остальные поля можете отображать по желанию.
      
* Будет плюсом
1. Покрыть логику unit-тестами
2. Сделать выбор даты рождения интерактивным (UIDatePicker)
3. Уведомлять/показывать сообщение о том, где именно была допущена ошибка при «Регистрации».
4. Кнопка «Регистрация» должна быть недоступна для нажатия, пока все поля не будут заполнены
5. Реализовать сохранение сессии: если пользователь единожды прошел регистрацию, то следующий
запуск приложения будет начинаться с главного экрана
