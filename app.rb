require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require "active_support/all"

# открываем файл url.txt и считываем все в массив url
url = File.readlines("url.txt")

url.each do |adress|
#   puts adress
  begin
      url = URI.parse(URI.encode(adress))
      page = Nokogiri::HTML(open(url))
  rescue OpenURI::HTTPError => e
    puts "Нет доступа к странице, возможно неверный адрес #{url} - #{e.message}"
    next
  end



#PAGE_URL = adress

      #PAGE_URL = "http://feedmed.ru/bolezni/oporno-dvigatelnoi/skolioz-lechenie.html"
      #PAGE_URL = "http://feedmed.ru/about/"
      #page = Nokogiri::HTML(open(PAGE_URL))

      # считаем количество слешей в адресе чтобы прикинуть в подрубрике ли статья, если 4 то в рубрике, если 5 то в подрубрике
      #if (url.to_s.count "/") != 5 
      #  puts "В статье #{adress.strip} не в подрубрике, а в рубрике" 
      #end
      # считаем количество слешей конец

      # считаем количество слов в адресе 3 слова начало
#      m = /(?<adr>\w*-\w*-\w*)/.match(url.to_s)
 #       if m
        #  puts m
#        else
#           puts "В статье #{adress.strip} - адрес составлен не из 3х слов"
#        end
      # считаем количество слов в адресе конец



      # считаем длину титла начало
      #if page.css("title").text.length < 68
      # puts "В статье #{adress.strip} - Длина Seo названия составляет #{page.css("title")[0].text.length} символов, добавьте слов из подзаголовков, чтобы было больше 68 символов"
      #elsif page.css("title").text.length > 75
      # puts "В статье #{adress.strip} - Длина Seo названия составляет #{page.css("title")[0].text.length} символов, уменьшите количество символов до 75"
      #end
      #puts page.css("title")[0].text.length
      #puts page.css("title")[0].text
      # считаем длину титла конец

      # смотрим есть ли точки в заголовке титл начало
      #if page.css("title").text.include? "."   #=> true
      # puts "В статье #{adress.strip} - В Seo названии '#{page.css("title").text}' есть ТОЧКА, ее нужно убрать"
      #end
      # смотрим есть ли точки в заголовке титл конец


       # смотрим есть ли точки в заголовке титл начало
      #if page.css("title").text.include? "?"   #=> true
      # puts "В статье #{adress.strip} - В Seo названии '#{page.css("title").text}' есть ?, его нужно убрать"
      #end
      # смотрим есть ли точки в заголовке титл конец

      # смотрим есть ли повторение слов начало  
      title_clear = page.css("title").text.delete ":,."
      title_clear_split = title_clear.split
      #puts title_clear_split
      error = title_clear_split.select {|e| title_clear_split.count(e) > 1}.uniq

      error.each { |a| puts "В статье #{adress.strip} - В Seo названии '#{page.css("title").text}' дублируется слово '#{a}' - Слова должны использоваться 1 раз" }
      # смотрим есть ли повторение слов конец





      # смотрим есть ли пробелы в подзаголовках начало
      page.css('h2').each do |h2|
        #puts h2.text
        if h2.text.strip.length != h2.text.length
          puts "В статье #{adress.strip} - В подзаголовке '#{h2.text}' есть лишнее пробелы"
        end
      end 
      # смотрим есть ли пробелы в подзаголовках конец

      # смотрим есть ли точки в подзаголовках начало
      page.css('h2').each do |h2|
        #puts h2.text
        if h2.text.include? "."   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть ТОЧКА, ее нужно убрать"
        end
      end 
      # смотрим есть ли точки в подзаголовках конец

      # смотрим есть двойные пробелы в подзаголовке начало
      page.css('h2').each do |h2|
        #puts h2.text
        if h2.text.include? "  "   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть двойной пробел, его нужно убрать"
        end
      end 
      # смотрим есть двойные пробелы в подзаголовке конец

      # смотрим есть ли ()?:! в подзаголовке начало
      page.css('h2').each do |h2|
        #puts h2.text
        if h2.text.include? ")"   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак ')', его нужно убрать"
        end
        if h2.text.include? "("   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак '(', его нужно убрать" 
        end
        if h2.text.include? "?"   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак '?', его нужно убрать"
        end
        if h2.text.include? ":"   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак ':', его нужно убрать" 
        end
        if h2.text.include? ";"   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак ';', его нужно убрать" 
        end
        if h2.text.include? "!"   #=> true
         puts "В статье #{adress.strip} - В подзаголовке h2 '#{h2.text}' есть недопустимых знак '!', его нужно убрать" 
        end
      end 
      # смотрим есть ли ()?:! в подзаголовке  конец



      # считаем количество подзаголовков начало
      h2_count = 0
      page.css('h2').each do |h2|
         # puts h2.text
         h2_count = h2_count + 1
      end

      if h2_count < 6
      # puts "В статье #{adress.strip} - Количество подзаговков h2 #{h2_count} шт, в тексте должно быть больше 5ти подзаголовков"
      elsif h2_count > 9
      # puts "В статье #{adress.strip} - Количество подзаговков h2 #{h2_count} шт, в тексте должно быть меньше 9ти подзаголовков"
      end
      # считаем количество подзаголовков конец

      # считаем количество слов в подзаголовках начало
      page.css('h2').each do |h2|
        if h2.text.scan(/\S+/).size < 3 
      #    puts "В статье #{adress.strip} - Очень короткий подзаголовок '#{h2.text}', всего #{h2.text.scan(/\S+/).size} слова, добавьте к нему слов"
        end
      end
      # считаем количество слов в подзаголовках конец

      # считаем количество стронгов начало
      strong_count = 0
      page.css('strong').each do |strong|
         # puts strong.text
         strong_count = strong_count + 1
      end 

      if strong_count != 2
      # puts "В статье #{adress.strip} - Количество strong #{strong_count} шт, в тексте должно быть ровно 2 strong"
      end
      # считаем количество стронгов конец


      # считаем количество видео начало
      iframe_count = 0
      page.css('iframe').each do |iframe| 
         iframe_count = iframe_count + 1
      end
      if iframe_count != 3
  #     puts "В статье #{adress.strip} - Количество видео #{iframe_count} шт, в тексте должно быть ровно 3 видео"
      end
      # считаем количество видео конец


     # считаем количество картинок начало
      # puts page.css('article img')
      img_count = 0

      page.css('article img').each do |img| 
         img_count = img_count + 1
      end
      # puts page.css('article img') 
      # 1 первая, по 1 для подзаголовка, +5 блок ссылок, -1шт т.к. видео

      # считаем количество подзаголовков (у нас тут 1 подзаголовок это видео -1, возможно один подзаголовок это блок ссылок это -1+5)
      h2_img_count = 0
      page.css('h2').each do |h2|
         h2_img_count = h2_img_count + 1
      end

#4 картинки из 6 подзаголовов + 1 первая + 2 в тексте 

      if (img_count-10) != (h2_img_count+1-2+2)
  #     puts "В статье #{adress.strip} - Количество картинок #{img_count-10} шт, в статье должно быть ровно #{h2_img_count+1-2+2}шт картинок"
      end
      # считаем количество картинок конец


# двойные пробелы в h1 начало
      page.css('h1').each do |h1|
        #puts h2.text
        if h1.text.include? "  "   #=> true
         puts "В статье #{adress.strip} - В заголовке статьи '#{h1.text}' есть двойной пробел, его нужно убрать"
        end
      end 

# двойные пробелы в h1 конец


 # смотрим есть ли точки в h1 начало
      if page.css("h1").text.include? "."   #=> true
       puts "В статье #{adress.strip} - В заголовке статьи '#{page.css("h1").text}' есть ТОЧКА, ее нужно убрать"
      end
 # смотрим есть ли точки в h1 конец





# сео проверка вхождений слов из подзаголовков в Сео название ТИТЛ начало

#добавляем словарь предлогов и союзов для сео названия
title_words_union = ['а','и','но','в','во','для','за','из','к','ко','на','о','не','об','о','от','по','у','через','с','про','при','после','под']
# достаем из title все слова без знаков препинания
      title_clear_seo = page.css("title").text.delete ":,.-?"
      title_clear_split  = title_clear_seo.split
      title_clear_split_seo = title_clear_split - title_words_union

     # error = title_clear_split.select {|e|}.uniq
# получили массив слов из титла
      # puts title_clear_split_seo 
 
# достаем массив слов из всех подзаголовков     
      arr_h2_clear_split_seo =[]
      page.css('h2').each do |h2|
        #puts h2.text
        h2_clear_seo = h2.text.delete ":,.-?"
        #puts h2_clear_seo
        h2_clear_split_seo  = h2_clear_seo.split
        #puts h2_clear_split_seo
        h2_clear_split_seo.each do |h2_word_seo|      
        #puts h2_word_seo.mb_chars.downcase.to_s
          arr_h2_clear_split_seo << h2_word_seo
        end
      end 
# получили массив слов из всех подзаголовков убераем повторы     
      #puts arr_h2_clear_split_seo
      #puts arr_h2_clear_split_seo.inspect
      # проверяем есть ли слова из сео названия в подзаголовках, если нет выдаем ошибку
# puts arr_h2_clear_split_seo.inspect
       title_clear_split_seo.each do |title_word|
        title_word_downcase = title_word.mb_chars.downcase.to_s
       # puts title_word_downcase
         point = 0
         # взяли первое слово из сео названия
           arr_h2_clear_split_seo.each do |h2_word|
             h2_word_downcase = h2_word.mb_chars.downcase.to_s
             #puts h2_word_downcase 
            # берем первое слово по очереди из массива подзаголовков
               # if  h2_word.casecmp(title_word_downcase) == 0
              if h2_word_downcase == title_word_downcase
              # если слово из подзаголовка совпадает со словом из титл, то выходим и запоминаем 1
                 #puts "'#{title_word_downcase}' есть в подзаголовке, как '#{h2_word_downcase}'"
                 point = 1
                 break
              end
            end
         # Если мы ничего так и не запомнили выводим что слова нет в подзаголовках и обнуляем единицу
         if point != 1
 ##         puts "В статье #{adress.strip} слова - '#{title_word}' из сео названия  - нет ни в одном подзаголовке"
         end       
       end
# сео проверка вхождений слов из подзаголовков в Сео название ТИТЛ конец



   
      

# сео проверка в подзаголовках должно быть не более 2х слов из сео ТИТЛА начало
# получили массив слов из титла
      #puts title_clear_split_seo
        arr_title_word_downcase = []
        title_clear_split_seo.each do |title_word|
          title_word_downcase = title_word.mb_chars.downcase.to_s
            arr_title_word_downcase << title_word_downcase
        end
      # puts  arr_title_word_downcase
      # достаем массив слов из всех подзаголовков  
      page.css('h2').each do |h2|
        #puts h2.text
        h2_word_seo_single =[]
        h2_clear_seo = h2.text.delete ":,.-?"
        #puts h2_clear_seo
        h2_clear_split_seo  = h2_clear_seo.split
        # убираем лишние предлоги и местоимения из подзаголовка
        h2_clear_split_seo = h2_clear_split_seo - title_words_union
        #puts h2_clear_split_seo
        h2_clear_split_seo.each do |h2_word_seo| 
          h2_word_seo = h2_word_seo.mb_chars.downcase.to_s            
          h2_word_seo_single << h2_word_seo
        end
        #puts title_clear_seo
        #puts h2_word_seo_single
        # если сео титл минус подзаголовок дает меньше чем положено (а положено титл - 2 слова) тогда ошибка, больше 2х слов писано в подзаголовок из сео названия
        if (arr_title_word_downcase - h2_word_seo_single).count < (arr_title_word_downcase.count-2)
        #  puts "В статье #{adress.strip} - Вписано больше 2х слов в подзаголовок '#{h2.text}' из сео названия"
        end
      end 
# сео проверка в подзаголовках должно быть не более 2х слов из сео ТИТЛА конец


# сео проверка в подзаголовках не должно употреблятся более 1го раза слово из титла начало
# получили массив слов из титла
      #puts title_clear_split_seo 
      # достаем массив слов из всех подзаголовков 

      h2_word_seo_many =[] 
      page.css('h2').each do |h2|
        #puts h2.text
        h2_clear_seo = h2.text.delete ":,.-?"
        #puts h2_clear_seo
        h2_clear_split_seo  = h2_clear_seo.split
        # убираем лишние предлоги и местоимения из подзаголовка
        h2_clear_split_seo = h2_clear_split_seo - title_words_union
        #puts h2_clear_split_seo
        h2_clear_split_seo.each do |h2_word_seo| 
          h2_word_seo = h2_word_seo.mb_chars.downcase.to_s  
          h2_word_seo_many << h2_word_seo
        end
        #puts title_clear_seo
        #puts h2_word_seo_many
      end 
      title_word_arr = []
      # если сео титл минус подзаголовок дает меньше чем положено (а положено титл - 2 слова) тогда ошибка, больше 2х слов писано в подзаголовок из сео названия
      title_clear_split_seo.each do |title_word|
          title_word = title_word.mb_chars.downcase.to_s  
        title_word_arr << title_word
        if (h2_word_seo_many - title_word_arr).count < (h2_word_seo_many.count-1)
        #  puts "В статье #{adress.strip} - В подзаголовках h2 используется слово из Seo названия '#{title_word}' более 1го раза"
        end
         # puts 'все слова ш2'
        #  puts h2_word_seo_many.count
        #  puts 'все слова ш2 минус слово из титла'
        #  puts (h2_word_seo_many - title_word_arr).count

          #puts  (title_clear_split_seo.count)
          title_word_arr = []
      end
        #if (title_clear_split_seo - h2_word_seo_single).count < (title_clear_split_seo.count-2)
        #  puts "В статье #{adress.strip} - Вписано больше 2х слов в подзаголовок '#{h2.text}' из сео названия"
        #end
# сео проверка в подзаголовках не должно употреблятся более 1го раза слово из титла конец





# на страницу добавлена картинка с ссылкой на саму себя начало
       # находим в артикл ссылки и проверемя на картинки ли эти ссылки
      erorr_link_image = page.css('article').css("a").css("img")

      if erorr_link_image.count > 0
         puts "В статье #{adress.strip} - есть одна или несколько картинок сделанных в виде активных ссылок, т.е. на них можно нажимать" 
      end
      # обнулим
        erorr_link_image = ''
# на страницу добавлена картинка с ссылкой на саму себя конец




        # 2k18

# смотрим альт и титл картинки и собираем массив слов из них начало
               #puts page.css('article img')

        # пустой массив для тегов альт и титл
        alt_title_tags  = []

        # пустой массив для тегов альт
        alt_tags  = []
        # собираем все альты на странице с картинок в массив
        alt_tags = page.css('article img').map{ |i| i['alt'] } 
        # вывод массива уникальных слов в альтах
        #puts alt_tags.uniq

        # пустой массив для тегов титл
        title_tags  = []
        # собираем все альты на странице с картинок в массив
        title_tags = page.css('article img').map{ |i| i['title'] } 
        # вывод массива уникальных слов в альтах
        #puts title_tags.uniq
        # общий массив альтов и титлов
        alt_title_tags = alt_tags.uniq + title_tags.uniq
          #puts alt_title_tags.class
        # массив альтов собираем в строку с разбивкой пробел  
          alt_title_tags_j  = alt_title_tags.join(' ')
          # перевод в нижний регистр кириллицы str.mb_chars.downcase.to_s
          #puts alt_title_tags_j.mb_chars.downcase.to_s
          #puts alt_title_tags_j
        # переводим массив слов в нижний регистр, разбиваем на массив и удаляем предлоги
          alt_title_tags_s  = alt_title_tags_j.mb_chars.downcase.to_s.split - title_words_union
         # puts alt_title_tags_s



        # проверяем есть ли списке слов титла, слова из массива альт титл картинки 
               title_clear_split_seo.each do |title_word|
                title_word_downcase = title_word.mb_chars.downcase.to_s
                #puts title_word_downcase
                 point = 0
                 # взяли первое слово из сео названия
                         alt_title_tags_s.each do |alt_title_word|
                         #puts "В статье #{adress.strip} идет проверка АЛЬТ и ТИТЛ"
                          #puts alt_title_word
                           alt_title_word_downcase = alt_title_word.mb_chars.downcase.to_s
                           #puts alt_title_word_downcase
                          # берем первое слово по очереди из массива подзаголовков
                             
                                    if alt_title_word_downcase == title_word_downcase
                                    # если слово из подзаголовка совпадает со словом из титл, то выходим и запоминаем 1
                                      puts "В статье #{adress.strip} - cлово из названия '#{title_word_downcase}' есть в картинке"
                                       point = 1
                                       break
                                    end
                          end
                 # Если мы ничего так и не запомнили выводим что слова нет в подзаголовках и обнуляем единицу
                          if point != 1
                   ##         puts "В статье #{adress.strip} слова - '#{title_word}' из сео названия  - нет ни в одном подзаголовке"
                          end       
               end
# смотрим альт и титл картинки и собираем массив слов из них  конец



# проверям слова паразиты по списку в тексте, есть ли начало


                      #puts page.css('article')

                      # собираем массив из всех слов на странице
                              article_words  = []
                              # собираем все альты на странице с картинок в массив
                              #article_words = page.css('article').split(/ /)
                      #        article_words = page.css('article div p').text.tr(":,.-?+»«"," ").split.uniq
                      # puts article_words

                      article_words = page.css('article div p').text  + page.css('article div ul li').text + page.css('article ol li').text + page.css('article div table').text
                      #puts article_words
                      #puts article_words.class 
                      #puts (article_words.include?('также') ? 'String includes также' : 'String not includes также')
                      #puts (article_words.include?('НПФ') ? 'String includes НПФ' : 'String not includes НПФ')

                      #puts (article_words.mb_chars.downcase.include?('нпф') ? 'Слово #{ddd} есть в тексте' : 'Слова #{ddd} нет в тексте')

                      #добавляем словарь предлогов и союзов для сео названия
                      #article_words_trash = ['а','и','но','в','во','для','за','из','к','ко','на','о','не','об','о','от','по','у','через','с','про','при','после','под']
                      # достаем из title все слова без знаков препинания
                      #      article_words_clear = article_words - article_words_trash

                      article_words_downcase = article_words.mb_chars.downcase
                      #puts article_words_downcase

                      #добавляем словарь предлогов и союзов для сео названия
                      words_trash = ['кроме этого',
                      'кроме того',
                      'таким образом',
                      'также',
                      'при этом',
                      'следует учесть, что',
                      'следует знать, что',
                      'следует помнить, что',
                       'следует учесть что',
                      'следует знать что',
                      'следует помнить что',
                      'в этом случае',
                      'в таком случае',
                      'прежде всего',
                      'после этого',
                      'вполне',
                      'тем не менее',
                      'для того',
                      'так как',
                      #,
                      'помимо этого',
                      'весьма',
                      'какого-либо',
                      'в том случае, если',
                      'в том случае если',
                      'в данном случае',
                      'после того, как',
                      'после того как',
                      'сегодня',
                      'именно',
                      'не редко',
                      'впрочем',
                      'в наше время',
                      'практически',
                      'лучше всего',
                      'в такой ситуации',
                      'в этой ситуации',
                      'на самом деле',
                      'стоит отметить, что',
                      'стоит отметить что'
                      ]
                      #puts words_trash

                      words_trash.each do |words_trash_word|
                       #article_words_downcase.include?(words_trash_word) ? "Слово '#{words_trash_word}' есть в тексте" : "Слова '#{words_trash_word}' нет в тексте"
                        #puts words_trash_word 
                         if article_words_downcase.include?(words_trash_word)
                                                          # проверяем если слово из списка есть в тексте выводим
                                                            puts "В статье #{adress.strip}  - Cлово-паразит '#{words_trash_word}' есть в тексте"
                                                       
                          end
                      end


# проверям слова паразиты по списку в тексте, есть ли конец


# puts "ОХУЕННА !!!!"
      










sleep 1
#puts "---------------------------------------------------------------------------"




end