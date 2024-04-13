// My local
// http://172.16.242.212/1cbase/hs/report/studList?date=20220102

// Production
// http://10.1.1.12/1CKadri/hs/report/studList
// http://10.1.1.12/1CKadri/hs/report/studList?date=20220318
// Authorization: Basic 'ПримерноТакойТокен_vdC40YHRgtGA0LDRgtC+0YA6cTE5NjN3'

Функция СтудентыЗаПериод(НачинаяС)
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтудентыБГЭУ.Ссылка КАК Ссылка,
	               |	СтудентыБГЭУ.Фамилия КАК Фамилия,
	               |	СтудентыБГЭУ.Имя КАК Имя,
	               |	СтудентыБГЭУ.Отчество КАК Отчество,
	               |	СтудентыБГЭУ.Статус КАК Статус,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Группа.Наименование, """") КАК Группа,
	               |	СтудентыБГЭУ.Телефон КАК Телефон,
	               |	СтудентыБГЭУ.email КАК email,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ВыпускающаяКафедра.Наименование, """") КАК Кафедра,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ИзучаемыйЯзык.Наименование, """") КАК ИзучаемыйЯзык,
	               |	ГруппыИнЯз.Подгруппа КАК ПодгруппыПоИнЯз
	               |ИЗ
	               |	Справочник.СтудентыБГЭУ КАК СтудентыБГЭУ
	               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков.Ссылка КАК Ссылка,
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков.НомерПодГруппыПоИнЯзыку КАК Подгруппа
	               |		ИЗ
	               |			Справочник.СтудентыБГЭУ.ИзучаемыеДисциплиныКафедрИнЯзыков КАК СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков
	               |		
	               |		ОБЪЕДИНИТЬ
	               |		
	               |		ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2.Ссылка,
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2.НомерПодГруппыПоИнЯзыку
	               |		ИЗ
	               |			Справочник.СтудентыБГЭУ.ИзучаемыеДисциплиныКафедрИнЯзыков2 КАК СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2) КАК ГруппыИнЯз
	               |		ПО СтудентыБГЭУ.Ссылка = ГруппыИнЯз.Ссылка
	               |ГДЕ
	               |	СтудентыБГЭУ.ДатаИзменения >= &ДатаИзменения
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Фамилия,
	               |	Имя,
	               |	Отчество,
	               |	Группа";
	Запрос.УстановитьПараметр("ДатаИзменения", НачинаяС);
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

Функция ВсеСтуденты()
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтудентыБГЭУ.Ссылка КАК Ссылка,
	               |	СтудентыБГЭУ.Фамилия КАК Фамилия,
	               |	СтудентыБГЭУ.Имя КАК Имя,
	               |	СтудентыБГЭУ.Отчество КАК Отчество,
	               |	СтудентыБГЭУ.Статус КАК Статус,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Группа.Наименование, """") КАК Группа,
	               |	СтудентыБГЭУ.Телефон КАК Телефон,
	               |	СтудентыБГЭУ.email КАК email,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ВыпускающаяКафедра.Наименование, """") КАК Кафедра,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ИзучаемыйЯзык.Наименование, """") КАК ИзучаемыйЯзык,
	               |	ГруппыИнЯз.Подгруппа КАК ПодгруппыПоИнЯз
	               |ИЗ
	               |	Справочник.СтудентыБГЭУ КАК СтудентыБГЭУ
	               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков.Ссылка КАК Ссылка,
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков.НомерПодГруппыПоИнЯзыку КАК Подгруппа
	               |		ИЗ
	               |			Справочник.СтудентыБГЭУ.ИзучаемыеДисциплиныКафедрИнЯзыков КАК СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков
	               |		
	               |		ОБЪЕДИНИТЬ
	               |		
	               |		ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2.Ссылка,
	               |			СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2.НомерПодГруппыПоИнЯзыку
	               |		ИЗ
	               |			Справочник.СтудентыБГЭУ.ИзучаемыеДисциплиныКафедрИнЯзыков2 КАК СтудентыБГЭУИзучаемыеДисциплиныКафедрИнЯзыков2) КАК ГруппыИнЯз
	               |		ПО СтудентыБГЭУ.Ссылка = ГруппыИнЯз.Ссылка
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Фамилия,
	               |	Имя,
	               |	Отчество,
	               |	Группа";
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

Функция СписокСтудентовВJSON(ТЗ)
	Данные = Новый ЗаписьJSON;
	Данные.ПроверятьСтруктуру = Ложь;
	Данные.УстановитьСтроку();

	Инд = 0;
	Граница = ТЗ.Количество();
	Данные.ЗаписатьНачалоМассива();
	Пока Инд < Граница Цикл
		~СледСтуд:
		Данные.ЗаписатьНачалоОбъекта();
		Данные.ЗаписатьИмяСвойства("hexKey");
		УникКлюч = XMLСтрока(ТЗ[Инд].Ссылка);
		Данные.ЗаписатьЗначение(УникКлюч);
		Данные.ЗаписатьИмяСвойства("firstN");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Имя);
		Данные.ЗаписатьИмяСвойства("lastN");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Фамилия);
		Данные.ЗаписатьИмяСвойства("patrnmc");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Отчество);
		Данные.ЗаписатьИмяСвойства("status");
		Данные.ЗаписатьЗначение(Строка(ТЗ[Инд].Статус));
		Данные.ЗаписатьИмяСвойства("group");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Группа);
		Данные.ЗаписатьИмяСвойства("tel");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Телефон);
		Данные.ЗаписатьИмяСвойства("email");
		Данные.ЗаписатьЗначение(ТЗ[Инд].email);
		Данные.ЗаписатьИмяСвойства("dep");
		Данные.ЗаписатьЗначение(ТЗ[Инд].Кафедра);
		Данные.ЗаписатьИмяСвойства("lang");
		Данные.ЗаписатьЗначение(ТЗ[Инд].ИзучаемыйЯзык);
		Данные.ЗаписатьИмяСвойства("langGroup");
		Данные.ЗаписатьНачалоМассива();
		Если ТЗ[Инд].ПодгруппыПоИнЯз <> Null И ТЗ[Инд].ПодгруппыПоИнЯз <> "" Тогда
			Данные.ЗаписатьЗначение(ТЗ[Инд].ПодгруппыПоИнЯз);
		КонецЕсли;

		// Если следующая строка пренадлежит тому же студенту, то дополняем массив групп ИнЯза.
		Для След = Инд + 1 По Граница - 1 Цикл
			Если XMLСтрока(ТЗ[След].Ссылка) = УникКлюч Тогда
				Если ТЗ[След].ПодгруппыПоИнЯз <> Null И ТЗ[След].ПодгруппыПоИнЯз <> "" Тогда
					Данные.ЗаписатьЗначение(ТЗ[След].ПодгруппыПоИнЯз);
				КонецЕсли;
				Продолжить;
			КонецЕсли;
			Инд = След;
			Данные.ЗаписатьКонецМассива();
			Данные.ЗаписатьКонецОбъекта();
			Перейти ~СледСтуд;
		КонецЦикла;
		Данные.ЗаписатьКонецМассива();	// На этом моменте мы дошли до конта ТЗ
		Данные.ЗаписатьКонецОбъекта();
		Прервать;
	КонецЦикла;
	Данные.ЗаписатьКонецМассива();
	Возврат Данные.Закрыть();
КонецФункции

//Post version
Функция СписокСтудентовПолучитьСтудентов(Запрос)
	Сообщение = Запрос.ПолучитьТелоКакСтроку(КодировкаТекста.UTF8);
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(Сообщение);
	Попытка 
		Тело = ПрочитатьJSON(ЧтениеJSON);
		ЧтениеJSON.Закрыть();
	Исключение
		Если ЧтениеJSON <> Неопределено Тогда
			ЧтениеJSON.Закрыть();
		КонецЕсли;
		Ответ = Новый HTTPСервисОтвет(400);
		Ответ.УстановитьТелоИзСтроки("The request body is corrupted. Use the following JSON format: {""date"": ""yyyyuudd""}");
		Возврат Ответ; 
	КонецПопытки;

	СтрДата = Неопределено;
	Если Тело.Свойство("date", СтрДата) Тогда
		Попытка
			НачинаяС = Дата(СтрДата);
		Исключение
			Ответ = Новый HTTPСервисОтвет(400);
			Ответ.УстановитьТелоИзСтроки("Wrong date format. Use {""date"": ""yyyyddmm""} string fot selection by date, or completely remove the ""date"" key for get all students");
			Возврат Ответ;
		КонецПопытки;
		Выборка = СтудентыЗаПериод(НачинаяС);
	Иначе
		Выборка = ВсеСтуденты();
	КонецЕсли;

	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(СписокСтудентовВJSON(Выборка), КодировкаТекста.UTF8);
	Ответ.Заголовки.Вставить("Content-Type","application/json; charset=utf-8");
	Возврат Ответ;
КонецФункции

//Get version
Функция СписокСтудентовПолучить(Запрос)
	стрДата = Запрос.ПараметрыЗапроса.Получить("date");
	Если ПустаяСтрока(стрДата) Тогда
		Выборка = ВсеСтуденты();
	Иначе
		Попытка
			НачинаяС = Дата(стрДата);
		Исключение
			Ответ = Новый HTTPСервисОтвет(400);
			Возврат Ответ;
		КонецПопытки;
		Выборка = СтудентыЗаПериод(НачинаяС);
	КонецЕсли;

	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(СписокСтудентовВJSON(Выборка), КодировкаТекста.UTF8);
	Ответ.Заголовки.Вставить("Content-Type","application/json; charset=utf-8");
	Возврат Ответ;
КонецФункции



// Часть сервиса, отвечающая за передачу данных по студентам для MySQL 
// В БГЭУ существует прога для фото + БД к ней (id + foto). id и прочую инфу она берёт из view mySQL базы.
// Вот именно для этих вьюшек мы накидали этот сервис. JSON парситься на стороне сервера с mySQL. Частота обращей к сервису +- раз в день.
// Сервис пока не запустили, т.к. пока нет разрешения проректора.
Функция ДанныеСтудентовДляФото()
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтудентыБГЭУ.Код КАК Код,
	               |	СтудентыБГЭУ.Статус КАК Статус,
	               |	СтудентыБГЭУ.Наименование КАК Наименование,
	               |	СтудентыБГЭУ.Фамилия КАК Фамилия,
	               |	СтудентыБГЭУ.Имя КАК Имя,
	               |	СтудентыБГЭУ.Отчество КАК Отчество,
	               |	СтудентыБГЭУ.НомерЗачетнойКнижки КАК НомерЗачетнойКнижки,
	               |	СтудентыБГЭУ.НомерПаспорта КАК НомерПаспорта,
	               |	СтудентыБГЭУ.ЛичныйНомер КАК ЛичныйНомер,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Факультет.Код, ""0"") КАК ФакКод,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Факультет.НазваниеФакультета.Наименование, """") КАК Факультет,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ФормаОбучения.Код, ""0"") КАК ФормОбучКод,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ФормаОбучения.Наименование, """") КАК ФормаОбучения,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Курс.КурсЧислом, 0) КАК Курс,
	               |	ЕСТЬNULL(СтудентыБГЭУ.ГодНабора.Наименование, ""0"") КАК ГодНабора,
	               |	СтудентыБГЭУ.Пол КАК Пол,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Специальность.НазваниеСпециальности.Наименование, """") КАК Специальность,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Специальность.Код, ""0"") КАК СпецКод,
	               |	ЕСТЬNULL(СтудентыБГЭУ.Группа.Наименование, """") КАК Группа,
	               |	СтудентыБГЭУ.Гражданство КАК Гражданство,
	               |	ЕСТЬNULL(УчебныйПланСпециальности.ГодВыпуска, """") КАК ГодВыпуска
	               |ИЗ
	               |	Справочник.СтудентыБГЭУ КАК СтудентыБГЭУ
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.УчебныйПланСпециальности КАК УчебныйПланСпециальности
	               |		ПО СтудентыБГЭУ.УчетныйНомерПлана = УчебныйПланСпециальности.УчетныйНомер";
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

Функция ПолучитьJSONСтудентовДляФото()
	ТЗ = ДанныеСтудентовДляФото();
	Данные = Новый ЗаписьJSON;
	Данные.ПроверятьСтруктуру = Ложь;
	Данные.УстановитьСтроку();

	ПеречПолЖенщина = Перечисления.Пол.Женский;
	ПеречСтатусОбуч = Перечисления.СтатусСтудента.Обучается;
	ТекУчебныйГод = Формат(Константы.НачалоУчебногоГода.Получить(), "ЧГ=") + "/" + Формат(Константы.КонецУчебногоГода.Получить(), "ЧГ=");
	Данные.ЗаписатьНачалоМассива();
	Для Каждого СТЗ Из ТЗ Цикл
		Данные.ЗаписатьНачалоОбъекта();
		Данные.ЗаписатьИмяСвойства("rowguid");
		Данные.ЗаписатьЗначение(Число(СТЗ.Код));
		Данные.ЗаписатьИмяСвойства("IsActive");
		Данные.ЗаписатьЗначение(?(СТЗ.Статус = ПеречСтатусОбуч, 1, 0));
		Данные.ЗаписатьИмяСвойства("FIO");
		Данные.ЗаписатьЗначение(СТЗ.Наименование);
		Данные.ЗаписатьИмяСвойства("Name_F");
		Данные.ЗаписатьЗначение(СТЗ.Фамилия);
		Данные.ЗаписатьИмяСвойства("Name_I");
		Данные.ЗаписатьЗначение(СТЗ.Имя);
		Данные.ЗаписатьИмяСвойства("Name_O");
		Данные.ЗаписатьЗначение(СТЗ.Отчество);
		Данные.ЗаписатьИмяСвойства("STDNUM");
		Данные.ЗаписатьЗначение(СТЗ.НомерЗачетнойКнижки);
		Если СТЗ.Гражданство = "Беларусь" И СтрДлина(СТЗ.НомерПаспорта) = 9 Тогда
			Данные.ЗаписатьИмяСвойства("PasportS");
			Данные.ЗаписатьЗначение(Лев(СТЗ.НомерПаспорта, 2));
			Данные.ЗаписатьИмяСвойства("PasportN");
			Данные.ЗаписатьЗначение(Сред(СТЗ.НомерПаспорта, 3, 7));
		Иначе
			Данные.ЗаписатьИмяСвойства("PasportS");
			Данные.ЗаписатьЗначение("");
			Данные.ЗаписатьИмяСвойства("PasportN");
			Данные.ЗаписатьЗначение("");
		КонецЕсли;
		Данные.ЗаписатьИмяСвойства("Passport");
		Данные.ЗаписатьЗначение(СТЗ.НомерПаспорта);
		Данные.ЗаписатьИмяСвойства("PERSID");
		Данные.ЗаписатьЗначение(СТЗ.ЛичныйНомер);
		Данные.ЗаписатьИмяСвойства("idF");
		Данные.ЗаписатьЗначение(Число(СТЗ.ФакКод));
		Данные.ЗаписатьИмяСвойства("FACULTY");
		Данные.ЗаписатьЗначение(СТЗ.Факультет);
		Данные.ЗаписатьИмяСвойства("IdFormaTime");
		Данные.ЗаписатьЗначение(Число(СТЗ.ФормОбучКод));
		Данные.ЗаписатьИмяСвойства("STUDYFORM");
		Данные.ЗаписатьЗначение(СТЗ.ФормаОбучения);
		Данные.ЗаписатьИмяСвойства("COURSE");
		Данные.ЗаписатьЗначение(СТЗ.Курс);
		Данные.ЗаписатьИмяСвойства("YEAR_");
		Если СТЗ.ГодНабора <> "0" Тогда
			Данные.ЗаписатьЗначение(Число(СТЗ.ГодНабора));
			ДатаЗачисления = Формат(Дата(Число(СТЗ.ГодНабора), 09, 01), "ДФ='yyyy-MM-ddTHH:00:00.000Z'");
		Иначе
			Данные.ЗаписатьЗначение(0);
			ДатаЗачисления = "";
		КонецЕсли;
		Данные.ЗаписатьИмяСвойства("Pol");
		Данные.ЗаписатьЗначение(?(СТЗ.Пол = ПеречПолЖенщина, 0, 1));
		Данные.ЗаписатьИмяСвойства("UchYear");
		Данные.ЗаписатьЗначение(ТекУчебныйГод);
		Данные.ЗаписатьИмяСвойства("ISSUEDDATE");
		Данные.ЗаписатьЗначение(?(СТЗ.ГодВыпуска <> "", СТЗ.ГодВыпуска + "-06-01T00:00:00.000Z", ""));
		Данные.ЗаписатьИмяСвойства("DateZach");
		Данные.ЗаписатьЗначение(ДатаЗачисления);
		Данные.ЗаписатьИмяСвойства("GROUP_");
		Данные.ЗаписатьЗначение(СТЗ.Группа);
		Данные.ЗаписатьИмяСвойства("SPECIALITY");
		Данные.ЗаписатьЗначение(СТЗ.Специальность);
		Данные.ЗаписатьИмяСвойства("IDSPECIALITY");
		Данные.ЗаписатьЗначение(Число(СТЗ.СпецКод));
		Данные.ЗаписатьКонецОбъекта();
	КонецЦикла;
	Данные.ЗаписатьКонецМассива();
	Возврат Данные.Закрыть();
КонецФункции
