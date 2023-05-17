# geographicAtlas
Internship test work from STRONG team

Здравствуйте! Меня зовут Кенесова Бибисара. README будет разделен на подзаголовки для более удобной ориентации. Проект лежит в этом репозитории на ветке SPMproject

## Видео-демонстрация / Ссылки на GoogleDrive

Переход по координатам
https://drive.google.com/drive/folders/1zi0gcDFzQvkCUuV1bGsLcn_PrjD-5plf?usp=sharing

iPhone 8
https://drive.google.com/file/d/15T3FFsiAT07Xh0MvrB-mwSAUkgYqFpqQ/view?usp=sharing

iPhone13 
https://drive.google.com/file/d/1bIeANAk8IdhBNQ_BIVzKdUSgcDP3F808/view?usp=sharing

iPad
https://drive.google.com/file/d/19uU98_MAcJeXii_pAFXwnnF9Wup4noyk/view?usp=sharing

P.S. Формат видео не указан, поэтому на iPhone8, 13 демонстрация обрезана, чтобы уложиться в time limit, формат mp4. Демонстрация на iPad получилась 14-тисекундной, из-за чего залила на google drive сразу как запись экрана в формате .mov

## Что получилось сделать

Основные требования выполнены полностью. Приложение выполнено программно, Storyboard не использовался, из фреймворков были взяты KingFisher и SnapKit

**Requirements**
1. ✔️The application should be written in Swift language.
2. ✔️3rd party frameworks are allowed, but should not contain too heavy/non-relevant dependencies.
3. ✔️SPM should be used as the dependency manager if any 3rd party frameworks are used.
4. ✔️The application should compile and run without runtime crashes for any user actions.
5. ✔️ The layout should match the design doc without any major discrepancies.
6. ✔️The project code should be placed in the private Github repository.
7. ✔️The Github user named StrongTeamTestAssignmentChecker should be added to this repository to ensure the project access from our side.
8. ✔️The link to any storage (i.e. Google Drive) containing demo video or animation file (.gif) with the running project should be placed in the project repository readme file. Both CountriesList and CountryDetails should be demonstrated in this demo file. The demo video/animation should be 10-15 seconds long.
9. ✔️If any additional features from the “Advanced” section are implemented, it should be demonstrated in the demo video/animation or documented/mentioned explicitly in the project repository readme file. This will ensure that we assess all the additional features and award them with bonus points.

**CountryList and CountryDetails реализованы полностью, без ошибок, поэтому по пунктам проходиться не буду. Кратко опишу как было реализовано** 

✔️**Features CountryList**

Требования выполнены. Заголовок "World countries" реализован через `UINavigationBarAppearance()`. Список стран лежит в TableView, континенты из API используются для sections. Расширяющиеся ячейки TableView реализованы через две UIView, которые положила в UIStackView. Флаг isExpended по дефолту false, лежит в модельку CountryListModel. Меняем на true при использовании ячейки (ячеек, т.к включила метод .allowsMultipleSelection). Данные получаем из https://restcountries.com/v3.1/all 
Переход по кнопку осуществляется через pushViewController, поэтому back автоматический добавляется. 

✔️**Features CountryDetails**

cca2 и name получаем из https://restcountries.com/v3.1/all .
Они должны подгружаться заранее. cca2 для второй модели, чтобы вставлять в ссылку и получать данные из https://restcountries.com/v3.1/alpha/[cca2], name.common для заголовка на VC. Скролл реализован еще одной таблицей. Флаг был оставлен в качестве заголовка секции, потому что tableHeaderView подгружался позднее ячеек (и происходило наслоение). Остальные данные лежат в 7-ми ячейках, которые грузим через switch. Насчет currencies оставила комментарий, что можно их вынести в отдельный swift file, как функцию, потому что она реализована в обоих VC. Не знаю насколько это валидно, поэтому оставила как есть.

## Блок Advanced 

#### Реализовано
For gaining bonus points and increasing your chances the following optional tasks can be implemented:
1. Only one of these bonuses will be applied: 
    - Use programmatic Autolayout (or Autolayout + Snapkit) only - 3 points.
      - SnapKit это те же самые якоря, поэтому немного не поняла что надо было использовать. Констреинты обычно прибиваю SnapKit, использовала его для удобства
2. Use “skeleton views” for all the elements while API requests are performed - 1 point. **Показано в видео (см. предзагрузка вроде показана только в видео на симуляторах iPhone8 и iPad)**
3. Make the UI look and feel good for all the screen sizes including iPads - 2 points. **Thank you, SnapKit (записала видео для iPad)**
4. Make the expand/collapse feature for CountriesList animated, with no UI bugs - 2 points. **на видео видно + код**
5. Add the images caching and reuse them from cache (don’t download any image twice) **немного читинга случилось - kingfisher автоматически кэширует изображения... то вышло не специально, и изначально для получения флагов. Но добавлять отдельные методы для кэша, когда работает фреймворк, не нужно**
6. Use “nice” naming (common readability, self-documenting code) **Не идеально**
7. Follow any of the architectures (MVC, MVVM, VIPER etc.) - 1 point. **архитектура MVC**
8. Write safe code, leave no possibility of crashes (correct optionals, array indices handling etc.) **работает**
9. Make the “Capital coordinates” latitude + longitude value on the CountryDetails screen tappable; on tap open the link obtained from the “maps → openStreetMaps” - 1 point. **реализовала через жест тапа, отдельное демонстрационное видео (переход по координатам). Забыла, его показать на демонстрации, записала сейчас**

#### Не получилось
1. Add basic non-UI tests coverage - 1 point.
2. Add the pushes feature:
  - Make the push notification appear after 1-5 seconds after the app launch - 1 point;
  - The push should contain random country basic info - 1 point; 
  - The user’s tap should be handled by opening the corresponding country’s CountryDetails screen - 1 point.

Очень стыдно, но не получилось. Показывать нечего

## Слабоумие и отвага

И теперь о небольших (~~или больших?~~ шучу^^) недочетах:
1. Проект был сделан на подах и в конце перенесен на SPM (работает, как часы)
2. Некоторые требования по Advanced части выполнить не смогла
3. Заголовок на CountryDetails у кнопки back ни через делегат navigationBar, ни через BarButtonItem.title убрать, к сожалению, не получилось. 
4. Парсинг был через decodable, о чем потом много раз пожалела, так как было невозможно понять какие данные приходят optional... А их было много... Вся Антарктика оказалась мертва, без координат, столиц и остальных плюшек более заселенных и южных стран. В общем, белых ходоков бэкенд не знает  
5. Скорее это плюс, чем минус. API заставил помучиться, очень (о-о-очень) много гуглила. И узнала много нового :) Огромное спасибо за эту возможность как испытать, так и показать себя.



