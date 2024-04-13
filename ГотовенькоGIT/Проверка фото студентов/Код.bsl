&НаКлиенте
Процедура Переименовать(Команда)
	ВсеФото = НайтиФайлы("C:\Users\Admin\Desktop\ФотоСтудентов\", "*.*");
	
	Для Каждого Фото Из ВсеФото Цикл
		ИмяФайла = ПолучитьИмяСГруппой(Фото.ИмяБезРасширения);
		Если ИмяФайла = Неопределено Тогда 
			Сообщить(Фото.ИмяБезРасширения);
			Продолжить;
		КонецЕсли;
		ПереместитьФайл(Фото.ПолноеИмя, "C:\Users\Admin\Desktop\Готово\" + ИмяФайла + ".jpg");
	КонецЦикла;
	Сообщить("Готово");
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьИмяСГруппой(ФИО)
	Студент = Справочники.СтудентыБГЭУ.НайтиПоНаименованию(ФИО, Истина);
	Если Студент.Пустая() Тогда
		Возврат Неопределено;
	Иначе
		Возврат ФорматФИО(ФИО) + " " + Студент.Группа.Наименование;
	КонецЕсли;
КонецФункции

&НаСервереБезКонтекста
Функция ФорматФИО(ФИО)
	Пока Найти(ФИО, "  ") > 0 Цикл
  		Темп = СтрЗаменить(ФИО, "  ", " ");
	КонецЦикла;
	Возврат ТРег(ФИО);
КонецФункции

&НаКлиенте
Процедура Проверить(Команда)
	ВсеФото = НайтиФайлы("C:\Users\Admin\Desktop\Готово\", "*.*");
	
	Для Каждого Фото Из ВсеФото Цикл
		МС = СтрРазделить(Фото.ИмяБезРасширения, " ");
		МС.Удалить(МС.Количество() - 1);
		ФИО = СтрСоединить(МС, " ");
		Если ПроверитьНаСервере(ФИО) Тогда 
			Сообщить(Фото.ИмяБезРасширения);
		КонецЕсли;
	КонецЦикла;
	Сообщить("Готово");
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьНаСервере(ФИО)
	Возврат Справочники.СтудентыБГЭУ.НайтиПоНаименованию(ФИО, Истина,,).Пустая();
КонецФункции

&НаКлиенте
// Функция проверяет фото студентов на соответствие
Процедура ПроверитьНеобработанныеФото(Команда)
	ВсеФото = НайтиФайлы("C:\Users\Admin\Desktop\ФотоСтудентов\", "*.*");
	ЛевыеФотки = Новый Массив();
	МассивСНормальнымиИменами = Новый Массив();
	
	Для Каждого Фото Из ВсеФото Цикл
		МС = СтрРазделить(Фото.ИмяБезРасширения, " ");
		Если МС.Количество() < 2 Тогда
			Сообщить("Что-то пошло не так для " + Фото.ИмяБезРасширения);
			Продолжить;
		КонецЕсли;
		
		Если Найти("0123456789", Лев(МС[МС.Количество() - 1], 1)) > 0 Тогда		// Удаляем номер группы из строки (если таковой есть)
			МС.Удалить(МС.Количество() - 1);	
		КонецЕсли;
		 
		ФИО = СтрСоединить(МС, " ");
		МассивСНормальнымиИменами.Добавить(ФИО);
		Если Не ПроверитьНаСервере(ФИО) Тогда 									// Студент не найден
			ЛевыеФотки.Добавить(Фото.Имя);
		КонецЕсли;
	КонецЦикла;
	
	МС = ПолучитьИменаСтудентовБезФото(МассивСНормальнымиИменами);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьИменаСтудентовБезФото(ВсеФото)
	Мас = Новый Массив();
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтудентыБГЭУ.Наименование КАК Наименование,
	               |	СтудентыБГЭУ.ФИОЛатиницей КАК ФИОЛатиницей,
	               |	СтудентыБГЭУ.Группа КАК Группа,
	               |	СтудентыБГЭУ.ГруппаПоИнЯзыку КАК ГруппаПоИнЯзыку,
	               |	СтудентыБГЭУ.ПодГруупаПоИнЯзыку КАК ПодГруупаПоИнЯзыку
	               |ИЗ
	               |	Справочник.СтудентыБГЭУ КАК СтудентыБГЭУ";
	ТЗ = Запрос.Выполнить().Выгрузить();
	
	Для Каждого Стз Из ТЗ Цикл
		Если ВсеФото.Найти(Стз.Наименование) = Неопределено Тогда
			Мас.Добавить("" + Стз.Наименование + ";" + Стз.Группа);
		КонецЕсли;
	КонецЦикла;
	Возврат Мас;
КонецФункции
