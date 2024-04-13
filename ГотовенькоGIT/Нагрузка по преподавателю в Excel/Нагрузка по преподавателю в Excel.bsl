Простенькая обработка для вывода нагрузки преподавателя в Excel файл.
Указывается ссылка напреподавателя (его ФИО) и путь к папке для сохранения.

************************************************************
		Модуль объекта
************************************************************

&НаСервере
Функция ПолучитьТабДокНагрузки(Сотрудник) Экспорт
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
	ТабДок.АвтоМасштаб = Истина;
	Макет = Обработки.ДляВебСервиса.ПолучитьМакет("Макет");
	
	ОблЗаголовокДоНагрузки = Макет.ПолучитьОбласть("Заголовок|ДоНагрузки");
	ОблШапкаТЧДоНагрузки = Макет.ПолучитьОбласть("ШапкаТЧ|ДоНагрузки");
	ОблЗаголовокДоНагрузки.Параметры.Преподаватель = Сотрудник;
	ТабДок.Вывести(ОблЗаголовокДоНагрузки);
	ТабДок.Вывести(ОблШапкаТЧДоНагрузки);
	
	// До нагрузки все вывели 
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ШаблонПрошлойНагрузки.ФормаОбучения,
	|	ШаблонПрошлойНагрузки.Дисциплина.Наименование Как Дисциплина,
	|	ШаблонПрошлойНагрузки.Кафедра.Наименование Как Кафедра,
	|	ШаблонПрошлойНагрузки.ВидПлана,
	|	ШаблонПрошлойНагрузки.Специальность.Наименование Как Специальность,
	|	ШаблонПрошлойНагрузки.Сем,
	|	ШаблонПрошлойНагрузки.Сотрудник,
	|	ШаблонПрошлойНагрузки.НомераГрупп,
	|	ШаблонПрошлойНагрузки.ЧислоСтудентов,
	|	ШаблонПрошлойНагрузки.ЛкУст,
	|	ШаблонПрошлойНагрузки.ЛБУст,
	|	ШаблонПрошлойНагрузки.ПЗУст,
	|	ШаблонПрошлойНагрузки.Лк,
	|	ШаблонПрошлойНагрузки.ПЗ,
	|	ШаблонПрошлойНагрузки.ЛБ,
	|	ШаблонПрошлойНагрузки.Зач,
	|	ШаблонПрошлойНагрузки.ИПР,
	|	ШаблонПрошлойНагрузки.КП,
	|	ШаблонПрошлойНагрузки.ТР,
	|	ШаблонПрошлойНагрузки.РР,
	|	ШаблонПрошлойНагрузки.КонтрР,
	|	ШаблонПрошлойНагрузки.КР,
	|	ШаблонПрошлойНагрузки.КСР,
	|	ШаблонПрошлойНагрузки.КонсТек + ШаблонПрошлойНагрузки.КонсИнд + ШаблонПрошлойНагрузки.КонсЭкз КАК Консульт,
	|	ШаблонПрошлойНагрузки.Экз,
	|	ШаблонПрошлойНагрузки.ДПиГЭК,
	|	ШаблонПрошлойНагрузки.Практики,
	|	ШаблонПрошлойНагрузки.Снижение,
	|	ШаблонПрошлойНагрузки.ДопНагрузка,
	|	ШаблонПрошлойНагрузки.Аспирантура,
	|	ШаблонПрошлойНагрузки.Магистратура,
	|	ШаблонПрошлойНагрузки.Всего
	|ИЗ
	|	РегистрСведений.ШаблонПрошлойНагрузки КАК ШаблонПрошлойНагрузки
	|ГДЕ
	|	ШаблонПрошлойНагрузки.Сотрудник = &Сотрудник";
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	ТЗ = Запрос.Выполнить().Выгрузить();
	Если ТЗ.Количество() = 0 Тогда
		Возврат Null;
	КонецЕсли;
	
	// Анализируем и формируем массив колонок с заполненными часами нагрузки
	// ТЗ.Итог() Возвращает сумму значений всех строк по указанной колонке. Так мы удаляем пустые колонки
	МассивИменКолонок = Новый Массив;
	ДляУстСессии = Новый Массив;
	Для Каждого Колонка Из ТЗ.Колонки Цикл
		Если ТипЗнч(ТЗ[0][Колонка.Имя]) = Тип("Число") И ТЗ.Итог(Колонка.Имя) > 0 Тогда	
			Если Колонка.Имя = "ЛкУст" Или Колонка.Имя = "ЛБУст" Или Колонка.Имя = "ПЗУст" Тогда
				ДляУстСессии.Добавить(Строка(Колонка.Имя));	
			Иначе
				МассивИменКолонок.Добавить(Строка(Колонка.Имя));
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	// Присоединяем Установочную сессию в Шапку после анализа
	Если ДляУстСессии.Количество() <> 0 Тогда
		ОблШапкаТЧУстановочнаяСессия = Макет.ПолучитьОбласть("ШапкаТЧ|УстановочнаяСессия");
		ТабДок.Присоединить(ОблШапкаТЧУстановочнаяСессия);
	КонецЕсли;
	// Присоединяем Обзорную сессию в Шапку после анализа
	Для Каждого ЭлМассива Из МассивИменКолонок Цикл
		ОблШапкаТЧВидЗанятия = Макет.ПолучитьОбласть("ШапкаТЧ|" + ЭлМассива);
		ТабДок.Присоединить(ОблШапкаТЧВидЗанятия);
	КонецЦикла;
	
	ОблТЧДоНагрузки = Макет.ПолучитьОбласть("ТЧ|ДоНагрузки");
	ОблТЧУстановнаяСессия = Макет.ПолучитьОбласть("ТЧ|УстановочнаяСессия");

	Для Счетчик = 0 По ТЗ.Количество() - 1 Цикл
		ОблТЧДоНагрузки.Параметры.Заполнить(ТЗ[Счетчик]);	
		ТабДок.Вывести(ОблТЧДоНагрузки);
		// присоединяем Установочную сессию в ТабЧасть после анализа
		Если ДляУстСессии.Количество() <> 0 Тогда
			ОблТЧУстановнаяСессия.Параметры.Заполнить(ТЗ[Счетчик]);
			ТабДок.Присоединить(ОблТЧУстановнаяСессия);
		КонецЕсли;
		// присоединяем Обзорную сессию в ТабЧасть после анализа
		Для Каждого ЭлМассива Из МассивИменКолонок Цикл
			ОблТЧ_Нагрузка = Макет.ПолучитьОбласть("ТЧ|" + ЭлМассива);
			ОблТЧ_Нагрузка.Параметры.Заполнить(ТЗ[Счетчик]);
			ТабДок.Присоединить(ОблТЧ_Нагрузка);
		КонецЦикла;
	КонецЦикла;
	Возврат ТабДок;
КонецФункции



************************************************************
		Модуль формы
************************************************************

&НаКлиенте
Процедура ПутьЗаписиФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ИмяФайла = "Файл.XLSX";
	Если Диалог.Выбрать() Тогда
		ПутьЗаписиФайла = Диалог.Каталог + "\" + ИмяФайла;	//Если пользователь не нажал кнопку ОТМЕНА в диалоге
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьФайл(Команда)
	ТабДок = ПолучитьТабДокНагрузкиИзМодуля(Сотрудник);
	Если ТабДок = Null Тогда
		Сообщить("У сотрудника нет нагрузки");
		Возврат;
	КонецЕсли;
	ТабДок.Показать();
	ТабДок.Записать(ПутьЗаписиФайла, ТипФайлаТабличногоДокумента.XLSX);
КонецПроцедуры

&НаСервере
Функция ПолучитьТабДокНагрузкиИзМодуля(Сотрудник)
	ОбъектОбработки = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектОбработки.ПолучитьТабДокНагрузки(Сотрудник); 
КонецФункции