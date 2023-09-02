
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#КонецЕсли

// Процедура заполняет табличный документ для печати.
//
// Параметры:
//	ТабДок - ТабличныйДокумент - табличный документ для заполнения и печати.
//	Ссылка - Произвольный - содержит ссылку на объект, для которого вызвана команда печати.
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПродажаБилета.Номер,
		|	ПродажаБилета.Дата,
		|	ПродажаБилета.Аттракцион,
		|	ПродажаБилета.СуммаДокумента
		|ИЗ
		|	Документ.ПродажаБилета КАК ПродажаБилета
		|ГДЕ
		|	ПродажаБилета.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	
	ТабДок.Очистить();
	ПараметрыОбласти = Новый Структура;
	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

        ПараметрыОбласти.Вставить("Дата", Формат(Выборка.Дата, "ДЛФ=DD;"));
        ПараметрыОбласти.Вставить("Номер", СервисныеФункции.УбратьПоследовательностьСимволовСлева(СокрЛП(Выборка.Номер),"0"));
       
        
        ОбластьЗаголовок.Параметры.Заполнить(ПараметрыОбласти);
		ТабДок.Вывести(ОбластьЗаголовок);
		
		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());	
		
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
